//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Photos/Photos.h>
#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()
    <UINavigationControllerDelegate, UIImagePickerControllerDelegate,
     UITextFieldDelegate>

@property (readwrite, strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *constraintsOfSafeArea;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *nameField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *valueField;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@end

@implementation BNRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Autolayout for iOS before 11
    if ([[[UIDevice currentDevice] systemVersion] compare:@"11" options:NSNumericSearch] == NSOrderedAscending) {
        /* Remove constraints of safe area available only on iOS 11 */
        [self.view removeConstraints:self.constraintsOfSafeArea];
        
        /* Constraints for iOS before 11 */
        [[self.nameLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16] setActive:YES];
        [[self.nameField.topAnchor constraintEqualToAnchor:self.topLayoutGuide.bottomAnchor constant:16] setActive:YES];
        [[self.view.trailingAnchor constraintEqualToAnchor:self.nameField.trailingAnchor constant:16] setActive:YES];
        [[self.toolBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor] setActive:YES];
        [[self.toolBar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor] setActive:YES];
        [[self.toolBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor] setActive:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    // You need an NSDate Formatter taht will turn a date into a simple date string
    static NSDateFormatter *dateFormatter = nil;
    
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    // Use filtered NSDate object to set dateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *imageKey = self.item.itemKey;
    
    // Get the image for its image key from the image store
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:imageKey];
    
    // Use that image to put on the screen in the imageView
    self.imageView.image = imageToDisplay;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // if the device has a camera, take a picuture, otherwise,
    // just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        if (![PHPhotoLibrary authorizationStatus]) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (!status) {
                    NSLog(@"Access to photo library not granted!");
                } else {
                    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                }
            }];
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    
    imagePicker.delegate = self;
    
    // Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store teh image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Take image picker off the screen - you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Others

- (IBAction)backGroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

@end
