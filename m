From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH 0/3] Add NUMA-awareness to qspinlock
Date: Wed, 30 Jan 2019 22:01:32 -0500
Message-ID: <20190131030136.56999-1-alex.kogan@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA socket as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA sockets. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock.

CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
socket as the current lock holder, and a secondary queue for threads
running on other sockets. Threads record the ID of the socket on which
they are running in their queue nodes. At the unlock time, the lock
holder scans the main queue looking for a thread running on the same
socket. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue.

Full details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 5 runs) of the
total number of ops (x10^7) reported at the end of each run. The stock
kernel is v4.20.0-rc4+ compiled in the default configuration.

#thr  stock  patched speedup (patched/stock)
  1   2.710   2.715  1.002
  2   3.108   3.001  0.966
  4   4.194   3.919  0.934
  8   5.309   6.894  1.299
 16   6.722   9.094  1.353
 32   7.314   9.885  1.352
 36   7.562   9.855  1.303
 72   6.696  10.358  1.547
108   6.364  10.181  1.600
142   6.179  10.178  1.647

When the kernel is compiled with lockstat enabled, CNA 
achieves even larger speedups:

#thr  stock  patched speedup
  1   2.368   2.399  1.013
  2   2.567   2.492  0.970
  4   2.310   2.534  1.097
  8   2.893   4.468  1.544
 16   3.786   5.611  1.482
 32   4.097   5.578  1.362
 36   4.165   5.661  1.359
 72   3.484   5.841  1.677
108   2.890   5.498  1.903
142   2.695   5.356  1.987

This is because lockstat generates writes into shared variables inside the 
critical section to update various stats (e.g., the last CPU on which a
lock was acquired). By keeping the lock local on a socket, CNA reduces the
number of remote cache misses on the access to the lock itself as well as
to the critical section data.

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads (with the kernel compiled in the
default configuration):

#thr  stock patched speedup
  1   0.553   0.579  1.046
  2   0.860   0.907  1.054
  4   1.503   1.533  1.020
  8   1.735   1.704  0.983
 16   1.757   1.744  0.992
 32   0.888   1.705  1.921
 36   0.878   1.746  1.988
 72   0.844   1.766  2.094
108   0.812   1.747  2.150
142   0.804   1.767  2.198

and will-it-scale/lock2_threads:

#thr  stock patched speedup
  1   1.714   1.704  0.994
  2   2.919   2.914  0.998
  4   5.024   5.157  1.027
  8   4.101   3.946  0.962
 16   4.113   3.947  0.959
 32   2.618   4.145  1.583
 36   2.561   3.981  1.554
 72   2.062   4.015  1.947
108   2.157   3.977  1.844
142   1.992   3.916  1.966

As a part of correctness testing, we performed kernel builds on the patched
kernel with X*NCPU parallelism, for X=1,3,5.

Code reviews and performance testing are welcome and appreciated.


Alex Kogan (3):
  locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA

 arch/arm/include/asm/mcs_spinlock.h   |   4 +-
 include/asm-generic/qspinlock_types.h |  10 ++
 kernel/locking/mcs_spinlock.h         |  21 +++-
 kernel/locking/qspinlock.c            | 211 ++++++++++++++++++++++++++++++----
 4 files changed, 218 insertions(+), 28 deletions(-)

-- 
2.11.0 (Apple Git-81)
