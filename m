From: Waiman Long <Waiman.Long@hp.com>
Subject: [PATCH v16 00/14] qspinlock: a 4-byte queue spinlock with PV support
Date: Fri, 24 Apr 2015 14:56:29 -0400
Message-ID: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:36285 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755245AbbDXS5p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 24 Apr 2015 14:57:45 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>, Waiman Long <Waiman.Long@hp.com>

v15->v16:
 - Remove the lfsr patch and use linear probing as lfsr is not really
   necessary in most cases.
 - Move the paravirt PV_CALLEE_SAVE_REGS_THUNK code to an asm header.
 - Add a patch to collect PV qspinlock statistics which also
   supersedes the PV lock hash debug patch.
 - Add PV qspinlock performance numbers.

v14->v15:
 - Incorporate PeterZ's v15 qspinlock patch and improve upon the PV
   qspinlock code by dynamically allocating the hash table as well
   as some other performance optimization.
 - Simplified the Xen PV qspinlock code as suggested by David Vrabel
   <david.vrabel@citrix.com>.
 - Add benchmarking data for 3.19 kernel to compare the performance
   of a spinlock heavy test with and without the qspinlock patch
   under different cpufreq drivers and scaling governors.

v13->v14:
 - Patches 1 & 2: Add queue_spin_unlock_wait() to accommodate commit
   78bff1c86 from Oleg Nesterov.
 - Fix the system hang problem when using PV qspinlock in an
   over-committed guest due to a racing condition in the
   pv_set_head_in_tail() function.
 - Increase the MAYHALT_THRESHOLD from 10 to 1024.
 - Change kick_cpu into a regular function pointer instead of a
   callee-saved function.
 - Change lock statistics code to use separate bits for different
   statistics.

v12->v13:
 - Change patch 9 to generate separate versions of the
   queue_spin_lock_slowpath functions for bare metal and PV guest. This
   reduces the performance impact of the PV code on bare metal systems.

v11->v12:
 - Based on PeterZ's version of the qspinlock patch
   (https://lkml.org/lkml/2014/6/15/63).
 - Incorporated many of the review comments from Konrad Wilk and
   Paolo Bonzini.
 - The pvqspinlock code is largely from my previous version with
   PeterZ's way of going from queue tail to head and his idea of
   using callee saved calls to KVM and XEN codes.

v10->v11:
  - Use a simple test-and-set unfair lock to simplify the code,
    but performance may suffer a bit for large guest with many CPUs.
  - Take out Raghavendra KT's test results as the unfair lock changes
    may render some of his results invalid.
  - Add PV support without increasing the size of the core queue node
    structure.
  - Other minor changes to address some of the feedback comments.

v9->v10:
  - Make some minor changes to qspinlock.c to accommodate review feedback.
  - Change author to PeterZ for 2 of the patches.
  - Include Raghavendra KT's test results in patch 18.

v8->v9:
  - Integrate PeterZ's version of the queue spinlock patch with some
    modification:
    http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
  - Break the more complex patches into smaller ones to ease review effort.
  - Fix a racing condition in the PV qspinlock code.

v7->v8:
  - Remove one unneeded atomic operation from the slowpath, thus
    improving performance.
  - Simplify some of the codes and add more comments.
  - Test for X86_FEATURE_HYPERVISOR CPU feature bit to enable/disable
    unfair lock.
  - Reduce unfair lock slowpath lock stealing frequency depending
    on its distance from the queue head.
  - Add performance data for IvyBridge-EX CPU.

v6->v7:
  - Remove an atomic operation from the 2-task contending code
  - Shorten the names of some macros
  - Make the queue waiter to attempt to steal lock when unfair lock is
    enabled.
  - Remove lock holder kick from the PV code and fix a race condition
  - Run the unfair lock & PV code on overcommitted KVM guests to collect
    performance data.

v5->v6:
 - Change the optimized 2-task contending code to make it fairer at the
   expense of a bit of performance.
 - Add a patch to support unfair queue spinlock for Xen.
 - Modify the PV qspinlock code to follow what was done in the PV
   ticketlock.
 - Add performance data for the unfair lock as well as the PV
   support code.

v4->v5:
 - Move the optimized 2-task contending code to the generic file to
   enable more architectures to use it without code duplication.
 - Address some of the style-related comments by PeterZ.
 - Allow the use of unfair queue spinlock in a real para-virtualized
   execution environment.
 - Add para-virtualization support to the qspinlock code by ensuring
   that the lock holder and queue head stay alive as much as possible.

v3->v4:
 - Remove debugging code and fix a configuration error
 - Simplify the qspinlock structure and streamline the code to make it
   perform a bit better
 - Add an x86 version of asm/qspinlock.h for holding x86 specific
   optimization.
 - Add an optimized x86 code path for 2 contending tasks to improve
   low contention performance.

v2->v3:
 - Simplify the code by using numerous mode only without an unfair option.
 - Use the latest smp_load_acquire()/smp_store_release() barriers.
 - Move the queue spinlock code to kernel/locking.
 - Make the use of queue spinlock the default for x86-64 without user
   configuration.
 - Additional performance tuning.

v1->v2:
 - Add some more comments to document what the code does.
 - Add a numerous CPU mode to support >= 16K CPUs
 - Add a configuration option to allow lock stealing which can further
   improve performance in many cases.
 - Enable wakeup of queue head CPU at unlock time for non-numerous
   CPU mode.

This patch set has 3 different sections:
 1) Patches 1-6: Introduces a queue-based spinlock implementation that
    can replace the default ticket spinlock without increasing the
    size of the spinlock data structure. As a result, critical kernel
    data structures that embed spinlock won't increase in size and
    break data alignments.
 2) Patch 7: Enables the use of unfair lock in a virtual guest. This
    can resolve some of the locking related performance issues due to
    halting the waiting CPUs after spinning for a certain amount of
    time. The unlock code will detect the a sleeping waiter and wake it
    up. This is essentially the same logic as the PV ticketlock code.
 3) Patches 8-14: Add paravirtualization spinlock support. This
    is needed as paravirt spinlock was enabled by default on
    distribution like RHEL 7.

