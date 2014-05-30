Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:51131 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934432AbaE3UKO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2014 16:10:14 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [RFC 27/32] jffs2: convert to struct inode_time
Date: Fri, 30 May 2014 22:01:51 +0200
Message-ID: <1401480116-1973111-28-git-send-email-arnd@arndb.de>
In-Reply-To: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, joseph@codesourcery.com, john.stultz@linaro.org, hch@infradead.org, tglx@linutronix.de, geert@linux-m68k.org, lftan@altera.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org
Message-ID: <20140530200151.xnHnmvmiq6y3JDGFTXxjZrQYbv6itdCxNMbyVBEr4-A@z>

jffs2 uses unsigned 32-bit seconds for inode timestamps, which will work
for the next 92 years, but the VFS uses struct timespec for timestamps,
which is only good until 2038 on 32-bit CPUs.

This gets us one small step closer to lifting the VFS limit by using
struct inode_time in jffs2.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd@lists.infradead.org
---
 fs/jffs2/os-linux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jffs2/os-linux.h b/fs/jffs2/os-linux.h
index d200a9b..64c2dfc 100644
--- a/fs/jffs2/os-linux.h
+++ b/fs/jffs2/os-linux.h
@@ -31,7 +31,7 @@ struct kvec;
 #define JFFS2_F_I_GID(f) (i_gid_read(OFNI_EDONI_2SFFJ(f)))
 #define JFFS2_F_I_RDEV(f) (OFNI_EDONI_2SFFJ(f)->i_rdev)
 
-#define ITIME(sec) ((struct timespec){sec, 0})
+#define ITIME(sec) ((struct inode_time){sec, 0})
 #define I_SEC(tv) ((tv).tv_sec)
 #define JFFS2_F_I_CTIME(f) (OFNI_EDONI_2SFFJ(f)->i_ctime.tv_sec)
 #define JFFS2_F_I_MTIME(f) (OFNI_EDONI_2SFFJ(f)->i_mtime.tv_sec)
-- 
1.8.3.2

