From: Alex Kogan <alex.kogan@oracle.com>
Subject: [PATCH v10 0/5] Add NUMA-awareness to qspinlock
Date: Fri,  3 Apr 2020 16:59:25 -0400
Message-ID: <20200403205930.1707-1-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

Changes from v9:
----------------

- Revise the series based on Peter's version, adopting names, style, etc.

- Add a new patch that allows to prioritize certain threads (e.g., in 
irq and nmi contexts) and avoids moving them between waiting queues,
based on the suggestion by Longman.

- Drop the shuffle reduction optimization from the series (new performance
data did not justify it).

- Do not call cna_init_nodes() as an early_initcall (call it from 
cna_configure_spin_lock_slowpath() instead), based on the comment from 
Longman.


Summary
-------

Lock throughput can be increased by handing a lock to a waiter on the
same NUMA node as the lock holder, provided care is taken to avoid
starvation of waiters on other NUMA nodes. This patch introduces CNA
(compact NUMA-aware lock) as the slow path for qspinlock. It is
enabled through a configuration option (NUMA_AWARE_SPINLOCKS).

CNA is a NUMA-aware version of the MCS lock. Spinning threads are
organized in two queues, a primary queue for threads running on the same
node as the current lock holder, and a secondary queue for threads
running on other nodes. Threads store the ID of the node on which
they are running in their queue nodes. After acquiring the MCS lock and
before acquiring the spinlock, the lock holder scans the primary queue
looking for a thread running on the same node (pre-scan). If found (call
it thread T), all threads in the primary queue between the current lock
holder and T are moved to the end of the secondary queue.  If such T
is not found, we make another scan of the primary queue after acquiring 
the spinlock when unlocking the MCS lock (post-scan), starting at the
node where pre-scan stopped. If both scans fail to find such T, the
MCS lock is passed to the first thread in the secondary queue. If the
secondary queue is empty, the MCS lock is passed to the next thread in the
primary queue. To avoid starvation of threads in the secondary queue, those
threads are moved back to the head of the primary queue after a certain
number of intra-node lock hand-offs. Lastly, certain threads (e.g., in
in irq and nmi contexts) are given a preferential treatment -- the scan
stops when such a thread is found, effectively never moving those threads 
into the secondary queue.

More details are available at https://arxiv.org/abs/1810.05600.

We have done some performance evaluation with the locktorture module
as well as with several benchmarks from the will-it-scale repo.
The following locktorture results are from an Oracle X5-4 server
(four Intel Xeon E7-8895 v3 @ 2.60GHz sockets with 18 hyperthreaded
cores each). Each number represents an average (over 25 runs) of the
total number of ops (x10^7) reported at the end of each run. The 
standard deviation is also reported in (), and in general is about 3%
from the average. The 'stock' kernel is v5.6.0-rc6,
commit 5ad0ec0b8652, compiled in the default configuration. 
'patch-CNA' is the modified kernel with NUMA_AWARE_SPINLOCKS set; 
the speedup is calculated dividing 'patch-CNA' by 'stock'.

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  2.702 (0.100)  2.712 (0.122)  1.003
  2  3.691 (0.162)  3.672 (0.138)  0.995
  4  4.285 (0.108)  4.256 (0.124)  0.993
  8  5.117 (0.133)  5.972 (0.258)  1.167
 16  6.273 (0.196)  7.628 (0.274)  1.216
 32  6.757 (0.122)  8.544 (0.225)  1.264
 36  6.761 (0.091)  8.691 (0.170)  1.285
 72  6.569 (0.132)  9.280 (0.225)  1.413
108  6.167 (0.112)  9.410 (0.171)  1.526
142  5.901 (0.117)  9.415 (0.211)  1.595

The following tables contain throughput results (ops/us) from the same
setup for will-it-scale/open1_threads: 

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.511 (0.002)  0.525 (0.003)  1.027
  2  0.774 (0.018)  0.769 (0.017)  0.993
  4  1.352 (0.023)  1.372 (0.032)  1.014
  8  1.675 (0.090)  1.660 (0.136)  0.991
 16  1.665 (0.114)  1.583 (0.092)  0.951
 32  0.966 (0.038)  1.637 (0.087)  1.694
 36  0.973 (0.066)  1.570 (0.081)  1.613
 72  0.844 (0.040)  1.620 (0.091)  1.919
108  0.836 (0.040)  1.670 (0.084)  1.999
142  0.799 (0.043)  1.699 (0.087)  2.127

and will-it-scale/lock2_threads:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  1.581 (0.004)  1.576 (0.007)  0.997
  2  2.699 (0.059)  2.687 (0.067)  0.996
  4  5.240 (0.234)  5.155 (0.252)  0.984
  8  4.370 (0.241)  4.111 (0.342)  0.941
 16  4.152 (0.112)  4.113 (0.164)  0.991
 32  2.579 (0.099)  4.099 (0.127)  1.589
 36  2.604 (0.066)  4.005 (0.104)  1.538
 72  2.028 (0.091)  4.024 (0.112)  1.984
108  2.079 (0.106)  3.997 (0.093)  1.923
142  1.858 (0.103)  3.955 (0.109)  2.129

Our evaluation shows that CNA also improves performance of user 
applications that have hot pthread mutexes. Those mutexes are 
blocking, and waiting threads park and unpark via the futex 
mechanism in the kernel. Given that kernel futex chains, which
are hashed by the mutex address, are each protected by a 
chain-specific spin lock, the contention on a user-mode mutex 
translates into contention on a kernel level spinlock. 

Here are the results for the leveldb ‘readrandom’ benchmark:

#thr  	 stock        patch-CNA   speedup (patch-CNA/stock)
  1  0.530 (0.013)  0.533 (0.011)  1.006
  2  0.839 (0.043)  0.847 (0.031)  1.010
  4  0.758 (0.021)  0.764 (0.018)  1.008
  8  0.677 (0.022)  0.682 (0.016)  1.008
 16  0.714 (0.023)  0.814 (0.027)  1.140
 32  0.765 (0.040)  1.168 (0.032)  1.527
 36  0.706 (0.023)  1.139 (0.066)  1.614
 72  0.624 (0.017)  1.184 (0.026)  1.898
108  0.605 (0.013)  1.147 (0.023)  1.894
142  0.593 (0.012)  1.131 (0.019)  1.908

Further comments are welcome and appreciated.

Alex Kogan (5):
  locking/qspinlock: Rename mcs lock/unlock macros and make them more
    generic
  locking/qspinlock: Refactor the qspinlock slow path
  locking/qspinlock: Introduce CNA into the slow path of qspinlock
  locking/qspinlock: Introduce starvation avoidance into CNA
  locking/qspinlock: Avoid moving certain threads between waiting queues
    in CNA

 .../admin-guide/kernel-parameters.txt         |  18 +
 arch/arm/include/asm/mcs_spinlock.h           |   6 +-
 arch/x86/Kconfig                              |  20 +
 arch/x86/include/asm/qspinlock.h              |   6 +
 arch/x86/kernel/alternative.c                 |   2 +
 include/asm-generic/mcs_spinlock.h            |   4 +-
 kernel/locking/mcs_spinlock.h                 |  20 +-
 kernel/locking/qspinlock.c                    |  82 +++-
 kernel/locking/qspinlock_cna.h                | 407 ++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h           |   2 +-
 10 files changed, 544 insertions(+), 23 deletions(-)
 create mode 100644 kernel/locking/qspinlock_cna.h

-- 
2.21.1 (Apple Git-122.3)