The queue spinlock has slightly better performance than the ticket
spinlock in uncontended case. Its performance can be much better
with moderate to heavy contention.  This patch has the potential of
however, will not be able to support TSX.

The queue spinlock is especially suitable for NUMA machines with
at least 2 sockets. Though even at the 2-socket level, there can be
significant speedup depending on the workload.

The purpose of this patch set is not to solve any particular spinlock
contention problems. Those need to be solved by refactoring the code
to make more efficient use of the lock or finer granularity ones. The
main purpose is to make the lock contention problems more tolerable
until someone can spend the time and effort to fix them.

The PV portion of the patch series is geared toward performance
optimization for bare metal. However, the qspinlock performance in
virtual guest should still be comparable with ticket spinlock at low
load and much better at high load.

	Native qspinlock patch performance
	----------------------------------

In term of the performance benefit of this patch, I ran the
high_systime workload (which does a lot of fork() and exit())
at various load levels (500, 1000, 1500 and 2000 users) on a
4-socket IvyBridge-EX bare-metal system (60 cores, 120 threads)
with intel_pstate driver and performance scaling governor. The JPM
(jobs/minutes) and execution time results were as follows:

	Kernel		  JPM		Execution Time
	------		  ---		--------------
At 500 users:
	 3.19		118857.14	    26.25s
    3.19-qspinlock	134889.75	    23.13s
	% change	 +13.5%		    -11.9%

At 1000 users:
	 3.19		204255.32	    30.55s
     3.19-qspinlock	239631.34	    26.04s
	% change	 +17.3%		    -14.8%

At 1500 users:
	 3.19		177272.73	    52.80s
     3.19-qspinlock	326132.40	    28.70s
	% change	 +84.0%		    -45.6%

At 2000 users:
	 3.19		196690.31	    63.45s
     3.19-qspinlock	341730.56	    36.52s
	% change	 +73.7%		    -42.4%

It turns out that this workload was causing quite a lot of spinlock
contention in the vanilla 3.19 kernel. The performance advantage of
this patch increases with heavier loads.

