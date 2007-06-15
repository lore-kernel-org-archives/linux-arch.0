Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56593 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496AbXFOJcV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 05:32:21 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Introduce compat_u64 and compat_s64 types
Date: Fri, 15 Jun 2007 11:31:37 +0200
References: <200706150159.l5F1xNgM000459@hera.kernel.org> <1181897905.26853.66.camel@localhost.localdomain> <200706151128.39566.arnd@arndb.de>
In-Reply-To: <200706151128.39566.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200706151131.38429.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

One common problem with 32 bit system call and ioctl emulation
is the different alignment rules between i386 and 64 bit machines.
A number of drivers work around this by marking the compat
structures as 'attribute((packed))', which is not the right
solution because it breaks all the non-x86 architectures that
want to use the same compat code.

Hopefully, this patch improves the situation, it introduces two
new types, compat_u64 and compat_s64. These are defined on all
architectures to have the same size and alignment as the 32 bit
version of u64 and s64.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---

See the discussions about 'Re: drm: fix radeon setparam on
32/64 bit systems.' and 'diskquota: 32bit quota tools on
64bit architectures' about where this comes from.

Index: linux-2.6/include/asm-ia64/compat.h
===================================================================
--- linux-2.6.orig/include/asm-ia64/compat.h
+++ linux-2.6/include/asm-ia64/compat.h
@@ -31,8 +31,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64 __attribute__((aligned(4))) compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64 __attribute__((aligned(4))) compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
Index: linux-2.6/include/asm-mips/compat.h
===================================================================
--- linux-2.6.orig/include/asm-mips/compat.h
+++ linux-2.6/include/asm-mips/compat.h
@@ -37,8 +37,10 @@ typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
Index: linux-2.6/include/asm-parisc/compat.h
===================================================================
--- linux-2.6.orig/include/asm-parisc/compat.h
+++ linux-2.6/include/asm-parisc/compat.h
@@ -31,8 +31,10 @@ typedef s32	compat_timer_t;
 
 typedef s32	compat_int_t;
 typedef s32	compat_long_t;
+typedef s64	compat_s64;
 typedef u32	compat_uint_t;
 typedef u32	compat_ulong_t;
+typedef u64	compat_u64;
 
 struct compat_timespec {
 	compat_time_t		tv_sec;
Index: linux-2.6/include/asm-powerpc/compat.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/compat.h
+++ linux-2.6/include/asm-powerpc/compat.h
@@ -33,8 +33,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
Index: linux-2.6/include/asm-s390/compat.h
===================================================================
--- linux-2.6.orig/include/asm-s390/compat.h
+++ linux-2.6/include/asm-s390/compat.h
@@ -60,8 +60,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
Index: linux-2.6/include/asm-sparc64/compat.h
===================================================================
--- linux-2.6.orig/include/asm-sparc64/compat.h
+++ linux-2.6/include/asm-sparc64/compat.h
@@ -31,8 +31,10 @@ typedef s32		compat_timer_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64		compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64		compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
Index: linux-2.6/include/asm-x86_64/compat.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/compat.h
+++ linux-2.6/include/asm-x86_64/compat.h
@@ -33,8 +33,10 @@ typedef s32		compat_key_t;
 
 typedef s32		compat_int_t;
 typedef s32		compat_long_t;
+typedef s64 __attribute__((aligned(4))) compat_s64;
 typedef u32		compat_uint_t;
 typedef u32		compat_ulong_t;
+typedef u64 __attribute__((aligned(4))) compat_u64;
 
 struct compat_timespec {
 	compat_time_t	tv_sec;
