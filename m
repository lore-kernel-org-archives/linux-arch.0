From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 21:08:16 +0100
Message-ID: <20170513200816.GF390@ZenIV.linux.org.uk>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk>
 <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk>
 <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
 <20170513170056.GX390@ZenIV.linux.org.uk>
 <CA+55aFwD+qC7MqSJVt4q91YEJ7CSzAZazWAJ-NpSz=B1k95AuA@mail.gmail.com>
 <20170513180413.GZ390@ZenIV.linux.org.uk>
 <CA+55aFw8RHphGi7kAZdot_PikJGaB=FthHn8Q=1EuCVz=0gd_g@mail.gmail.com>
 <20170513195659.GE390@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754844AbdEMUIS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 16:08:18 -0400
Content-Disposition: inline
In-Reply-To: <20170513195659.GE390@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, May 13, 2017 at 08:56:59PM +0100, Al Viro wrote:

> FWIW, just this cycle (this one I remembered off-hand, there might be
> more):

And looking through my queue (will be pushed to -next as soon as -rc1 goes
out):

commit 87fb4c8c103a4cdf17fead4aba58e96940a19a09
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Apr 20 15:47:34 2017 -0400

    spidev: quit messing with access_ok()
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099baf8c..8dd22de5e3b5 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -254,10 +254,6 @@ static int spidev_message(struct spidev_data *spidev,
 				goto done;
 			}
 			k_tmp->rx_buf = rx_buf;
-			if (!access_ok(VERIFY_WRITE, (u8 __user *)
-						(uintptr_t) u_tmp->rx_buf,
-						u_tmp->len))
-				goto done;
 			rx_buf += k_tmp->len;
 		}
 		if (u_tmp->tx_buf) {
@@ -305,7 +301,7 @@ static int spidev_message(struct spidev_data *spidev,
 	rx_buf = spidev->rx_buffer;
 	for (n = n_xfers, u_tmp = u_xfers; n; n--, u_tmp++) {
 		if (u_tmp->rx_buf) {
-			if (__copy_to_user((u8 __user *)
+			if (copy_to_user((u8 __user *)
 					(uintptr_t) u_tmp->rx_buf, rx_buf,
 					u_tmp->len)) {
 				status = -EFAULT;
@@ -325,8 +321,7 @@ static struct spi_ioc_transfer *
 spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 		unsigned *n_ioc)
 {
-	struct spi_ioc_transfer	*ioc;
-	u32	tmp;
+	u32	size;
 
 	/* Check type, command number and direction */
 	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC
@@ -334,22 +329,15 @@ spidev_get_ioc_message(unsigned int cmd, struct spi_ioc_transfer __user *u_ioc,
 			|| _IOC_DIR(cmd) != _IOC_WRITE)
 		return ERR_PTR(-ENOTTY);
 
-	tmp = _IOC_SIZE(cmd);
+	size = _IOC_SIZE(cmd);
 	if ((tmp % sizeof(struct spi_ioc_transfer)) != 0)
 		return ERR_PTR(-EINVAL);
-	*n_ioc = tmp / sizeof(struct spi_ioc_transfer);
+	*n_ioc = size / sizeof(struct spi_ioc_transfer);
 	if (*n_ioc == 0)
 		return NULL;
 
 	/* copy into scratch area */
-	ioc = kmalloc(tmp, GFP_KERNEL);
-	if (!ioc)
-		return ERR_PTR(-ENOMEM);
-	if (__copy_from_user(ioc, u_ioc, tmp)) {
-		kfree(ioc);
-		return ERR_PTR(-EFAULT);
-	}
-	return ioc;
+	return memdup_user(u_ioc, size);
 }
 
 static long
@@ -367,19 +355,6 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC)
 		return -ENOTTY;
 
-	/* Check access direction once here; don't repeat below.
-	 * IOC_DIR is from the user perspective, while access_ok is
-	 * from the kernel perspective; so they look reversed.
-	 */
-	if (_IOC_DIR(cmd) & _IOC_READ)
-		err = !access_ok(VERIFY_WRITE,
-				(void __user *)arg, _IOC_SIZE(cmd));
-	if (err == 0 && _IOC_DIR(cmd) & _IOC_WRITE)
-		err = !access_ok(VERIFY_READ,
-				(void __user *)arg, _IOC_SIZE(cmd));
-	if (err)
-		return -EFAULT;
-
 	/* guard against device removal before, or while,
 	 * we issue this ioctl.
 	 */
@@ -402,31 +377,31 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* read requests */
 	case SPI_IOC_RD_MODE:
-		retval = __put_user(spi->mode & SPI_MODE_MASK,
+		retval = put_user(spi->mode & SPI_MODE_MASK,
 					(__u8 __user *)arg);
 		break;
 	case SPI_IOC_RD_MODE32:
-		retval = __put_user(spi->mode & SPI_MODE_MASK,
+		retval = put_user(spi->mode & SPI_MODE_MASK,
 					(__u32 __user *)arg);
 		break;
 	case SPI_IOC_RD_LSB_FIRST:
-		retval = __put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
+		retval = put_user((spi->mode & SPI_LSB_FIRST) ?  1 : 0,
 					(__u8 __user *)arg);
 		break;
 	case SPI_IOC_RD_BITS_PER_WORD:
-		retval = __put_user(spi->bits_per_word, (__u8 __user *)arg);
+		retval = put_user(spi->bits_per_word, (__u8 __user *)arg);
 		break;
 	case SPI_IOC_RD_MAX_SPEED_HZ:
-		retval = __put_user(spidev->speed_hz, (__u32 __user *)arg);
+		retval = put_user(spidev->speed_hz, (__u32 __user *)arg);
 		break;
 
 	/* write requests */
 	case SPI_IOC_WR_MODE:
 	case SPI_IOC_WR_MODE32:
 		if (cmd == SPI_IOC_WR_MODE)
-			retval = __get_user(tmp, (u8 __user *)arg);
+			retval = get_user(tmp, (u8 __user *)arg);
 		else
-			retval = __get_user(tmp, (u32 __user *)arg);
+			retval = get_user(tmp, (u32 __user *)arg);
 		if (retval == 0) {
 			u32	save = spi->mode;
 
@@ -445,7 +420,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case SPI_IOC_WR_LSB_FIRST:
-		retval = __get_user(tmp, (__u8 __user *)arg);
+		retval = get_user(tmp, (__u8 __user *)arg);
 		if (retval == 0) {
 			u32	save = spi->mode;
 
@@ -462,7 +437,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case SPI_IOC_WR_BITS_PER_WORD:
-		retval = __get_user(tmp, (__u8 __user *)arg);
+		retval = get_user(tmp, (__u8 __user *)arg);
 		if (retval == 0) {
 			u8	save = spi->bits_per_word;
 
@@ -475,7 +450,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case SPI_IOC_WR_MAX_SPEED_HZ:
-		retval = __get_user(tmp, (__u32 __user *)arg);
+		retval = get_user(tmp, (__u32 __user *)arg);
 		if (retval == 0) {
 			u32	save = spi->max_speed_hz;
 
@@ -525,8 +500,6 @@ spidev_compat_ioc_message(struct file *filp, unsigned int cmd,
 	struct spi_ioc_transfer		*ioc;
 
 	u_ioc = (struct spi_ioc_transfer __user *) compat_ptr(arg);
-	if (!access_ok(VERIFY_READ, u_ioc, _IOC_SIZE(cmd)))
-		return -EFAULT;
 
 	/* guard against device removal before, or while,
 	 * we issue this ioctl.
