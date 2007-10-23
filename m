Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:53900 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbXJWBHY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Oct 2007 21:07:24 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] irq_flags_t: intro and core annotations
Date: Tue, 23 Oct 2007 03:06:50 +0200
References: <20071020235546.GB1825@martell.zuzino.mipt.ru> <200710222334.45667.arnd@arndb.de> <alpine.LFD.0.9999.0710222344580.3167@localhost.localdomain>
In-Reply-To: <alpine.LFD.0.9999.0710222344580.3167@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710230306.51606.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, matthew@wil.cx, ralf@linux-mips.org, adobriyan@gmail.com, viro@ftp.linux.org.uk, viro@zeniv.linux.org.uk, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-arch.vger.kernel.org>

On Monday 22 October 2007, Thomas Gleixner wrote:
> On Mon, 22 Oct 2007, Arnd Bergmann wrote:
>
> > I tried this as well a few years ago, and I think I hit a few places in
> > the early initialization, but nothing unfixable.
> 
> Hmm, lockdep checks this already. If it does not catch it, we need to fix it.

I've looked at the lockdep code for some time but couldn't find out how
it is trying to catch this kind of bug. AFAICS, there are all sorts of
really complex spinlock/irqflags interaction problems that lockdep checks
for, but not this really simple one ;-)

I tried the trivial annotation below and (with lockdep enabled) got a few
warnings at boot time, but only one that I could still find in the log
buffer:

[   10.298910] WARNING: at /home/arnd/linux/linux-2.6/kernel/signal.c:1799 get_signal_to_deliver()
[   10.298978]  [<c0105218>] show_trace_log_lvl+0x1a/0x2f
[   10.299072]  [<c0105c06>] show_trace+0x12/0x14
[   10.299160]  [<c0105d19>] dump_stack+0x15/0x17
[   10.299248]  [<c0129602>] get_signal_to_deliver+0x73/0x636
[   10.299338]  [<c0103574>] do_notify_resume+0x91/0x728
[   10.299427]  [<c010439c>] work_notifysig+0x13/0x1b

This one looks like in the syscall exit path, after disabling the interrupts,
we call back into a C function that first disables and then enables
interrupts again unconditionally, which seems to do the right thing here,
but still feels wrong.

I suppose lockdep should be extended to catch this kind of bug as well,
instead of the hack I used to find this.

	Arnd <><

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index c376f3b..3ece198 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -207,13 +207,8 @@ do {								\
 
 #endif
 
-#define spin_lock_irq(lock)		_spin_lock_irq(lock)
 #define spin_lock_bh(lock)		_spin_lock_bh(lock)
-
-#define read_lock_irq(lock)		_read_lock_irq(lock)
 #define read_lock_bh(lock)		_read_lock_bh(lock)
-
-#define write_lock_irq(lock)		_write_lock_irq(lock)
 #define write_lock_bh(lock)		_write_lock_bh(lock)
 
 /*
@@ -221,13 +216,25 @@ do {								\
  */
 #if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
 	!defined(CONFIG_SMP)
+# define spin_lock_irq(lock) \
+    do { WARN_ON_ONCE(irqs_disabled()); _spin_lock_irq(lock); } while (0)
+# define read_lock_irq(lock) \
+    do { WARN_ON_ONCE(irqs_disabled()); _read_lock_irq(lock); } while (0)
+# define write_lock_irq(lock) \
+    do { WARN_ON_ONCE(irqs_disabled()); _write_lock_irq(lock); } while (0)
 # define spin_unlock(lock)		_spin_unlock(lock)
 # define read_unlock(lock)		_read_unlock(lock)
 # define write_unlock(lock)		_write_unlock(lock)
-# define spin_unlock_irq(lock)		_spin_unlock_irq(lock)
-# define read_unlock_irq(lock)		_read_unlock_irq(lock)
-# define write_unlock_irq(lock)		_write_unlock_irq(lock)
+# define spin_unlock_irq(lock) \
+    do { WARN_ON_ONCE(!irqs_disabled()); _spin_unlock_irq(lock); } while (0)
+# define read_unlock_irq(lock) \
+    do { WARN_ON_ONCE(!irqs_disabled()); _read_unlock_irq(lock); } while (0)
+# define write_unlock_irq(lock) \
+    do { WARN_ON_ONCE(!irqs_disabled()); _write_unlock_irq(lock); } while (0)
 #else
+# define spin_lock_irq(lock)		_spin_lock_irq(lock)
+# define read_lock_irq(lock)		_read_lock_irq(lock)
+# define write_lock_irq(lock)		_write_lock_irq(lock)
 # define spin_unlock(lock) \
     do {__raw_spin_unlock(&(lock)->raw_lock); __release(lock); } while (0)
 # define read_unlock(lock) \
