Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Consolidation of asm/unaligned.h
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <20050403210201.6ecd41aa.davem@davemloft.net>
References: <20050317104744.4be7e550.davem@davemloft.net>
	 <1112586161.7087.3.camel@mulgrave>
	 <20050403210201.6ecd41aa.davem@davemloft.net>
Content-Type: text/plain
Date: Sun, 03 Apr 2005 23:15:36 -0500
Message-Id: <1112588136.7087.17.camel@mulgrave>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2005-04-03 at 21:02 -0700, David S. Miller wrote:
> Please explain what you mean by "optimize"?
> 
> If you are saying what I think you're saying (that gcc always
> emits the entire switch statement, not just the constant case
> we need) I bet it has to do with inlining or switch statement
> heuristics.

Precisely.  Our current gcc doesn't optimise away the additional cases
even though sizeof(*ptr) should be a known constant.  One of our
compiler people said they'd take a look at it, but even if they manage
to fix it, we need a current compiler to be able to build the kernel.

> In any event, I'd like to be better informed, because this means
> you're getting terrible code in a lot of places as this is
> a common technique in the kernel header files.

That wouldn't surprise me.  However, all of our other uses of this
technique are in #defines, so this is the first time we've run into the
problem.

> I also don't want to make these macros, since if we do so we lose
> the type checking and we also get into the world of CPP macro arg
> multiple-evaluation crazyness.

Actually, Matthew Wilcox suggested an alternative:  If the inline
function arguments for the size are consts, then the compiler seems to
behave correctly, so how about the attached?

James

===== include/asm-generic/unaligned.h 1.2 vs edited =====
--- 1.2/include/asm-generic/unaligned.h	2005-03-17 15:54:10 -06:00
+++ edited/include/asm-generic/unaligned.h	2005-04-03 23:09:27 -05:00
@@ -76,7 +76,7 @@
 	ptr->x = val;
 }
 
-static inline unsigned long __get_unaligned(const void *ptr, size_t size)
+static inline unsigned long __get_unaligned(const void *ptr, const size_t size)
 {
 	unsigned long val;
 	switch (size) {
@@ -98,7 +98,7 @@
 	return val;
 }
 
-static inline void __put_unaligned(unsigned long val, void *ptr, size_t size)
+static inline void __put_unaligned(unsigned long val, void *ptr, const size_t size)
 {
 	switch (size) {
 	case 1:
===== include/asm-parisc/unaligned.h 1.3 vs edited =====
--- 1.3/include/asm-parisc/unaligned.h	2005-03-17 15:54:10 -06:00
+++ edited/include/asm-parisc/unaligned.h	2005-04-03 16:14:55 -05:00
@@ -1,7 +1,7 @@
 #ifndef _ASM_PARISC_UNALIGNED_H_
 #define _ASM_PARISC_UNALIGNED_H_
 
-#include <asm-parisc/unaligned.h>
+#include <asm-generic/unaligned.h>
 
 #ifdef __KERNEL__
 struct pt_regs;