With the powersave governor, the JPM data were as follows:

	Users	    3.19 	3.19-qspinlock	  % Change
	-----	    ----	--------------	  --------
	 500	  112635.38	  132596.69	   +17.7%
	1000	  171240.40	  240369.80	   +40.4%
	1500	  130507.53	  324436.74	  +148.6%
	2000	  175972.93	  341637.01	   +94.1%

With the qspinlock patch, there wasn't too much difference in
performance between the 2 scaling governors. Without this patch,
the powersave governor was much slower than the performance governor.

By disabling the intel_pstate driver and use acpi_cpufreq instead,
the benchmark performance (JPM) at 1000 users level for the performance
and ondemand governors were:

      Governor	      3.19	3.19-qspinlock	   % Change
      --------	      ----	--------------	   --------
      performance   124949.94	   219950.65	    +76.0%
      ondemand	      4838.90	   206690.96	    +4171%

The performance was just horrible when there was significant spinlock
contention with the ondemand governor. There was also significant
run-to-run variation.  A second run of the same benchmark gave a result
of 22115 JPMs. With the qspinlock patch, however, the performance was
much more stable under different cpufreq drivers and governors. That
is not the case with the default ticket spinlock implementation.

The %CPU times spent on spinlock contention (from perf) with the
performance governor and the intel_pstate driver were:

  Kernel Function		3.19 kernel	3.19-qspinlock kernel
  ---------------		-----------	---------------------
At 500 users:
  _raw_spin_lock*		  28.23%		2.25%
  queue_spin_lock_slowpath	   N/A			4.05%

At 1000 users:
  _raw_spin_lock*		  23.21%		2.25%
  queue_spin_lock_slowpath	   N/A			4.42%

At 1500 users:
  _raw_spin_lock*		  29.07%		2.24%
  queue_spin_lock_slowpath	   N/A			4.49%

At 2000 users:
  _raw_spin_lock*		  29.15%		2.26%
  queue_spin_lock_slowpath	   N/A			4.82%

