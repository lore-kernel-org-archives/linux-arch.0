Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2130.oracle.com ([156.151.31.86]:38676 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730658AbfGOT1R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jul 2019 15:27:17 -0400
From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v3 0/5] Add NUMA-awareness to qspinlock
Date: Mon, 15 Jul 2019 15:25:31 -0400
Message-ID: <20190715192536.104548-1-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190715192531.Z1nfxsz0jPvllz_8g9-YJ632uhnWFzLUTom0zqv3pQc@z>

Changes from v2:
----------------
- Patch the NUMA-aware qspinlock at the boot time on machines with
multiple NUMA nodes and a kernel compiled with NUMA_AWARE_SPINLOCKS,
as suggested by Peter and Longman.

- CNA queue nodes encapsulate MCS queue nodes, similarly to paravirt nodes,
as suggested by Peter. MCS queue node size has been increased by 4 bytes.

- Use the existing next_pseudo_random32() instead of a custom xorshift
pseudo-random number generator, as suggested by Peter.

- Use cpu_to_node() to lookup the NUMA node of a thread, as suggested
by Hanjun.

— Rewrote cna_pass_mcs_lock(), as suggested by Peter.

- We evaluated the patch on a single-node machine as well as in a paravirt 
environment (with virtme/qemu), as suggested by Peter and Longman.
Details are below.

— Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes, as the latter create contention
on spin locks protecting futex chains in the kernel when waiting threads
park and unpark. Details are below.


Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
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
standard deviation is also reported in (), and in general is about 3%
from the average. The 'stock' kernel is v5.2.0-rc2,
commit f782099a96a0 ("Merge branch 'perf/core'"),
compiled in the default configuration. 'patch' is the modified
kernel compiled with NUMA_AWARE_SPINLOCKS not set; it is included to show
that any performance changes to the existing qspinlock implementation are
essentially noise. 'patch-CNA' is the modified kernel with 
NUMA_AWARE_SPINLOCKS set; the speedup is calculated dividing 
'patch-CNA' by 'stock'.

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  2.687 (0.104)  2.655 (0.099)   2.706 (0.119)  1.007
  2  3.085 (0.104)  3.140 (0.128)   3.111 (0.147)  1.009
  4  4.230 (0.125)  4.217 (0.129)   4.482 (0.121)  1.060
  8  5.480 (0.159)  5.411 (0.183)   7.064 (0.218)  1.289
 16  6.733 (0.196)  6.764 (0.155)   8.666 (0.161)  1.287
 32  7.557 (0.148)  7.488 (0.133)   9.519 (0.253)  1.260
 36  7.667 (0.222)  7.654 (0.211)   9.530 (0.218)  1.243
 72  6.931 (0.172)  6.931 (0.187)  10.030 (0.217)  1.447
108  6.478 (0.098)  6.423 (0.107)  10.157 (0.250)  1.568
142  6.041 (0.102)  6.058 (0.111)  10.102 (0.260)  1.672

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  0.536 (0.001)  0.540 (0.003)  0.538 (0.001)  1.002
  2  0.833 (0.020)  0.842 (0.028)  0.827 (0.025)  0.993
  4  1.464 (0.031)  1.473 (0.025)  1.465 (0.033)  1.001
  8  1.685 (0.087)  1.707 (0.078)  1.708 (0.104)  1.013
 16  1.715 (0.091)  1.777 (0.100)  1.766 (0.070)  1.029
 32  0.937 (0.065)  0.930 (0.078)  1.752 (0.072)  1.869
 36  0.930 (0.079)  0.927 (0.092)  1.731 (0.068)  1.862
 72  0.871 (0.037)  0.855 (0.038)  1.758 (0.071)  2.019
108  0.856 (0.044)  0.865 (0.042)  1.747 (0.063)  2.040
142  0.810 (0.051)  0.815 (0.041)  1.776 (0.064)  2.193

and will-it-scale/lock2_threads:

