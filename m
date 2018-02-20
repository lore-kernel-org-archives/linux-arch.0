Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752000AbeBTXZH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:07 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNOtsq066369
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:07 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g8tdw5wsm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:03 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 12/12] tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference
Date: Tue, 20 Feb 2018 15:25:12 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-12-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

From: Alan Stern <stern@rowland.harvard.edu>

Since commit 76ebbe78f739 ("locking/barriers: Add implicit
smp_read_barrier_depends() to READ_ONCE()") was merged for the 4.15
kernel, it has not been necessary to use smp_read_barrier_depends().
Similarly, commit 59ecbbe7b31c ("locking/barriers: Kill
lockless_dereference()") removed lockless_dereference() from the
kernel.

Since these primitives are no longer part of the kernel, they do not
belong in the Linux Kernel Memory Consistency Model.  This patch
removes them, along with the internal rb-dep relation, and updates the
revelant documentation.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/Documentation/cheatsheet.txt  |  3 +-
 tools/memory-model/Documentation/explanation.txt | 81 +++++++++++++-----------
 tools/memory-model/linux-kernel.bell             |  1 -
 tools/memory-model/linux-kernel.cat              |  7 +-
 tools/memory-model/linux-kernel.def              |  2 -
 5 files changed, 46 insertions(+), 48 deletions(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 1917712bce99..04e458acd6d4 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -6,8 +6,7 @@
 Store, e.g., WRITE_ONCE()            Y                                       Y
 Load, e.g., READ_ONCE()              Y                              Y        Y
 Unsuccessful RMW operation           Y                              Y        Y
-smp_read_barrier_depends()              Y                       Y   Y
-*_dereference()                      Y                          Y   Y        Y
+rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
 smp_rmb()                               Y       R        Y      Y        R
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 867e0ea69b6d..dae8b8cb2ad3 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -1,5 +1,5 @@
-Explanation of the Linux-Kernel Memory Model
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+Explanation of the Linux-Kernel Memory Consistency Model
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 :Author: Alan Stern <stern@rowland.harvard.edu>
 :Created: October 2017
@@ -35,25 +35,24 @@ Explanation of the Linux-Kernel Memory Model
 INTRODUCTION
 ------------
 
-The Linux-kernel memory model (LKMM) is rather complex and obscure.
-This is particularly evident if you read through the linux-kernel.bell
-and linux-kernel.cat files that make up the formal version of the
-memory model; they are extremely terse and their meanings are far from
-clear.
+The Linux-kernel memory consistency model (LKMM) is rather complex and
+obscure.  This is particularly evident if you read through the
+linux-kernel.bell and linux-kernel.cat files that make up the formal
+version of the model; they are extremely terse and their meanings are
+far from clear.
 
 This document describes the ideas underlying the LKMM.  It is meant
-for people who want to understand how the memory model was designed.
-It does not go into the details of the code in the .bell and .cat
-files; rather, it explains in English what the code expresses
-symbolically.
+for people who want to understand how the model was designed.  It does
+not go into the details of the code in the .bell and .cat files;
+rather, it explains in English what the code expresses symbolically.
 
 Sections 2 (BACKGROUND) through 5 (ORDERING AND CYCLES) are aimed
-toward beginners; they explain what memory models are and the basic
-notions shared by all such models.  People already familiar with these
-concepts can skim or skip over them.  Sections 6 (EVENTS) through 12
-(THE FROM_READS RELATION) describe the fundamental relations used in
-many memory models.  Starting in Section 13 (AN OPERATIONAL MODEL),
-the workings of the LKMM itself are covered.
+toward beginners; they explain what memory consistency models are and
+the basic notions shared by all such models.  People already familiar
+with these concepts can skim or skip over them.  Sections 6 (EVENTS)
+through 12 (THE FROM_READS RELATION) describe the fundamental
+relations used in many models.  Starting in Section 13 (AN OPERATIONAL
+MODEL), the workings of the LKMM itself are covered.
 
 Warning: The code examples in this document are not written in the
 proper format for litmus tests.  They don't include a header line, the
@@ -827,8 +826,8 @@ A-cumulative; they only affect the propagation of stores that are
 executed on C before the fence (i.e., those which precede the fence in
 program order).
 
-smp_read_barrier_depends(), rcu_read_lock(), rcu_read_unlock(), and
-synchronize_rcu() fences have other properties which we discuss later.
+read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
+other properties which we discuss later.
 
 
 PROPAGATION ORDER RELATION: cumul-fence
@@ -988,8 +987,8 @@ Another possibility, not mentioned earlier but discussed in the next
 section, is:
 
 	X and Y are both loads, X ->addr Y (i.e., there is an address
-	dependency from X to Y), and an smp_read_barrier_depends()
-	fence occurs between them.
+	dependency from X to Y), and X is a READ_ONCE() or an atomic
+	access.
 
 Dependencies can also cause instructions to be executed in program
 order.  This is uncontroversial when the second instruction is a
@@ -1015,9 +1014,9 @@ After all, a CPU cannot ask the memory subsystem to load a value from
 a particular location before it knows what that location is.  However,
 the split-cache design used by Alpha can cause it to behave in a way
 that looks as if the loads were executed out of order (see the next
-section for more details).  For this reason, the LKMM does not include
-address dependencies between read events in the ppo relation unless an
-smp_read_barrier_depends() fence is present.
+section for more details).  The kernel includes a workaround for this
+problem when the loads come from READ_ONCE(), and therefore the LKMM
+includes address dependencies to loads in the ppo relation.
 
 On the other hand, dependencies can indirectly affect the ordering of
 two loads.  This happens when there is a dependency from a load to a
@@ -1114,11 +1113,12 @@ code such as the following:
 		int *r1;
 		int r2;
 
-		r1 = READ_ONCE(ptr);
+		r1 = ptr;
 		r2 = READ_ONCE(*r1);
 	}
 
