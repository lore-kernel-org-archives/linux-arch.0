Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 29 May 2005 04:39:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Lots of possible arch breakage in cpu_idle!!
Message-ID: <20050529113942.GB20782@holomorphy.com>
References: <4299523F.90502@yahoo.com.au> <20050529084541.GL2057@holomorphy.com> <42999381.2070800@yahoo.com.au> <20050529101314.GN2057@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050529101314.GN2057@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

On Sun, May 29, 2005 at 08:03:45PM +1000, Nick Piggin wrote:
>> Hmm, it is against the latest -mm, with a couple of patches
>> backed out and one or two others applied :P
>> If you are just interested in looking at the arch code, I think
>> that should apply to any recent tree.
>> Otherwise, let me know off list.

On Sun, May 29, 2005 at 03:13:14AM -0700, William Lee Irwin III wrote:
> I'm only going to fiddle with the sparc32 bits.

Here's what I'd like to see in arch/sparc. Minor differences only.


Index: linux-2.6/arch/sparc/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/sparc/kernel/process.c	2005-05-29 02:28:32.831865959 -0700
+++ linux-2.6/arch/sparc/kernel/process.c	2005-05-29 02:50:06.989124151 -0700
@@ -67,13 +67,6 @@
 struct task_struct *last_task_used_math = NULL;
 struct thread_info *current_set[NR_CPUS];
 
-/*
- * default_idle is new in 2.5. XXX Review, currently stolen from sparc64.
- */
-void default_idle(void)
-{
-}
-
 #ifndef CONFIG_SMP
 
 #define SUN4C_FAULT_HIGH 100
@@ -116,11 +109,15 @@
 			local_irq_restore(flags);
 		}
 
-		while((!need_resched()) && pm_idle) {
-			(*pm_idle)();
-		}
-
+		if (pm_idle)
+			while(!need_resched())
+				(*pm_idle)();
+		else
+			while (!need_resched())
+				cpu_relax();
+		preempt_enable_no_resched();
 		schedule();
+		preempt_disable();
 		check_pgt_cache();
 	}
 }
@@ -130,13 +127,15 @@
 /* This is being executed in task 0 'user space'. */
 void cpu_idle(void)
 {
+	set_thread_flag(TIF_POLLING_NRFLAG);
 	/* endless idle loop with no priority at all */
 	while(1) {
-		if(need_resched()) {
-			schedule();
-			check_pgt_cache();
-		}
-		barrier(); /* or else gcc optimizes... */
+		while (!need_resched())
+			cpu_relax();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+		check_pgt_cache();
 	}
 }
 
