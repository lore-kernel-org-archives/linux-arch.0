From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tools/memory-model 4/4] tools/memory-model: Update: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference
Date: Wed,  7 Mar 2018 09:27:40 -0800
Message-ID: <1520443660-16858-4-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180307172627.GA15805@linux.vnet.ibm.com>
 <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1520443660-16858-1-git-send-email-paulmck@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: mingo@kernel.org, stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

Commit bf28ae562744 ("tools/memory-model: Remove rb-dep,
smp_read_barrier_depends, and lockless_dereference") was accidentally
merged too early, while it was still in RFC form.  This patch adds in
the missing pieces.

Akira pointed out some typos in the original patch, and he noted that
cheatsheet.txt should indicate that READ_ONCE() now implies an address
dependency.  Andrea suggested documenting the relationship betwwen
unsuccessful RMW operations and address dependencies.

Andrea pointed out that the macro for rcu_dereference() in linux.def
should now use the "once" annotation instead of "deref".  He also
suggested that the comments should mention commit 5a8897cc7631
("locking/atomics/alpha: Add smp_read_barrier_depends() to
_release()/_relaxed() atomics") as an important precursor, and he
contributed commit cb13b424e986 ("locking/xchg/alpha: Add
unconditional memory barrier to cmpxchg()"), another prerequisite.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Suggested-by: Akira Yokosawa <akiyks@gmail.com>
Suggested-by: Andrea Parri <parri.andrea@gmail.com>
Fixes: bf28ae562744 ("tools/memory-model: Remove rb-dep, smp_read_barrier_depends, and lockless_dereference")
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Acked-by: Akira Yokosawa <akiyks@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fixed read_read_lock() typo reported by Akira. ]
---
 tools/memory-model/Documentation/cheatsheet.txt  | 6 +++---
 tools/memory-model/Documentation/explanation.txt | 4 ++--
 tools/memory-model/linux-kernel.def              | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/memory-model/Documentation/cheatsheet.txt b/tools/memory-model/Documentation/cheatsheet.txt
index 04e458acd6d4..956b1ae4aafb 100644
--- a/tools/memory-model/Documentation/cheatsheet.txt
+++ b/tools/memory-model/Documentation/cheatsheet.txt
@@ -1,11 +1,11 @@
                                   Prior Operation     Subsequent Operation
                                   ---------------  ---------------------------
                                C  Self  R  W  RWM  Self  R  W  DR  DW  RMW  SV
-                              __  ----  -  -  ---  ----  -  -  --  --  ---  --
+                              --  ----  -  -  ---  ----  -  -  --  --  ---  --
 
 Store, e.g., WRITE_ONCE()            Y                                       Y
-Load, e.g., READ_ONCE()              Y                              Y        Y
-Unsuccessful RMW operation           Y                              Y        Y
+Load, e.g., READ_ONCE()              Y                          Y   Y        Y
+Unsuccessful RMW operation           Y                          Y   Y        Y
 rcu_dereference()                    Y                          Y   Y        Y
 Successful *_acquire()               R                   Y  Y   Y   Y    Y   Y
 Successful *_release()         C        Y  Y    Y     W                      Y
diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index dae8b8cb2ad3..a727c82bd434 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -826,7 +826,7 @@ A-cumulative; they only affect the propagation of stores that are
 executed on C before the fence (i.e., those which precede the fence in
 program order).
 
-read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
+rcu_read_lock(), rcu_read_unlock(), and synchronize_rcu() fences have
 other properties which we discuss later.
 
 
@@ -1138,7 +1138,7 @@ final effect is that even though the two loads really are executed in
 program order, it appears that they aren't.
 
 This could not have happened if the local cache had processed the
-incoming stores in FIFO order.  In constrast, other architectures
+incoming stores in FIFO order.  By contrast, other architectures
 maintain at least the appearance of FIFO order.
 
 In practice, this difficulty is solved by inserting a special fence
diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index 5dfb9c7f3462..397e4e67e8c8 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -13,7 +13,7 @@ WRITE_ONCE(X,V) { __store{once}(X,V); }
 smp_store_release(X,V) { __store{release}(*X,V); }
 smp_load_acquire(X) __load{acquire}(*X)
 rcu_assign_pointer(X,V) { __store{release}(X,V); }
-rcu_dereference(X) __load{deref}(X)
+rcu_dereference(X) __load{once}(X)
 
 // Fences
 smp_mb() { __fence{mb} ; }
-- 
2.5.2