#thr  	 stock  	patch	     patch-CNA 	 speedup (patch-CNA/stock)
  1  1.631 (0.002)  1.638 (0.002)  1.637 (0.002)  1.004
  2  2.756 (0.076)  2.761 (0.063)  2.778 (0.081)  1.008
  4  5.119 (0.411)  5.256 (0.331)  5.138 (0.388)  1.004
  8  4.147 (0.215)  4.299 (0.264)  4.126 (0.322)  0.995
 16  4.214 (0.111)  4.234 (0.133)  4.133 (0.128)  0.981
 32  2.485 (0.095)  2.473 (0.117)  4.015 (0.115)  1.616
 36  2.423 (0.099)  2.451 (0.117)  3.963 (0.129)  1.636
 72  2.026 (0.102)  1.983 (0.108)  4.000 (0.122)  1.975
108  2.102 (0.088)  2.145 (0.080)  3.927 (0.108)  1.868
142  1.923 (0.128)  1.894 (0.100)  3.879 (0.081)  2.018

We also evaluated the patch on a single-node machine (Intel i7-4770 with 
4 hyperthreaded cores) with will-it-scale, and observed no meaningful
performance impact, as expected. For instance, below are results for 
will-it-scale/open1_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.861 (0.006)  0.867 (0.005)  1.007
  2  1.481 (0.015)  1.511 (0.017)  1.020
  4  2.671 (0.041)  2.697 (0.049)  1.010
  6  2.889 (0.064)  2.910 (0.060)  1.007

Furthermore, we evaluated the patch in the paravirt setup, booting the 
kernel with virtme (qemu) and $(nproc) cores on the same Oracle X5-4 server
as above. We run will-it-scale benchmarks, and once again observed 
no meaningful performance impact. For instance, below are results for
will-it-scale/open1_threads:

#thr  	 stock 	      patch-CNA   speedup (patch-CNA/stock)
  1  0.761 (0.009)  0.763 (0.009)  1.003
  2  0.652 (0.043)  0.666 (0.033)  1.022
  4  0.591 (0.036)  0.596 (0.033)  1.008
  8  0.582 (0.019)  0.575 (0.020)  0.989
 16  0.680 (0.021)  0.685 (0.018)  1.007
 32  0.566 (0.031)  0.548 (0.049)  0.968
 36  0.549 (0.053)  0.531 (0.053)  0.966
 72  0.363 (0.012)  0.364 (0.008)  1.002
108  0.359 (0.010)  0.361 (0.009)  1.004
142  0.355 (0.011)  0.362 (0.011)  1.020

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the results for the leveldb ‘readrandom’ benchmark:

#thr  	 stock        patch-CNA    speedup (patch-CNA/stock)
  1  0.479 (0.036)  0.533 (0.010)   1.113
  2  0.653 (0.022)  0.680 (0.027)   1.042
  4  0.705 (0.016)  0.701 (0.019)   0.995
  8  0.686 (0.021)  0.690 (0.024)   1.006
 16  0.708 (0.025)  0.719 (0.020)   1.016
 32  0.728 (0.023)  1.011 (0.117)   1.389
 36  0.720 (0.038)  1.073 (0.127)   1.491
 72  0.652 (0.018)  1.195 (0.017)   1.833
108  0.624 (0.016)  1.178 (0.028)   1.888
142  0.604 (0.015)  1.163 (0.024)   1.925

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Make arch_mcs_spin_unlock_contended more generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Introduce the shuffle reduction optimization into
    CNA

 arch/arm/include/asm/mcs_spinlock.h |   4 +-
 arch/x86/Kconfig                    |  18 +++
 arch/x86/include/asm/qspinlock.h    |   4 +
 arch/x86/kernel/alternative.c       |  12 ++
 kernel/locking/mcs_spinlock.h       |   8 +-
 kernel/locking/qspinlock.c          |  81 +++++++++++---
 kernel/locking/qspinlock_cna.h      | 218 ++++++++++++++++++++++++++++++++++++
 7 files changed, 326 insertions(+), 19 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.11.0 (Apple Git-81)
