From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/8] initramfs: cleanup initrd freeing
Date: Wed, 13 Feb 2019 18:46:16 +0100
Message-ID: <20190213174621.29297-4-hch@lst.de>
References: <20190213174621.29297-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190213174621.29297-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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
