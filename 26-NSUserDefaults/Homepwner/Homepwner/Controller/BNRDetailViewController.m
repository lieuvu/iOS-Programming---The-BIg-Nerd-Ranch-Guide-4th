//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Lieu Vu on 11/29/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

#import <Photos/Photos.h>
#import "BNRAppDelegate.h"
#import "BNRDetailViewController.h"
#import "BNRAssetTypeViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController ()
    <UINavigationControllerDelegate, UIImagePickerControllerDelegate,
     UITextFieldDelegate, UIPopoverPresentationControllerDelegate>

@property (readwrite, strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *constraintsOfSafeArea;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *nameField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (readwrite, weak, nonatomic) IBOutlet UITextField *valueField;
@property (readwrite, weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (readwrite, weak, nonatomic) IBOutlet UIImageView *imageView;
@property (readwrite, weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (readwrite, weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (readwrite, weak, nonatomic) IBOutlet UIBarButtonItem *assetTypeButton;

@end

@implementation BNRDetailViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    
    return nil;
}

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(updateFonts) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    
    return self;
}

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
    self.valueField.text = [NSString stringWithFormat:@"%ld", item.valueInDollars];
    
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

    // Upate title of asset type
    NSString *typeLabel = [self.item.assetType valueForKey:@"label"];
    
    if (!typeLabel) {
        typeLabel = NSLocalizedString(@"None", @"Type label None");
    }
    
    self.assetTypeButton.title = [NSString stringWithFormat:NSLocalizedString(@"Type: %@", @"Asset type button"), typeLabel];
    
    // Update fonts
    [self updateFonts];
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
    
    NSInteger newValue = [self.valueField.text intValue];
    
    // Is it changed?
    if (newValue != item.valueInDollars) {
        
        // Put it in the item
        item.valueInDollars = newValue;
        
        // Store it as the default value for the next item
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:newValue forKey:BNRNextItemValuePrefsKey];
    }
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)updateFonts
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    self.dateLabel.font = font;
    
    self.nameField.font = font;
    self.serialNumberField.font = font;
    self.valueField.font = font;
}

#pragma mark - Actions

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
    // Check for iPad device before instantiating the popover controller
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        
        /* Method 1 */
        // Create a new popover controller that will display the imagePicker
        imagePicker.modalPresentationStyle = UIModalPresentationPopover;
        UIPopoverPresentationController *imagePickerPopover = imagePicker.popoverPresentationController;
        imagePickerPopover.delegate = self;

        // Assign sender to the popover controller, which is the camera bar button item
        imagePickerPopover.barButtonItem = sender;
    }
    
    // Display the controller as a popover on iPad or as a modal on iPhone
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    // If the user cancelled, then remove the BNRItem from the store
    [[BNRItemStore sharedStore] removeItem:self.item];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (IBAction)showAssetTypePicker:(id)sender
{
    [self.view endEditing:YES];
    
    BNRAssetTypeViewController *avc = [[BNRAssetTypeViewController alloc] init];
    avc.item = self.item;
    
    [self.navigationController pushViewController:avc animated:YES];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store the image as thumnail
    [self.item setThumbnailFromImage:image];
    
    // Store the image in the BNRImageStore for this key
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    // Put that image onto the screen in our image view
    self.imageView.image = image;
    
    // Dismiss the popover or modal
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Orientation

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Is it an iPad? No preparation necessary
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        return;
    }
    
    // Will rotate to landscape?
    if (size.width > size.height) {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    } else {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

#pragma mark - Others

- (IBAction)backGroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - NSObject

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

@end
