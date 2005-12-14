Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 14 Dec 2005 13:24:05 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/3] add ->compat_ioctl to dasd
Message-ID: <20051214122405.GA1556@lst.de>
References: <20051213172320.GB16392@lst.de> <1134562034.5496.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1134562034.5496.3.camel@localhost.localdomain>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Dec 14, 2005 at 01:07:14PM +0100, Martin Schwidefsky wrote:
> On Tue, 2005-12-13 at 18:23 +0100, Christoph Hellwig wrote:
> > Add a compat_ioctl method to the dasd driver so the last entries in
> > arch/s390/kernel/compat_ioctl.c can go away.  Unlike the previous
> > attempt this one does not replace the ioctl method with an
> > unlocked_ioctl method so that the ioctl_by_bdev calls in s390 partition
> > code continue to work.
> 
> Looks better but still doesn't work. The dasd driver specific ioctls do
> work but there are some generic ones that are only available on the
> normal ioctl path, including BLKFLSBUF, BLKROSET and HDIO_GETGEO. That
> makes e.g. the 32 bit version of fdasd fail with "IOCTL error".

Sorry, that's the ENOIOCTLCMD thing again, I forgot it in the first
revision of the last patch aswell.

Here's the fix for that:


Index: linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c
===================================================================
--- linux-2.6.15-rc5.orig/drivers/s390/block/dasd_ioctl.c	2005-12-13 18:25:34.000000000 +0100
+++ linux-2.6.15-rc5/drivers/s390/block/dasd_ioctl.c	2005-12-14 13:23:16.000000000 +0100
@@ -127,7 +127,7 @@
 	rval = dasd_ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	unlock_kernel();
 
-	return rval;
+	return (rval == -EINVAL) ? -ENOIOCTLCMD : rval;
 }
 
 static int
