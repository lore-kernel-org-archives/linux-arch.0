Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:45818 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbfBMRqg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:36 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/8] initramfs: free initrd memory if opening /initrd.image fails
Date: Wed, 13 Feb 2019 18:46:15 +0100
Message-ID: <20190213174621.29297-3-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174615.KC-wASuNC5xfOkzzwpA1JeeJ4Q5qSC9g_AP4ouOC9eM@z>

We free the initrd memory for all successful or error cases except
for the case where opening /initrd.image fails, which looks like an
oversight.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7cea802d00ef..1cba6bbeeb75 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -610,13 +610,12 @@ static int __init populate_rootfs(void)
 		printk(KERN_INFO "Trying to unpack rootfs image as initramfs...\n");
 		err = unpack_to_rootfs((char *)initrd_start,
 			initrd_end - initrd_start);
-		if (!err) {
-			free_initrd();
+		if (!err)
 			goto done;
-		} else {
-			clean_rootfs();
-			unpack_to_rootfs(__initramfs_start, __initramfs_size);
-		}
+
+		clean_rootfs();
+		unpack_to_rootfs(__initramfs_start, __initramfs_size);
+
 		printk(KERN_INFO "rootfs image is not initramfs (%s)"
 				"; looks like an initrd\n", err);
 		fd = ksys_open("/initrd.image",
@@ -630,7 +629,6 @@ static int __init populate_rootfs(void)
 				       written, initrd_end - initrd_start);
 
 			ksys_close(fd);
-			free_initrd();
 		}
 	done:
 		/* empty statement */;
@@ -642,9 +640,9 @@ static int __init populate_rootfs(void)
 			printk(KERN_EMERG "Initramfs unpacking failed: %s\n", err);
 			clean_rootfs();
 		}
-		free_initrd();
 #endif
 	}
+	free_initrd();
 	flush_delayed_fput();
 	return 0;
 }
-- 
2.20.1