The top spinlock related entries in the perf profile for the 3.19
kernel at 1000 users were:

   7.40%    reaim  [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
               |--58.96%-- rwsem_wake
               |--20.02%-- release_pages
               |--15.88%-- pagevec_lru_move_fn
               |--1.53%-- get_page_from_freelist
               |--0.78%-- __wake_up
               |--0.55%-- try_to_wake_up
                --2.28%-- [...]
   3.13%    reaim  [kernel.kallsyms]  [k] _raw_spin_lock
               |--37.55%-- free_one_page
               |--17.47%-- __cache_free_alien
               |--4.95%-- __rcu_process_callbacks
               |--2.93%-- __pte_alloc
               |--2.68%-- __drain_alien_cache
               |--2.56%-- ext4_do_update_inode
               |--2.54%-- try_to_wake_up
               |--2.46%-- pgd_free
               |--2.32%-- cache_alloc_refill
               |--2.32%-- pgd_alloc
               |--2.32%-- free_pcppages_bulk
               |--1.88%-- do_wp_page
               |--1.77%-- handle_pte_fault
               |--1.58%-- do_anonymous_page
               |--1.56%-- rmqueue_bulk.clone.0
               |--1.35%-- copy_pte_range
               |--1.25%-- zap_pte_range
               |--1.13%-- cache_flusharray
               |--0.88%-- __pmd_alloc
               |--0.70%-- wake_up_new_task
               |--0.66%-- __pud_alloc
               |--0.59%-- ext4_discard_preallocations
                --6.53%-- [...]

With the qspinlock patch, the perf profile at 1000 users was:

   3.25%    reaim  [kernel.kallsyms]  [k] queue_spin_lock_slowpath
               |--62.00%-- _raw_spin_lock_irqsave
               |          |--77.49%-- rwsem_wake
               |          |--11.99%-- release_pages
               |          |--4.34%-- pagevec_lru_move_fn
               |          |--1.93%-- get_page_from_freelist
               |          |--1.90%-- prepare_to_wait_exclusive
               |          |--1.29%-- __wake_up
               |          |--0.74%-- finish_wait
               |--11.63%-- _raw_spin_lock
               |          |--31.11%-- try_to_wake_up
               |          |--18.48%-- free_one_page
               |          |--13.97%-- __cache_free_alien
               |          |--7.77%-- free_pcppages_bulk
               |          |--7.12%-- __drain_alien_cache
               |          |--6.17%-- rmqueue_bulk.clone.0
               |          |--4.17%-- __rcu_process_callbacks
               |          |--2.22%-- cache_alloc_refill
               |          |--2.15%-- wake_up_new_task
               |          |--1.80%-- ext4_do_update_inode
               |          |--1.52%-- cache_flusharray
               |          |--0.89%-- __mutex_unlock_slowpath
               |          |--0.64%-- ttwu_queue
               |--11.19%-- _raw_spin_lock_irq
               |          |--98.95%-- rwsem_down_write_failed
               |          |--0.93%-- __schedule
               |--7.91%-- queue_read_lock_slowpath
               |          _raw_read_lock
               |          |--96.79%-- do_wait
               |          |--2.44%-- do_prlimit
               |                     chrdev_open
               |                     do_dentry_open
               |                     vfs_open
               |                     do_last
               |                     path_openat
               |                     do_filp_open
               |                     do_sys_open
               |                     sys_open
               |                     system_call
               |                     __GI___libc_open
               |--7.05%-- queue_write_lock_slowpath
               |          _raw_write_lock_irq
               |          |--35.36%-- release_task
               |          |--32.76%-- copy_process
               |                     do_exit
               |                     do_group_exit
               |                     sys_exit_group
               |                     system_call
                --0.22%-- [...]

This demonstrates the benefit of this patch for those applications
that run on multi-socket machines and can cause significant spinlock
contentions in the kernel.

I also got report that the queue spinlock patch can improve the
performance of an I/O and interrupt intensive stress test with a lot
of spinlock contention on a 2-socket system by up to 20%.

Daniel Blueman of NumaScale had tested the v14 qspinlock patch on an
older 512-core NumaConnect system for testing with 3.19.1:

$ src/reaim -c data/reaim.config -f data/workfile.compute -i 16 -e 256
Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent
1       2.15     0.36    1.19    2818.60    2818.60    0.00     0.00    100
17      6.29     42.41   22.43   16378.38   963.43     0.27     4.43    95
33      56.24    1611.77 47.04   3555.83    107.75     1.58     2.88    97
49      120.88   5576.87 63.54   2456.49    50.13      1.75     1.47    98
65      199.17   12328.42 81.27   1977.71    30.43      2.42     1.23    98
81      270.89   20943.99 103.99  1812.03    22.37      3.85     1.44    98
97      315.31   29211.63 121.30  1864.26    19.22      4.48     1.44    98
113     397.68   42766.15 144.48  1721.94    15.24      7.04     1.80    98
129     520.74   63442.27 162.03  1501.21    11.64      10.24    1.99    98
...

Patched with qspinlocks v14:

Num     Parent   Child   Child  Jobs per   Jobs/min/  Std_dev  Std_dev  JTI
Forked  Time     SysTime UTime   Minute     Child      Time     Percent
1       1.98     0.36    1.21    3060.61    3060.61    0.00     0.00    100
17      5.60     25.41   22.39   18396.43   1082.14    0.16     3.00    97
33      12.67    153.64  49.17   15783.74   478.30     0.50     4.16    95
49      21.15    365.55  76.61   14039.72   286.52     0.83     4.19    95
65      27.57    556.87  105.96  14287.27   219.80     0.75     2.80    97
81      33.07    712.92  127.85  14843.06   183.25     1.16     3.69    96
97      42.81    1009.02 161.87  13730.90   141.56     1.75     4.27    95
113     49.13    1166.04 185.10  13938.12   123.35     2.11     4.53    95
129     56.62    1262.07 231.92  13806.78   107.03     2.67     4.99    95
145     66.41    1420.29 250.24  13231.44   91.25      2.95     4.70    95
179     90.15    2237.78 325.18  12032.61   67.22      4.23     4.94    95
193     85.41    1865.81 326.64  13693.71   70.95      4.29     5.32    94
220     93.58    2298.77 376.46  14246.63   64.76      4.97     5.65    94
Max Jobs per Minute 18396.43 

The compute workload is mostly userspace code with some synchronization
between working threads (HPC type workload). With large user count, the
patched kernel has close to 8X the performance of an unpatched kernel.

	Paravirt qspinlock patch performance
	------------------------------------

A linux kernel build workload (make -j <n>) was run on KVM and Xen
guests with and without the qspinlock patch. The host machine was
an 8-socket Westmere-EX server with 4 active cores/socket (8x4).

For the KVM test, the VM configurations were:

 1) 32 NUMA-pinned vCPUs (8x4)
 2) 32 vCPUs (no pinning or NUMA)
 3) 60 vCPUs (overcommitted)
 
