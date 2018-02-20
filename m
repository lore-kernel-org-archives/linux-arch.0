Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751975AbeBTXZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Feb 2018 18:25:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1KNNdfE040634
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g8vh7hjcs-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Tue, 20 Feb 2018 18:25:04 -0500
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 20 Feb 2018 18:25:03 -0500
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH RFC tools/lkmm 11/12] tools/memory-model: Convert underscores to hyphens
Date: Tue, 20 Feb 2018 15:25:11 -0800
In-Reply-To: <20180220232405.GA19274@linux.vnet.ibm.com>
References: <20180220232405.GA19274@linux.vnet.ibm.com>
Message-Id: <1519169112-20593-11-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, nborisov@suse.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Typical cat-language code uses hyphens for word separators in
identifiers, but several LKMM identifiers use underscores instead.
This commit therefore converts underscores to hyphens in the .bell-
and .cat-file identifiers corresponding to smp_mb__before_atomic(),
smp_mb__after_atomic(), and smp_mb__after_spinlock().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/linux-kernel.bell | 6 +++---
 tools/memory-model/linux-kernel.cat  | 6 +++---
 tools/memory-model/linux-kernel.def  | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/memory-model/linux-kernel.bell b/tools/memory-model/linux-kernel.bell
index b984bbda01a5..18885ad15de9 100644
--- a/tools/memory-model/linux-kernel.bell
+++ b/tools/memory-model/linux-kernel.bell
@@ -28,9 +28,9 @@ enum Barriers = 'wmb (*smp_wmb*) ||
 		'rcu-lock (*rcu_read_lock*)  ||
 		'rcu-unlock (*rcu_read_unlock*) ||
 		'sync-rcu (*synchronize_rcu*) ||
-		'before_atomic (*smp_mb__before_atomic*) ||
-		'after_atomic (*smp_mb__after_atomic*) ||
-		'after_spinlock (*smp_mb__after_spinlock*)
+		'before-atomic (*smp_mb__before_atomic*) ||
+		'after-atomic (*smp_mb__after_atomic*) ||
+		'after-spinlock (*smp_mb__after_spinlock*)
 instructions F[Barriers]
 
 (* Compute matching pairs of nested Rcu-lock and Rcu-unlock *)
diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index babe2b3b0bb3..f0d27f813ec2 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -29,9 +29,9 @@ let rb-dep = [R] ; fencerel(Rb_dep) ; [R]
 let rmb = [R \ Noreturn] ; fencerel(Rmb) ; [R \ Noreturn]
 let wmb = [W] ; fencerel(Wmb) ; [W]
 let mb = ([M] ; fencerel(Mb) ; [M]) |
-	([M] ; fencerel(Before_atomic) ; [RMW] ; po? ; [M]) |
-	([M] ; po? ; [RMW] ; fencerel(After_atomic) ; [M]) |
-	([M] ; po? ; [LKW] ; fencerel(After_spinlock) ; [M])
+	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
+	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
+	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
 let gp = po ; [Sync-rcu] ; po?
 
 let strong-fence = mb | gp
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index a397387f77cc..f5a1eb04cb64 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -21,9 +21,9 @@ smp_mb() { __fence{mb} ; }
 smp_rmb() { __fence{rmb} ; }
 smp_wmb() { __fence{wmb} ; }
 smp_read_barrier_depends() { __fence{rb_dep}; }
-smp_mb__before_atomic() { __fence{before_atomic} ; }
-smp_mb__after_atomic() { __fence{after_atomic} ; }
-smp_mb__after_spinlock() { __fence{after_spinlock} ; }
+smp_mb__before_atomic() { __fence{before-atomic} ; }
+smp_mb__after_atomic() { __fence{after-atomic} ; }
+smp_mb__after_spinlock() { __fence{after-spinlock} ; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
-- 
2.5.2
