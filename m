From: "H. Peter Anvin" <hpa@linux.intel.com>
Subject: [PATCH] asm-generic: Use __BITS_PER_LONG in statfs.h
Date: Thu, 26 Apr 2012 11:45:16 -0700
Message-ID: <1335465916-16965-1-git-send-email-hpa@linux.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:6468 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752598Ab2DZSpX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Apr 2012 14:45:23 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hpa@zytor.com, "H. Peter Anvin" <hpa@linux.intel.com>

From: "H. Peter Anvin" <hpa@linux.intel.com>

<asm-generic/statfs.h> is exported to userspace, so using
BITS_PER_LONG is invalid.  We need to use __BITS_PER_LONG instead.

This is kernel bugzilla 43165.

Reported-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
---
 include/asm-generic/statfs.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/statfs.h b/include/asm-generic/statfs.h
index 0fd28e0..c749af9 100644
--- a/include/asm-generic/statfs.h
+++ b/include/asm-generic/statfs.h
@@ -15,7 +15,7 @@ typedef __kernel_fsid_t	fsid_t;
  * with a 10' pole.
  */
 #ifndef __statfs_word
-#if BITS_PER_LONG == 64
+#if __BITS_PER_LONG == 64
 #define __statfs_word long
 #else
 #define __statfs_word __u32
-- 
1.7.6.5
