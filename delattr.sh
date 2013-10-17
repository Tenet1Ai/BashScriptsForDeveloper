#!/bin/bash
xattr -d -r com.apple.FinderInfo *
xattr -d -r com.apple.TextEncoding *
xattr -d -r com.apple.ResourceFork *
xattr -d -r com.apple.quarantine *
xattr -d -r com.apple.metadata:kMDItemWhereFroms *
xattr -d -r com.apple.metadata:kMDItemDownloadedDate *
xattr -d -r com.apple.metadata:kMDItemFinderComment *
xattr -d -r com.apple.metadata:kMDItemScreenCaptureType *
xattr -d -r com.apple.metadata:kMDItemIsScreenCapture *
ls -l@