-can malfunction on Alpha systems.  It is quite possible that r1 = &x
+can malfunction on Alpha systems (notice that P1 uses an ordinary load
+to read ptr instead of READ_ONCE()).  It is quite possible that r1 = &x
 and r2 = 0 at the end, in spite of the address dependency.
 
 At first glance this doesn't seem to make sense.  We know that the
@@ -1141,11 +1141,15 @@ This could not have happened if the local cache had processed the
 incoming stores in FIFO order.  In constrast, other architectures
 maintain at least the appearance of FIFO order.
 
-In practice, this difficulty is solved by inserting an
-smp_read_barrier_depends() fence between P1's two loads.  The effect
-of this fence is to cause the CPU not to execute any po-later
-instructions until after the local cache has finished processing all
-the stores it has already received.  Thus, if the code was changed to:
+In practice, this difficulty is solved by inserting a special fence
+between P1's two loads when the kernel is compiled for the Alpha
+architecture.  In fact, as of version 4.15, the kernel automatically
+adds this fence (called smp_read_barrier_depends() and defined as
+nothing at all on non-Alpha builds) after every READ_ONCE() and atomic
+load.  The effect of the fence is to cause the CPU not to execute any
+po-later instructions until after the local cache has finished
+processing all the stores it has already received.  Thus, if the code
+was changed to:
 
 	P1()
 	{
@@ -1153,13 +1157,15 @@ the stores it has already received.  Thus, if the code was changed to:
 		int r2;
 
 		r1 = READ_ONCE(ptr);
-		smp_read_barrier_depends();
 		r2 = READ_ONCE(*r1);
 	}
 
 then we would never get r1 = &x and r2 = 0.  By the time P1 executed
 its second load, the x = 1 store would already be fully processed by
-the local cache and available for satisfying the read request.
+the local cache and available for satisfying the read request.  Thus
+we have yet another reason why shared data should always be read with
+READ_ONCE() or another synchronization primitive rather than accessed
+directly.
 
 The LKMM requires that smp_rmb(), acquire fences, and strong fences
 share this property with smp_read_barrier_depends(): They do not allow
@@ -1751,11 +1757,10 @@ no further involvement from the CPU.  Since the CPU doesn't ever read
 the value of x, there is nothing for the smp_rmb() fence to act on.
 
 The LKMM defines a few extra synchronization operations in terms of
-things we have already covered.  In particular, rcu_dereference() and
-lockless_dereference() are both treated as a READ_ONCE() followed by
-smp_read_barrier_depends() -- which also happens to be how they are
-defined in include/linux/rcupdate.h and include/linux/compiler.h,
-respectively.
+things we have already covered.  In particular, rcu_dereference() is
+treated as READ_ONCE() and rcu_assign_pointer() is treated as
+smp_store_release() -- which is basically how the Linux kernel treats
+them.
 
 There are a few oddball fences which need special treatment:
 smp_mb__before_atomic(), smp_mb__after_atomic(), and
diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index 18885ad15de9..432c7cf71b23 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -24,7 +24,6 @@ instructions RMW[{'once,'acquire,'release}]
 enum Barriers = 'wmb (*smp_wmb*) ||
 		'rmb (*smp_rmb*) ||
 		'mb (*smp_mb*) ||
-		'rb_dep (*smp_read_barrier_depends*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index f0d27f813ec2..df97db03b6c2 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -25,7 +25,6 @@ include "lock.cat"
 (*******************)
 
 (* Fences *)
-let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
 let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
@@ -61,11 +60,9 @@ let dep = addr | data
 let rwdep = (dep | ctrl) ; [W]
 let overwrite = co | fr
 let to-w = rwdep | (overwrite & int)
-let rrdep = addr | (dep ; rfi)
-let strong-rrdep = rrdep+ & rb-dep
-let to-r = strong-rrdep | rfi-rel-acq
+let to-r = addr | (dep ; rfi) | rfi-rel-acq
 let fence = strong-fence | wmb | po-rel | rmb | acq-po
-let ppo = rrdep* ; (to-r | to-w | fence)
+let ppo = to-r | to-w | fence
 
 (* Propagation: Ordering from release operations and strong fences. *)
 let A-cumul(r) = rfe? ; r
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index f5a1eb04cb64..5dfb9c7f3462 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -13,14 +13,12 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
 smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
-lockless_dereference(X) __load{lderef}(X)
 rcu_dereference(X) __load{deref}(X)
 
 // Fences
 smp_mb() { __fence{mb} ; }
 smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
-smp_read_barrier_depends() { __fence{rb_dep}; }
 smp_mb__before_atomic() { __fence{before-atomic} ; }
 smp_mb__after_atomic() { __fence{after-atomic} ; }
 smp_mb__after_spinlock() { __fence{after-spinlock} ; }
-- 
2.5.2
