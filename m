Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 19 Mar 2005 04:45:03 +0000
From: Matthew Wilcox <matthew@wil.cx>
Subject: [PATCH] Remove spurious BUG from posix-cpu-timers
Message-ID: <20050319044503.GK21986@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: <willy@www.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, Roland McGrath <roland@redhat.com>
List-ID: <linux-arch.vger.kernel.org>


PA-RISC does not necessarily have interrupts disabled while timers are
running.  This doesn't appear to be a requirement, but posix-cpu-timers
seems to think it is.

Signed-off-by: Matthew Wilcox <matthew@wil.cx>

diff -urpNX dontdiff linus-2.6/kernel/posix-cpu-timers.c parisc-2.6/kernel/posix-cpu-timers.c
--- linus-2.6/kernel/posix-cpu-timers.c	2005-03-18 05:55:27.000000000 -0700
+++ parisc-2.6/kernel/posix-cpu-timers.c	2005-03-18 13:52:53.341505966 -0700
@@ -1242,8 +1242,6 @@ void run_posix_cpu_timers(struct task_st
 	LIST_HEAD(firing);
 	struct k_itimer *timer, *next;
 
-	BUG_ON(!irqs_disabled());
-
 #define UNEXPIRED(clock) \
 		(tsk->it_##clock##_expires == 0 || \
 		 cputime_lt(clock##_ticks(tsk), tsk->it_##clock##_expires))

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
