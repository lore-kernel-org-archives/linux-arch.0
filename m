From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] Remove #ifdef CONFIG_64BIT from all asm-generic/fcntl.h
Date: Tue,  1 Sep 2015 17:10:10 -0700
Message-ID: <1441152610-22566-1-git-send-email-palmer@dabbelt.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33108 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbbIBRJA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Sep 2015 13:09:00 -0400
Received: by pacex6 with SMTP id ex6so12440566pac.0
        for <linux-arch@vger.kernel.org>; Wed, 02 Sep 2015 10:08:59 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>

From: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>

When working on the RISC-V port I noticed that F_SETLK64 was being
defined on our 64-bit platform, despite our port being so new that
we've only ever had the 64-bit file ops.  Since there's not compat
layer for these, this causes fcntl to bail out.

It turns out that one of the ways in with F_SETLK64 was being defined
(there's some more in glibc, but that's a whole different story... :))
is the result of CONFIG_64BIT showing up in this user-visible header.
<asm-generic/bitsperlong.h> confirms this isn't sane, so I replaced it
with a __BITS_PER_LONG check.

I went ahead and grep'd for any more of these (with
headers_install_all), and this was the only one I found.

Signed-off-by: Palmer Dabbelt <palmer.dabbelt@eecs.berkeley.edu>
Reviewed-by: Andrew Waterman <waterman@eecs.berkeley.edu>
Reviewed-by: Albert Ou <aou@eecs.berkeley.edu>
---
 include/uapi/asm-generic/fcntl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index e063effe0cc1..14a5c8237d84 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_GENERIC_FCNTL_H
 #define _ASM_GENERIC_FCNTL_H
 
+#include <asm/bitsperlong.h>
 #include <linux/types.h>
 
 /*
@@ -115,7 +116,7 @@
 #define F_GETSIG	11	/* for sockets. */
 #endif
 
-#ifndef CONFIG_64BIT
+#if (__BITS_PER_LONG == 32)
 #ifndef F_GETLK64
 #define F_GETLK64	12	/*  using 'struct flock64' */
 #define F_SETLK64	13
-- 
2.4.6
