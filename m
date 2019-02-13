Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:46364 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404554AbfBMRql (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2019 12:46:41 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/8] initramfs: cleanup initrd freeing
Date: Wed, 13 Feb 2019 18:46:16 +0100
Message-ID: <20190213174621.29297-4-hch@lst.de>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190213174616.yJjPGWCERITcIZZOU625-hFHiuN4rOrdQOTWMfkl_N0@z>

Factor the kexec logic into a separate helper, and then inline the
rest of free_initrd into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/initramfs.c | 53 +++++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 1cba6bbeeb75..6c2ed1d7276e 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -518,37 +518,35 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
-static void __init free_initrd(void)
-{
 #ifdef CONFIG_KEXEC_CORE
+static bool kexec_free_initrd(void)
+{
 	unsigned long crashk_start = (unsigned long)__va(crashk_res.start);
 	unsigned long crashk_end   = (unsigned long)__va(crashk_res.end);
-#endif
-	if (do_retain_initrd)
-		goto skip;
 
-#ifdef CONFIG_KEXEC_CORE
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
 	 */
-	if (initrd_start < crashk_end && initrd_end > crashk_start) {
-		/*
-		 * Initialize initrd memory region since the kexec boot does
-		 * not do.
-		 */
-		memset((void *)initrd_start, 0, initrd_end - initrd_start);
-		if (initrd_start < crashk_start)
-			free_initrd_mem(initrd_start, crashk_start);
-		if (initrd_end > crashk_end)
-			free_initrd_mem(crashk_end, initrd_end);
-	} else
-#endif
-		free_initrd_mem(initrd_start, initrd_end);
-skip:
-	initrd_start = 0;
-	initrd_end = 0;
+	if (initrd_start >= crashk_end || initrd_end <= crashk_start)
+		return false;
+
+	/*
+	 * Initialize initrd memory region since the kexec boot does not do.
+	 */
+	memset((void *)initrd_start, 0, initrd_end - initrd_start);
+	if (initrd_start < crashk_start)
+		free_initrd_mem(initrd_start, crashk_start);
+	if (initrd_end > crashk_end)
+		free_initrd_mem(crashk_end, initrd_end);
+	return true;
 }
+#else
+static inline bool kexec_free_initrd(void)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_CORE */
 
 #define BUF_SIZE 1024
 static void __init clean_rootfs(void)
@@ -642,7 +640,16 @@ static int __init populate_rootfs(void)
 		}
 #endif
 	}
-	free_initrd();
+
+	/*
+	 * If the initrd region is overlapped with crashkernel reserved region,
+	 * free only memory that is not part of crashkernel region.
+	 */
+	if (!do_retain_initrd && !kexec_free_initrd())
+		free_initrd_mem(initrd_start, initrd_end);
+	initrd_start = 0;
+	initrd_end = 0;
+
 	flush_delayed_fput();
 	return 0;
 }
-- 
2.20.1
