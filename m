Return-Path: <SRS0=twat=5M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:35930 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC0XbU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2020 19:31:20 -0400
From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: [RFC][PATCH 11/14] m68k: convert to csum_and_copy_from_user()
Date: Fri, 27 Mar 2020 23:31:14 +0000
Message-ID: <20200327233117.1031393-11-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
References: <20200327233006.GW23230@ZenIV.linux.org.uk>
 <20200327233117.1031393-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20200327233114.fKWGF4dz-1-DwkHmA25PFOR2s0BGHeQyizEdwqUITk8@z>

From: Al Viro <viro@zeniv.linux.org.uk>

trivial access_ok() there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/m68k/include/asm/checksum.h | 3 ++-
 arch/m68k/lib/checksum.c         | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/checksum.h b/arch/m68k/include/asm/checksum.h
index f9b94e4b94f9..3f2c15d6f18c 100644
--- a/arch/m68k/include/asm/checksum.h
+++ b/arch/m68k/include/asm/checksum.h
@@ -30,7 +30,8 @@ __wsum csum_partial(const void *buff, int len, __wsum sum);
  * better 64-bit) boundary
  */
 
-extern __wsum csum_partial_copy_from_user(const void __user *src,
+#define _HAVE_ARCH_COPY_AND_CSUM_FROM_USER
+extern __wsum csum_and_copy_from_user(const void __user *src,
 						void *dst,
 						int len, __wsum sum,
 						int *csum_err);
diff --git a/arch/m68k/lib/checksum.c b/arch/m68k/lib/checksum.c
index 5fa3d392e181..31797be9a3dc 100644
--- a/arch/m68k/lib/checksum.c
+++ b/arch/m68k/lib/checksum.c
@@ -129,7 +129,7 @@ EXPORT_SYMBOL(csum_partial);
  */
 
 __wsum
-csum_partial_copy_from_user(const void __user *src, void *dst,
+csum_and_copy_from_user(const void __user *src, void *dst,
 			    int len, __wsum sum, int *csum_err)
 {
 	/*
@@ -316,7 +316,7 @@ csum_partial_copy_from_user(const void __user *src, void *dst,
 	return(sum);
 }
 
-EXPORT_SYMBOL(csum_partial_copy_from_user);
+EXPORT_SYMBOL(csum_and_copy_from_user);
 
 
 /*
-- 
2.11.0
