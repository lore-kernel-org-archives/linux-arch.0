From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 28/32] adfs: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:52 +0200
Message-ID: <1401480116-1973111-29-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

adfs uses unsigned 40-bit seconds for inode timestamps, which will work
for the next 234 years, but the VFS uses struct timespec for timestamps,
which is only good until 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in adfs.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/adfs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index b9acada..5698b9e 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -167,7 +167,7 @@ adfs_mode2atts(struct super_block *sb, struct inode *inode)
  * of time to convert from RISC OS epoch to Unix epoch.
  */
 static void
-adfs_adfs2unix_time(struct timespec *tv, struct inode *inode)
+adfs_adfs2unix_time(struct inode_time *tv, struct inode *inode)
 {
 	unsigned int high, low;
 	/* 01 Jan 1970 00:00:00 (Unix epoch) as nanoseconds since
@@ -195,7 +195,7 @@ adfs_adfs2unix_time(struct timespec *tv, struct inode *inode)
 	/* convert from RISC OS to Unix epoch */
 	nsec -= nsec_unix_epoch_diff_risc_os_epoch;
 
-	*tv = ns_to_timespec(nsec);
+	*tv = ns_to_inode_time(nsec);
 	return;
 
  cur_time:
-- 
1.8.3.2
