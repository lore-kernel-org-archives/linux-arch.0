Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:41590 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbfC2PVY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2019 11:21:24 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v2 0/5] Add NUMA-awareness to qspinlock
Date: Fri, 29 Mar 2019 11:20:01 -0400
Message-ID: <20190329152006.110370-1-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190329152001.BQbUPmAFEvnlHKjcQ-7aljIdHGEKZQPAhPyXYKi4_KM@z>

This version addresses feedback from Peter and Waiman. In particular,
the CNA functionality has been moved to a separate file, and is controlled
by a config option (enabled by default if NUMA is enabled). 
An optimization has been introduced to reduce the overhead of shuffling 
threads between waiting queues when the lock is only lightly contended.

Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It can be 
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS spin-lock. Spinning threads are
organized in two queues, a main queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. At the unlock time, the lock
holder scans the main queue looking for a thread running on the same
node. If found (call it thread T), all threads in the main queue
between the current lock holder and T are moved to the end of the
secondary queue, and the lock is passed to T. If such T is not found, the
lock is passed to the first node in the secondary queue. Finally, if the
secondary queue is empty, the lock is passed to the next thread in the
main queue. To avoid starvation of threads in the secondary queue,
those threads are moved back to the head of the main queue
after a certain expected number of intra-node lock hand-offs.

More details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 25 runs) of the
total number of ops (x10^7) reported at the end of each run. The 
standard deviation is also reported in (), and in general, with a few
exceptions, is about 3%. The 'stock' kernel is v5.0-rc8,
commit 28d49e282665 ("locking/lockdep: Shrink struct lock_class_key"),
compiled in the default configuration. 'patch' is the modified
kernel compiled with NUMA_AWARE_SPINLOCKS not set; it is included to show
that any performance changes to the existing qspinlock implementation are
essentially noise. 'patch-CNA' is the modified kernel with 
NUMA_AWARE_SPINLOCKS set; the speedup is calculated dividing 
'patch-CNA' by 'stock'.

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  2.731 (0.102)  2.732 (0.093)   2.716 (0.082)  0.995
  2  3.071 (0.124)  3.084 (0.109)   3.079 (0.113)  1.003
  4  4.221 (0.138)  4.229 (0.087)   4.408 (0.103)  1.044
  8  5.366 (0.154)  5.274 (0.094)   6.958 (0.233)  1.297
 16  6.673 (0.164)  6.689 (0.095)   8.547 (0.145)  1.281
 32  7.365 (0.177)  7.353 (0.183)   9.305 (0.202)  1.263
 36  7.473 (0.198)  7.422 (0.181)   9.441 (0.196)  1.263
 72  6.805 (0.182)  6.699 (0.170)  10.020 (0.218)  1.472
108  6.509 (0.082)  6.480 (0.115)  10.027 (0.194)  1.540
142  6.223 (0.109)  6.294 (0.100)   9.874 (0.183)  1.587

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  0.565 (0.004)  0.567 (0.001)  0.565 (0.003)  0.999
  2  0.892 (0.021)  0.899 (0.022)  0.900 (0.018)  1.009
  4  1.503 (0.031)  1.527 (0.038)  1.481 (0.025)  0.985
  8  1.755 (0.105)  1.714 (0.079)  1.683 (0.106)  0.959
 16  1.740 (0.095)  1.752 (0.087)  1.693 (0.098)  0.973
 32  0.884 (0.080)  0.908 (0.090)  1.686 (0.092)  1.906
 36  0.907 (0.095)  0.894 (0.088)  1.709 (0.081)  1.885
 72  0.856 (0.041)  0.858 (0.043)  1.707 (0.082)  1.994
108  0.858 (0.039)  0.869 (0.037)  1.732 (0.076)  2.020
142  0.809 (0.044)  0.854 (0.044)  1.728 (0.083)  2.135

and will-it-scale/lock2_threads:

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  1.713 (0.004)  1.715 (0.004)  1.711 (0.004)  0.999
  2  2.889 (0.057)  2.864 (0.078)  2.876 (0.066)  0.995
  4  4.582 (1.032)  5.066 (0.787)  4.725 (0.959)  1.031
  8  4.227 (0.196)  4.104 (0.274)  4.092 (0.365)  0.968
 16  4.108 (0.141)  4.057 (0.138)  4.010 (0.168)  0.976
 32  2.674 (0.125)  2.625 (0.171)  3.958 (0.156)  1.480
 36  2.622 (0.107)  2.553 (0.150)  3.978 (0.116)  1.517
 72  2.009 (0.090)  1.998 (0.092)  3.932 (0.114)  1.957
108  2.154 (0.069)  2.089 (0.090)  3.870 (0.081)  1.797
142  1.953 (0.106)  1.943 (0.111)  3.853 (0.100)  1.973

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 arch/arm/include/asm/mcs_spinlock.h   |   4 +-
 arch/x86/Kconfig                      |  14 ++
 include/asm-generic/qspinlock_types.h |  13 ++
 kernel/locking/mcs_spinlock.h         |  16 ++-
 kernel/locking/qspinlock.c            |  77 +++++++++--
 kernel/locking/qspinlock_cna.h        | 245 ++++++++++++++++++++++++++++++++++
 6 files changed, 354 insertions(+), 15 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.11.0 (Apple Git-81)
