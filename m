Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:63566 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760750AbcLPK5G (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2016 05:57:06 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 04/13] vfio-pci: use 32-bit comparisons for register address for gcc-4.5
Date: Fri, 16 Dec 2016 11:56:25 +0100
Message-ID: <20161216105634.235457-5-arnd@arndb.de>
In-Reply-To: <20161216105634.235457-1-arnd@arndb.de>
References: <20161216105634.235457-1-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, kernel-build-reports@lists.linaro.org, kvmarm@lists.cs.columbia.edu, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20161216105625.WLfZFwLG4ySWpN9-N_-ylR5rohg7nlE40xUXTyWDMq0@z>

Using ancient compilers (gcc-4.5 or older) on ARM, we get a link
failure with the vfio-pci driver:

ERROR: "__aeabi_lcmp" [drivers/vfio/pci/vfio-pci.ko] undefined!

The reason is that the compiler tries to do a comparison of
a 64-bit range. This changes it to convert to a 32-bit number
explicitly first, as newer compilers do for themselves.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 5ffd1d9ad4bd..357243d76f10 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -193,7 +193,10 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
 	if (!vdev->has_vga)
 		return -EINVAL;
 
-	switch (pos) {
+	if (pos > 0xbfffful)
+		return -EINVAL;
+
+	switch ((u32)pos) {
 	case 0xa0000 ... 0xbffff:
 		count = min(count, (size_t)(0xc0000 - pos));
 		iomem = ioremap_nocache(0xa0000, 0xbffff - 0xa0000 + 1);
-- 
2.9.0