The kernel build times for different 4.0-rc6 based kernels were:

        Kernel            VM1       VM2         VM3
        ------            ---       ---         ---
     PV ticket lock     3m49.7s   11m45.6s    15m59.3s
     PV qspinlock       3m50.4s    5m51.6s    15m33.6s

For VM1, both the qspinlock and ticket lock have essentially the same
performance.  VM2 illustrated the performance benefit of qspinlock
versus ticket spinlock which got reduced in VM3 due to the overhead
of constant vCPUs halting and kicking.

For the Xen test, the VM configurations were:

 1) 32 vCPUs (no pinning or NUMA)
 2) 64 vCPUs
 2) 128 vCPUs

The kernel build times for different 4.0 based kernels were:

        Kernel            VM1       VM2         VM3
        ------            ---       ---         ---
     PV ticket lock     7m27.3s   16m14.1s    18m26.9s
     PV qspinlock       5m51.6s   12m02.6s    14m19.2s

Here, the PV qspinlock was faster than the PV ticket lock.

David Vrabel (1):
  pvqspinlock, x86: Enable PV qspinlock for Xen

Peter Zijlstra (Intel) (4):
  qspinlock: Add pending bit
  qspinlock: Optimize for smaller NR_CPUS
  qspinlock: Revert to test-and-set on hypervisors
  pvqspinlock, x86: Implement the paravirt qspinlock call patching

Waiman Long (9):
  qspinlock: A simple generic 4-byte queue spinlock
  qspinlock, x86: Enable x86-64 to use queue spinlock
  qspinlock: Extract out code snippets for the next patch
  qspinlock: Use a simple write to grab the lock
  pvqspinlock: Implement simple paravirt support for the qspinlock
  pvqspinlock, x86: Enable PV qspinlock for KVM
  pvqspinlock: Only kick CPU at unlock time
  pvqspinlock: Improve slowpath performance by avoiding cmpxchg
  pvqspinlock: Collect slowpath lock statistics

 arch/x86/Kconfig                          |    3 +-
 arch/x86/include/asm/paravirt.h           |   29 ++-
 arch/x86/include/asm/paravirt_types.h     |   10 +
 arch/x86/include/asm/qspinlock.h          |   57 ++++
 arch/x86/include/asm/qspinlock_paravirt.h |    6 +
 arch/x86/include/asm/spinlock.h           |    5 +
 arch/x86/include/asm/spinlock_types.h     |    4 +
 arch/x86/kernel/kvm.c                     |   43 +++
 arch/x86/kernel/paravirt-spinlocks.c      |   24 ++-
 arch/x86/kernel/paravirt_patch_32.c       |   22 +-
 arch/x86/kernel/paravirt_patch_64.c       |   22 +-
 arch/x86/xen/spinlock.c                   |   64 ++++-
 include/asm-generic/qspinlock.h           |  139 +++++++++
 include/asm-generic/qspinlock_types.h     |   79 +++++
 kernel/Kconfig.locks                      |    7 +
 kernel/locking/Makefile                   |    1 +
 kernel/locking/mcs_spinlock.h             |    1 +
 kernel/locking/qspinlock.c                |  473 ++++++++++++++++++++++++++++
 kernel/locking/qspinlock_paravirt.h       |  478 +++++++++++++++++++++++++++++
 19 files changed, 1452 insertions(+), 15 deletions(-)
 create mode 100644 arch/x86/include/asm/qspinlock.h
 create mode 100644 arch/x86/include/asm/qspinlock_paravirt.h
 create mode 100644 include/asm-generic/qspinlock.h
 create mode 100644 include/asm-generic/qspinlock_types.h
 create mode 100644 kernel/locking/qspinlock.c
 create mode 100644 kernel/locking/qspinlock_paravirt.h
