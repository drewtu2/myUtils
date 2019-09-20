# Look up where the identifier for your NTFS disk first
# Alternatively you can look it up in "Apple Menu (alt/option) >> System Information >> USB"
`diskutil list`

# Make a directory to you mount your drive
`sudo mkdir /Volumes/usb1`

# Mount the volume in the new location
`sudo mount -t ntfs /dev/disk1s1 /Volumes/usb1/`
