Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46552 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391128AbfBMRqn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:43 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/8] initramfs: factor out a helper to populate the initrd image
Date: Wed, 13 Feb 2019 18:46:17 +0100
Message-ID: <20190213174621.29297-5-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174617.s7B1T2H_pTsVzkFG30llU5lcaDjrt-b2774bzGVYKbQ@z>

This will allow for cleaner code sharing in the caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 6c2ed1d7276e..c2e9a8845e98 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -595,6 +595,28 @@ static void __init clean_rootfs(void)
 	kfree(buf);
 }
 
+#ifdef CONFIG_BLK_DEV_RAM
+static void populate_initrd_image(char *err)
+{
+	ssize_t written;
+	int fd;
+
+	unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
+	printk(KERN_INFO "rootfs image is not initramfs (%s); looks like an initrd\n",
+			err);
+	fd = ksys_open("/initrd.image", O_WRONLY | O_CREAT, 0700);
+	if (fd < 0)
+		return;
+
+	written = xwrite(fd, (char *)initrd_start, initrd_end - initrd_start);
+	if (written != initrd_end - initrd_start)
+		pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
+		       written, initrd_end - initrd_start);
+	ksys_close(fd);
+}
+#endif /* CONFIG_BLK_DEV_RAM */
+
 static int __init populate_rootfs(void)
 {
 	/* Load the built in initramfs */
@@ -604,7 +626,6 @@ static int __init populate_rootfs(void)
 	/* If available load the bootloader supplied initrd */
 	if (initrd_start && !IS_ENABLED(CONFIG_INITRAMFS_FORCE)) {
 #ifdef CONFIG_BLK_DEV_RAM
-		int fd;
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
@@ -612,22 +633,7 @@ static int __init populate_rootfs(void)
 			goto done;
 
 		clean_rootfs();
-		unpack_to_rootfs(__initramfs_start, __initramfs_size);
-
-		printk(KERN_INFO "rootfs image is not initramfs (%s)"
-				"; looks like an initrd\n", err);
-		fd = ksys_open("/initrd.image",
-			      O_WRONLY|O_CREAT, 0700);
-		if (fd >= 0) {
-			ssize_t written = xwrite(fd, (char *)initrd_start,
-						initrd_end - initrd_start);
-
-			if (written != initrd_end - initrd_start)
-				pr_err("/initrd.image: incomplete write (%zd != %ld)\n",
-				       written, initrd_end - initrd_start);
-
-			ksys_close(fd);
-		}
+		populate_initrd_image(err);
 	done:
 		/* empty statement */;
 #else
-- 
2.20.1
