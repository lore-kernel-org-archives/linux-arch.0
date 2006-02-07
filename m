Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:29357 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932123AbWBGRmG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2006 12:42:06 -0500
Message-Id: <200602071741.k17Hftck007109@shell0.pdx.osdl.net>
Subject: [patch 1/1] Fix spinlock debugging delays to not time out too early
From: akpm@osdl.org
Date: Tue, 07 Feb 2006 09:41:32 -0800
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, ak@muc.de
List-ID: <linux-arch.vger.kernel.org>


From: Ingo Molnar <mingo@elte.hu>

The spinlock-debug wait-loop was using loops_per_jiffy to detect too long
spinlock waits - but on fast CPUs this led to a way too fast timeout and false
messages.

The fix is to include a __delay(1) call in the loop, to correctly approximate
the intended delay timeout of 1 second.  The code assumes that every
architecture implements __delay(1) to last around 1/(loops_per_jiffy*HZ)
seconds.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@muc.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 lib/spinlock_debug.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN lib/spinlock_debug.c~fix-spinlock-debugging-delays-to-not-time-out-too-early lib/spinlock_debug.c
--- devel/lib/spinlock_debug.c~fix-spinlock-debugging-delays-to-not-time-out-too-early	2006-02-07 09:40:57.000000000 -0800
+++ devel-akpm/lib/spinlock_debug.c	2006-02-07 09:40:57.000000000 -0800
@@ -72,9 +72,9 @@ static void __spin_lock_debug(spinlock_t
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_spin_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -144,9 +144,9 @@ static void __read_lock_debug(rwlock_t *
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_read_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
@@ -217,9 +217,9 @@ static void __write_lock_debug(rwlock_t 
 
 	for (;;) {
 		for (i = 0; i < loops_per_jiffy * HZ; i++) {
-			cpu_relax();
 			if (__raw_write_trylock(&lock->raw_lock))
 				return;
+			__delay(1);
 		}
 		/* lockup suspected: */
 		if (print_once) {
_
