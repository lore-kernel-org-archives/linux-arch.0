Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52271 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753108AbXGPGuG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Jul 2007 02:50:06 -0400
Message-Id: <200707160641.l6G6fBVn014990@imap1.linux-foundation.org>
Subject: [patch 199/268] Introduce compat_u64 and compat_s64 types
From: akpm@linux-foundation.org
Date: Sun, 15 Jul 2007 23:41:11 -0700
Sender: linux-arch-owner@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, arnd@arndb.de, ak@suse.de, benh@kernel.crashing.org, davem@davemloft.net, dwmw2@infradead.org, linux-arch@vger.kernel.org, vtaras@openvz.org
List-ID: <linux-arch.vger.kernel.org>

From: Arnd Bergmann <arnd@arndb.de>

One common problem with 32 bit system call and ioctl emulation is the
different alignment rules between i386 and 64 bit machines.  A number of
drivers work around this by marking the compat structures as
'attribute((packed))', which is not the right solution because it breaks
all the non-x86 architectures that want to use the same compat code.

Hopefully, this patch improves the situation, it introduces two new types,
compat_u64 and compat_s64.  These are defined on all architectures to have
the same size and alignment as the 32 bit version of u64 and s64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: David S. Miller <davem@davemloft.net>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Andi Kleen <ak@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Vasily Tarasov <vtaras@openvz.org>
Cc: <linux-arch@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/asm-ia64/compat.h    |    2 ++
 include/asm-mips/compat.h    |    2 ++
 include/asm-parisc/compat.h  |    2 ++
 include/asm-powerpc/compat.h |    2 ++
 include/asm-s390/compat.h    |    2 ++
 include/asm-sparc64/compat.h |    2 ++
 include/asm-x86_64/compat.h  |    2 ++
 7 files changed, 14 insertions(+)

diff -puN include/asm-ia64/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-ia64/compat.h
--- a/include/asm-ia64/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-ia64/compat.h
@@ -31,8 +31,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64 __attribute__((aligned(4))) compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64 __attribute__((aligned(4))) compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -puN include/asm-mips/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-mips/compat.h
--- a/include/asm-mips/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-mips/compat.h
@@ -37,8 +37,10 @@ typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -puN include/asm-parisc/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-parisc/compat.h
--- a/include/asm-parisc/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-parisc/compat.h
@@ -31,8 +31,10 @@ typedef s32	compat_timer_t;
 
 typedef s32	compat_int_t;
 typedef s32	compat_long_t;
+typedef s64	compat_s64;
 typedef u32	compat_uint_t;
 typedef u32	compat_ulong_t;
+typedef u64	compat_u64;
 
 struct compat_timespec {
 	compat_time_t		tv_sec;
diff -puN include/asm-powerpc/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-powerpc/compat.h
--- a/include/asm-powerpc/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-powerpc/compat.h
@@ -33,8 +33,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -puN include/asm-s390/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-s390/compat.h
--- a/include/asm-s390/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-s390/compat.h
@@ -60,8 +60,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -puN include/asm-sparc64/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-sparc64/compat.h
--- a/include/asm-sparc64/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-sparc64/compat.h
@@ -31,8 +31,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
diff -puN include/asm-x86_64/compat.h~introduce-compat_u64-and-compat_s64-types include/asm-x86_64/compat.h
--- a/include/asm-x86_64/compat.h~introduce-compat_u64-and-compat_s64-types
+++ a/include/asm-x86_64/compat.h
@@ -33,8 +33,10 @@ typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64 __attribute__((aligned(4))) compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64 __attribute__((aligned(4))) compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
_
