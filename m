Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47120 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404561AbfBMRqr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:47 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/8] initramfs: cleanup populate_rootfs
Date: Wed, 13 Feb 2019 18:46:18 +0100
Message-ID: <20190213174621.29297-6-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174618.4moHsi_Js_KYGmgzxRxVpHlTfHhdS5oWji1mk_2OtOs@z>

The code for kernels that support ramdisks or not is mostly the
same.  Unify it by using an IS_ENABLED for the info message, and
moving the error message into a stub for populate_initrd_image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index c2e9a8845e98..c55e08f72fad 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -615,6 +615,11 @@ static void populate_initrd_image(char *err)
 		       written, initrd_end - initrd_start);
 	ksys_close(fd);
 }
+#else
+static void populate_initrd_image(char *err)
+{
+	printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
+}
 #endif /* CONFIG_BLK_DEV_RAM */
 
 static int __init populate_rootfs(void)
@@ -623,30 +628,22 @@ static int __init populate_rootfs(void)
 	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
 	if (err)
 		panic("%s", err); /* Failed to decompress INTERNAL initramfs */
-	/* If available load the bootloader supplied initrd */
-	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
-#ifdef CONFIG_BLK_DEV_RAM
+
+	if (!initrd_start || IS_ENABLED(CONFIG_INITRAMFS_FORCE))
+		goto done;
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_RAM))
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (!err)
-			goto done;
+	else
+		printk(KERN_INFO "Unpacking initramfs...\n");
 
+	err = unpack_to_rootfs((char *)initrd_start, initrd_end - initrd_start);
+	if (err) {
 		clean_rootfs();
 		populate_initrd_image(err);
-	done:
-		/* empty statement */;
-#else
-		printk(KERN_INFO "Unpacking initramfs...\n");
-		err = unpack_to_rootfs((char *)initrd_start,
-			initrd_end - initrd_start);
-		if (err) {
-			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
-			clean_rootfs();
-		}
-#endif
 	}
 
+done:
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
-- 
2.20.1
