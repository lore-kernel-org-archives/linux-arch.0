From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH memory-model 08/19] tools/memory-model: Fix coding style in 'linux-kernel.def'
Date: Mon, 14 May 2018 16:33:46 -0700
Message-ID: <1526340837-12222-8-git-send-email-paulmck@linux.vnet.ibm.com>
References: <20180514233328.GA7601@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180514233328.GA7601@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, Andrea Parri <andrea.parri@amarulasolutions.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Andrea Parri <andrea.parri@amarulasolutions.com>

This commit fixes white spaces around semicolons.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 tools/memory-model/linux-kernel.def | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/linux-kernel.def b/tools/memory-model/linux-kernel.def
index acf86f6f360a..6bd3bc431b3d 100644
--- a/tools/memory-model/linux-kernel.def
+++ b/tools/memory-model/linux-kernel.def
@@ -17,12 +17,12 @@ rcu_dereference(X) __load{once}(X)
 smp_store_mb(X,V) { __store{once}(X,V); __fence{mb}; }
 
 // Fences
-smp_mb() { __fence{mb} ; }
-smp_rmb() { __fence{rmb} ; }
-smp_wmb() { __fence{wmb} ; }
-smp_mb__before_atomic() { __fence{before-atomic} ; }
-smp_mb__after_atomic() { __fence{after-atomic} ; }
-smp_mb__after_spinlock() { __fence{after-spinlock} ; }
+smp_mb() { __fence{mb}; }
+smp_rmb() { __fence{rmb}; }
+smp_wmb() { __fence{wmb}; }
+smp_mb__before_atomic() { __fence{before-atomic}; }
+smp_mb__after_atomic() { __fence{after-atomic}; }
+smp_mb__after_spinlock() { __fence{after-spinlock}; }
 
 // Exchange
 xchg(X,V)  __xchg{mb}(X,V)
@@ -35,26 +35,26 @@ cmpxchg_acquire(X,V,W) __cmpxchg{acquire}(X,V,W)
 cmpxchg_release(X,V,W) __cmpxchg{release}(X,V,W)
 
 // Spinlocks
-spin_lock(X) { __lock(X) ; }
-spin_unlock(X) { __unlock(X) ; }
+spin_lock(X) { __lock(X); }
+spin_unlock(X) { __unlock(X); }
 spin_trylock(X) __trylock(X)
 
 // RCU
 rcu_read_lock() { __fence{rcu-lock}; }
-rcu_read_unlock() { __fence{rcu-unlock};}
+rcu_read_unlock() { __fence{rcu-unlock}; }
 synchronize_rcu() { __fence{sync-rcu}; }
 synchronize_rcu_expedited() { __fence{sync-rcu}; }
 
 // Atomic
 atomic_read(X) READ_ONCE(*X)
-atomic_set(X,V) { WRITE_ONCE(*X,V) ; }
+atomic_set(X,V) { WRITE_ONCE(*X,V); }
 atomic_read_acquire(X) smp_load_acquire(X)
 atomic_set_release(X,V) { smp_store_release(X,V); }
 
-atomic_add(V,X) { __atomic_op(X,+,V) ; }
-atomic_sub(V,X) { __atomic_op(X,-,V) ; }
-atomic_inc(X)   { __atomic_op(X,+,1) ; }
-atomic_dec(X)   { __atomic_op(X,-,1) ; }
+atomic_add(V,X) { __atomic_op(X,+,V); }
+atomic_sub(V,X) { __atomic_op(X,-,V); }
+atomic_inc(X)   { __atomic_op(X,+,1); }
+atomic_dec(X)   { __atomic_op(X,-,1); }
 
 atomic_add_return(V,X) __atomic_op_return{mb}(X,+,V)
 atomic_add_return_relaxed(V,X) __atomic_op_return{once}(X,+,V)
-- 
2.5.2
