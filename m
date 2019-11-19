From: kernel test robot <oliver.sang@intel.com>
Subject: [locking/qspinlock]  ad3836e30e:  will-it-scale.per_thread_ops 73.5%
 improvement
Date: Tue, 19 Nov 2019 22:48:26 +0800
Message-ID: <20191119144826.GA28989@xsang-OptiPlex-9020>
References: <20191107174622.61718-4-alex.kogan@oracle.com>
Reply-To: lkp report check <oliver.sang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191107174622.61718-4-alex.kogan@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, alex.kogan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, lkp@lists.01.org
List-Id: linux-arch.vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Greeting,

FYI, we noticed a 73.5% improvement of will-it-scale.per_thread_ops due to commit:


commit: ad3836e30e6f5f5e97867707b573f2fda5ce444a ("[PATCH v6 3/5] locking/qspinlock: Introduce CNA into the slow path of qspinlock")
url: https://github.com/0day-ci/linux/commits/Alex-Kogan/locking-qspinlock-Rename-mcs-lock-unlock-macros-and-make-them-more-generic/20191109-180535


in testcase: will-it-scale
on test machine: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
with following parameters:

	nr_task: 50%
	mode: thread
	test: unlink2
	cpufreq_governor: performance
	ucode: 0x500002b

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale

In addition to that, the commit also has significant impact on the following tests:

+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 200.6% improvement            |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=100%                                                              |
|                  | test=unlink2                                                              |
|                  | ucode=0x500002b                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale:                                                            |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=100%                                                              |
|                  | test=signal1                                                              |
|                  | ucode=0x500002b                                                           |
+------------------+---------------------------------------------------------------------------+
| testcase: change | will-it-scale: will-it-scale.per_thread_ops 93.0% improvement             |
| test machine     | 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory |
| test parameters  | cpufreq_governor=performance                                              |
|                  | mode=thread                                                               |
|                  | nr_task=50%                                                               |
|                  | test=signal1                                                              |
|                  | ucode=0x500002b                                                           |
+------------------+---------------------------------------------------------------------------+




Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/50%/debian-x86_64-2019-09-23.cgz/lkp-csl-2ap3/unlink2/will-it-scale/0x500002b

commit: 
  2f65452ad7 ("locking/qspinlock: Refactor the qspinlock slow path")
  ad3836e30e ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

2f65452ad747deeb ad3836e30e6f5f5e97867707b57 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           75%           3:4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
           :4           25%           1:4     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
      6672 ±  4%     +73.5%      11574 ±  2%  will-it-scale.per_thread_ops
    640605 ±  4%     +73.5%    1111223 ±  2%  will-it-scale.workload
      1.51 ±  5%      +0.8        2.32 ±  6%  mpstat.cpu.all.soft%
      0.10 ± 10%      +0.0        0.12 ±  2%  mpstat.cpu.all.usr%
  20048836 ± 12%     +22.5%   24566004 ± 16%  turbostat.C1E
     11.23 ± 41%      +7.1       18.35 ± 31%  turbostat.C1E%
 1.282e+10 ± 41%     +63.3%  2.094e+10 ± 31%  cpuidle.C1E.time
  39313047 ± 12%     +22.7%   48249083 ± 16%  cpuidle.C1E.usage
   3166305 ±  6%     +14.0%    3608145 ±  8%  cpuidle.POLL.time
     49.00            -2.0%      48.00        vmstat.cpu.id
     50.00            +2.0%      51.00        vmstat.cpu.sy
      3407            +2.2%       3482        vmstat.system.cs
    135302           +19.7%     161908 ±  2%  meminfo.KReclaimable
    135302           +19.7%     161908 ±  2%  meminfo.SReclaimable
    449410 ±  2%     +24.4%     558953 ±  3%  meminfo.SUnreclaim
    584713 ±  2%     +23.3%     720862 ±  3%  meminfo.Slab
     11319 ±  2%     +10.1%      12458 ±  2%  meminfo.max_used_kB
   2238130 ±  3%    +135.9%    5279009 ±  6%  numa-numastat.node0.local_node
   2269204 ±  3%    +133.7%    5302396 ±  6%  numa-numastat.node0.numa_hit
   2365013 ±  5%    +103.3%    4809115 ±  8%  numa-numastat.node1.local_node
   2385159 ±  5%    +102.7%    4835585 ±  8%  numa-numastat.node1.numa_hit
   2221247 ±  3%    +114.8%    4772155 ±  7%  numa-numastat.node2.local_node
   2247695 ±  3%    +113.4%    4795496 ±  6%  numa-numastat.node2.numa_hit
   2309805 ± 10%    +110.3%    4857220 ±  9%  numa-numastat.node3.local_node
   2325463 ±  9%    +109.7%    4877484 ±  9%  numa-numastat.node3.numa_hit
     44400 ± 21%     +26.8%      56304 ±  8%  numa-meminfo.node0.KReclaimable
      9900 ± 24%     +27.6%      12631 ±  7%  numa-meminfo.node0.Mapped
     44400 ± 21%     +26.8%      56304 ±  8%  numa-meminfo.node0.SReclaimable
    133122 ±  8%     +24.1%     165206 ±  4%  numa-meminfo.node0.SUnreclaim
    177523 ± 11%     +24.8%     221511 ±  5%  numa-meminfo.node0.Slab
    100192 ±  9%     +25.2%     125474 ±  4%  numa-meminfo.node1.SUnreclaim
    127118 ±  9%     +24.4%     158125 ±  4%  numa-meminfo.node1.Slab
    101780 ±  7%     +27.5%     129806 ±  6%  numa-meminfo.node2.SUnreclaim
    128296 ±  9%     +30.0%     166849 ±  7%  numa-meminfo.node2.Slab
      8291 ±  2%      +4.9%       8697 ±  2%  proc-vmstat.nr_mapped
     33848           +19.6%      40470 ±  3%  proc-vmstat.nr_slab_reclaimable
    111872 ±  2%     +24.3%     139038 ±  3%  proc-vmstat.nr_slab_unreclaimable
      2292 ± 12%     +76.4%       4044 ± 56%  proc-vmstat.numa_hint_faults_local
   9232703 ±  3%    +114.6%   19813037 ±  3%  proc-vmstat.numa_hit
   9139363 ±  3%    +115.8%   19719551 ±  3%  proc-vmstat.numa_local
    499.00 ± 59%   +1997.4%      10466 ± 49%  proc-vmstat.numa_pages_migrated
    111653 ± 10%     +23.8%     138277 ± 10%  proc-vmstat.numa_pte_updates
  42745968 ±  2%     +91.0%   81650355 ±  3%  proc-vmstat.pgalloc_normal
  42682188 ±  2%     +91.1%   81573027 ±  3%  proc-vmstat.pgfree
    499.00 ± 59%   +1997.4%      10466 ± 49%  proc-vmstat.pgmigrate_success
      2494 ± 24%     +25.4%       3129 ±  8%  numa-vmstat.node0.nr_mapped
     11093 ± 21%     +27.0%      14087 ±  8%  numa-vmstat.node0.nr_slab_reclaimable
     33289 ±  8%     +24.4%      41423 ±  5%  numa-vmstat.node0.nr_slab_unreclaimable
   1667202 ±  4%     +90.5%    3176615 ±  6%  numa-vmstat.node0.numa_hit
   1636540 ±  4%     +92.7%    3153437 ±  6%  numa-vmstat.node0.numa_local
     24978 ±  9%     +26.6%      31632 ±  4%  numa-vmstat.node1.nr_slab_unreclaimable
   1486622 ±  5%     +82.6%    2713956 ±  6%  numa-vmstat.node1.numa_hit
   1379225 ±  5%     +88.5%    2600269 ±  6%  numa-vmstat.node1.numa_local
     25404 ±  6%     +28.2%      32569 ±  6%  numa-vmstat.node2.nr_slab_unreclaimable
   1359621 ±  3%    +100.3%    2723407 ±  7%  numa-vmstat.node2.numa_hit
   1246044 ±  3%    +109.7%    2612899 ±  8%  numa-vmstat.node2.numa_local
   1528891 ± 13%     +78.0%    2721568 ±  8%  numa-vmstat.node3.numa_hit
   1425866 ± 15%     +83.3%    2613907 ±  9%  numa-vmstat.node3.numa_local
    192.00 ± 11%     +62.5%     312.00 ± 22%  slabinfo.biovec-64.active_objs
    192.00 ± 11%     +62.5%     312.00 ± 22%  slabinfo.biovec-64.num_objs
    303493 ±  3%     +33.3%     404707 ±  3%  slabinfo.dentry.active_objs
      7249 ±  3%     +33.4%       9668 ±  3%  slabinfo.dentry.active_slabs
    304492 ±  3%     +33.4%     406075 ±  3%  slabinfo.dentry.num_objs
      7249 ±  3%     +33.4%       9668 ±  3%  slabinfo.dentry.num_slabs
    182640 ±  6%     +62.8%     297383 ±  5%  slabinfo.filp.active_objs
      2860 ±  6%     +62.8%       4655 ±  5%  slabinfo.filp.active_slabs
    183092 ±  6%     +62.8%     297994 ±  5%  slabinfo.filp.num_objs
      2860 ±  6%     +62.8%       4655 ±  5%  slabinfo.filp.num_slabs
      1323 ±  2%     +15.1%       1522 ±  5%  slabinfo.kmalloc-rcl-96.active_objs
      1323 ±  2%     +15.1%       1522 ±  5%  slabinfo.kmalloc-rcl-96.num_objs
    161582 ±  6%     +72.7%     279012 ±  6%  slabinfo.shmem_inode_cache.active_objs
      3516 ±  6%     +72.7%       6074 ±  6%  slabinfo.shmem_inode_cache.active_slabs
    161805 ±  6%     +72.7%     279439 ±  6%  slabinfo.shmem_inode_cache.num_objs
      3516 ±  6%     +72.7%       6074 ±  6%  slabinfo.shmem_inode_cache.num_slabs
    529.15 ± 12%    +111.9%       1120 ± 19%  sched_debug.cfs_rq:/.exec_clock.stddev
     52879 ± 11%     +74.8%      92425 ± 24%  sched_debug.cfs_rq:/.load.stddev
     21.36 ± 11%     +47.8%      31.58 ± 17%  sched_debug.cfs_rq:/.load_avg.avg
      0.04 ±173%   +3100.0%       1.33 ± 70%  sched_debug.cfs_rq:/.load_avg.min
     50786 ± 14%     +98.1%     100627 ± 25%  sched_debug.cfs_rq:/.min_vruntime.stddev
     34.29 ± 22%   +1108.9%     414.56 ±  2%  sched_debug.cfs_rq:/.nr_spread_over.avg
     58.54 ± 17%    +853.0%     557.92 ± 18%  sched_debug.cfs_rq:/.nr_spread_over.max
     13.08 ± 14%   +2672.0%     362.67 ±  2%  sched_debug.cfs_rq:/.nr_spread_over.min
      8.55 ± 16%    +156.9%      21.96 ± 21%  sched_debug.cfs_rq:/.nr_spread_over.stddev
      5.06 ± 13%     +46.9%       7.44 ± 35%  sched_debug.cfs_rq:/.runnable_load_avg.avg
     52870 ± 11%     +74.8%      92406 ± 24%  sched_debug.cfs_rq:/.runnable_weight.stddev
     50790 ± 14%     +98.1%     100636 ± 25%  sched_debug.cfs_rq:/.spread0.stddev
    180401 ± 11%     +23.6%     222940 ± 12%  sched_debug.cpu.avg_idle.stddev
      8.91 ±  4%      +6.8%       9.52 ±  6%  sched_debug.cpu.clock.stddev
      8.91 ±  4%      +6.8%       9.52 ±  6%  sched_debug.cpu.clock_task.stddev
     11814 ± 22%     +33.5%      15769 ± 15%  sched_debug.cpu.sched_count.max
      1586 ±  3%     +15.7%       1834 ±  7%  sched_debug.cpu.sched_count.stddev
      5670 ± 23%     +34.1%       7601 ± 16%  sched_debug.cpu.sched_goidle.max
    790.14 ±  4%     +15.5%     912.55 ±  7%  sched_debug.cpu.sched_goidle.stddev
      7.40 ±  6%     +42.3%      10.53 ±  2%  perf-stat.i.MPKI
 7.765e+09           +22.7%  9.528e+09        perf-stat.i.branch-instructions
      0.40 ±  4%      +0.0        0.45        perf-stat.i.branch-miss-rate%
  31323148 ±  4%     +36.4%   42730681        perf-stat.i.branch-misses
     58.03           -47.3       10.78 ±  3%  perf-stat.i.cache-miss-rate%
 1.456e+08 ±  9%     -66.8%   48391249 ±  3%  perf-stat.i.cache-misses
 2.506e+08 ±  7%     +79.9%  4.509e+08 ±  4%  perf-stat.i.cache-references
      3361            +2.4%       3442        perf-stat.i.context-switches
      9.05           -20.1%       7.23        perf-stat.i.cpi
    344.23            -5.1%     326.65 ±  2%  perf-stat.i.cpu-migrations
      2122 ±  8%    +202.6%       6421 ±  3%  perf-stat.i.cycles-between-cache-misses
   1265475 ±  4%     +44.2%    1824797 ±  7%  perf-stat.i.dTLB-load-misses
 9.014e+09           +29.4%  1.166e+10        perf-stat.i.dTLB-loads
      0.01 ± 10%      +0.0        0.01 ±  7%  perf-stat.i.dTLB-store-miss-rate%
    169566 ±  7%    +110.5%     356900 ±  6%  perf-stat.i.dTLB-store-misses
 2.377e+09 ±  4%     +67.9%  3.991e+09 ±  2%  perf-stat.i.dTLB-stores
     85.27            +6.1       91.39        perf-stat.i.iTLB-load-miss-rate%
  18608109 ±  5%     +60.7%   29911747        perf-stat.i.iTLB-load-misses
   3204887           -12.4%    2808962 ±  4%  perf-stat.i.iTLB-loads
 3.387e+10           +26.4%  4.281e+10        perf-stat.i.instructions
      1826 ±  4%     -21.6%       1432        perf-stat.i.instructions-per-iTLB-miss
      0.11           +25.3%       0.14        perf-stat.i.ipc
     93.40           -33.7       59.71 ±  4%  perf-stat.i.node-load-miss-rate%
  31424789 ± 10%     -88.2%    3699396 ±  9%  perf-stat.i.node-load-misses
     87.06           -60.6       26.47 ±  7%  perf-stat.i.node-store-miss-rate%
  16693314 ± 12%     -86.1%    2316840 ±  8%  perf-stat.i.node-store-misses
   2494712 ± 16%    +156.7%    6404636 ±  3%  perf-stat.i.node-stores
      7.40 ±  6%     +42.4%      10.53 ±  2%  perf-stat.overall.MPKI
      0.40 ±  4%      +0.0        0.45        perf-stat.overall.branch-miss-rate%
     58.02           -47.3       10.74 ±  3%  perf-stat.overall.cache-miss-rate%
      9.04           -20.1%       7.22        perf-stat.overall.cpi
      2122 ±  8%    +201.4%       6395 ±  3%  perf-stat.overall.cycles-between-cache-misses
      0.01 ± 10%      +0.0        0.01 ±  7%  perf-stat.overall.dTLB-store-miss-rate%
     85.27            +6.1       91.41        perf-stat.overall.iTLB-load-miss-rate%
      1825 ±  4%     -21.6%       1431        perf-stat.overall.instructions-per-iTLB-miss
      0.11           +25.3%       0.14        perf-stat.overall.ipc
     93.40           -32.8       60.59 ±  3%  perf-stat.overall.node-load-miss-rate%
     87.05           -60.5       26.56 ±  7%  perf-stat.overall.node-store-miss-rate%
  15772532 ±  4%     -27.1%   11493841        perf-stat.overall.path-length
 7.739e+09           +22.7%  9.496e+09        perf-stat.ps.branch-instructions
  31217264 ±  4%     +36.4%   42586237        perf-stat.ps.branch-misses
 1.451e+08 ±  9%     -66.8%   48228082 ±  3%  perf-stat.ps.cache-misses
 2.497e+08 ±  7%     +79.9%  4.493e+08 ±  4%  perf-stat.ps.cache-references
      3350            +2.4%       3430        perf-stat.ps.context-switches
    343.06            -5.1%     325.54 ±  2%  perf-stat.ps.cpu-migrations
   1261151 ±  4%     +44.2%    1818535 ±  7%  perf-stat.ps.dTLB-load-misses
 8.984e+09           +29.4%  1.162e+10        perf-stat.ps.dTLB-loads
    168993 ±  7%    +110.5%     355694 ±  6%  perf-stat.ps.dTLB-store-misses
 2.369e+09 ±  4%     +67.9%  3.978e+09 ±  2%  perf-stat.ps.dTLB-stores
  18545230 ±  5%     +60.7%   29810560        perf-stat.ps.iTLB-load-misses
   3194060           -12.4%    2799474 ±  4%  perf-stat.ps.iTLB-loads
 3.376e+10           +26.4%  4.266e+10        perf-stat.ps.instructions
  31318540 ± 10%     -88.2%    3686933 ±  9%  perf-stat.ps.node-load-misses
  16636871 ± 12%     -86.1%    2309030 ±  8%  perf-stat.ps.node-store-misses
   2486272 ± 16%    +156.7%    6382952 ±  3%  perf-stat.ps.node-stores
 1.009e+13           +26.6%  1.277e+13        perf-stat.total.instructions
     20.98 ± 47%     -21.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_doinit_with_dentry.security_d_instantiate.d_instantiate
     20.96 ± 47%     -21.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.selinux_inode_free_security.security_inode_free.__destroy_inode
      0.41 ± 58%      +0.3        0.67 ±  6%  perf-profile.calltrace.cycles-pp.__slab_free.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start
      0.42 ± 58%      +0.3        0.69 ±  6%  perf-profile.calltrace.cycles-pp.kmem_cache_free.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      0.77 ± 11%      +0.3        1.10 ±  8%  perf-profile.calltrace.cycles-pp.file_free_rcu.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      1.37 ± 10%      +0.5        1.87 ±  6%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.37 ± 10%      +0.5        1.87 ±  6%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.36 ± 10%      +0.5        1.86 ±  7%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      1.34 ± 10%      +0.5        1.85 ±  7%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.34 ± 10%      +0.5        1.85 ±  7%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.34 ± 10%      +0.5        1.85 ±  7%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      1.34 ± 10%      +0.5        1.85 ±  7%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      0.99 ± 36%      +2.0        3.02 ± 63%  perf-profile.calltrace.cycles-pp.__alloc_fd.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_open
      0.85 ± 41%      +2.1        2.95 ± 65%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__alloc_fd.do_sys_open.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.91 ± 42%      +2.4        3.32 ± 68%  perf-profile.calltrace.cycles-pp.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      0.99 ± 39%      +2.4        3.41 ± 66%  perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.12 ± 36%      +2.4        3.56 ± 63%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.12 ± 36%      +2.4        3.56 ± 63%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__GI___libc_close
      1.14 ± 35%      +2.5        3.60 ± 63%  perf-profile.calltrace.cycles-pp.__GI___libc_close
      0.84 ± 43%      +2.5        3.30 ± 68%  perf-profile.calltrace.cycles-pp._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +2.9        2.89 ± 66%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_open.do_syscall_64
      0.00            +3.2        3.24 ± 69%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
      0.00            +7.1        7.12 ± 44%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.selinux_inode_free_security.security_inode_free.__destroy_inode
      0.00            +7.5        7.48 ± 44%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.inode_doinit_with_dentry.security_d_instantiate.d_instantiate
      0.00           +16.5       16.53 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
      0.00           +19.3       19.32 ±  9%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
     60.59 ±  7%     -60.6        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.78 ± 14%      -0.3        0.48 ± 10%  perf-profile.children.cycles-pp.generic_permission
      0.81 ± 14%      -0.3        0.51 ± 10%  perf-profile.children.cycles-pp.inode_permission
      0.83 ± 12%      -0.2        0.63 ±  9%  perf-profile.children.cycles-pp.link_path_walk
      0.26 ± 14%      -0.2        0.11 ±  4%  perf-profile.children.cycles-pp.__mnt_want_write
      0.48 ± 14%      -0.1        0.34 ±  5%  perf-profile.children.cycles-pp.__alloc_file
      0.49 ± 13%      -0.1        0.34 ±  6%  perf-profile.children.cycles-pp.alloc_empty_file
      0.28 ± 15%      -0.1        0.13        perf-profile.children.cycles-pp.mnt_want_write
      0.51 ± 12%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.vfs_unlink
      0.15 ± 23%      -0.1        0.06 ±  6%  perf-profile.children.cycles-pp.timestamp_truncate
      0.22 ±  5%      -0.1        0.14 ± 13%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.23 ± 11%      -0.1        0.15 ±  7%  perf-profile.children.cycles-pp.do_dentry_open
      0.16 ± 20%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.current_time
      0.15 ±  8%      -0.1        0.07 ± 10%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.27 ±  5%      -0.1        0.19 ± 11%  perf-profile.children.cycles-pp.__call_rcu
      0.20 ± 14%      -0.1        0.13        perf-profile.children.cycles-pp.inode_init_always
      0.17 ± 12%      -0.1        0.11 ±  4%  perf-profile.children.cycles-pp.__list_add_valid
      0.15 ± 17%      -0.1        0.08 ±  5%  perf-profile.children.cycles-pp.shmem_unlink
      0.08 ± 15%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.drop_nlink
      0.12 ± 21%      -0.1        0.07        perf-profile.children.cycles-pp.fsnotify
      0.13 ± 14%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.may_open
      0.14 ± 13%      -0.0        0.10 ±  5%  perf-profile.children.cycles-pp.may_delete
      0.07 ± 12%      -0.0        0.03 ±100%  perf-profile.children.cycles-pp.security_file_alloc
      0.10 ± 18%      -0.0        0.06 ± 11%  perf-profile.children.cycles-pp.inode_init_owner
      0.14 ± 13%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.iput
      0.08 ± 14%      -0.0        0.04 ± 57%  perf-profile.children.cycles-pp.__sb_end_write
      0.10 ± 18%      -0.0        0.06        perf-profile.children.cycles-pp.__sb_start_write
      0.07 ± 11%      -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.security_file_open
      0.06 ± 13%      +0.0        0.09 ±  9%  perf-profile.children.cycles-pp.shmem_alloc_inode
      0.06 ± 11%      +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.strncpy_from_user
      0.04 ± 57%      +0.0        0.07 ±  7%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.04 ± 58%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.walk_component
      0.04 ± 58%      +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.___might_sleep
      0.03 ±100%      +0.0        0.06        perf-profile.children.cycles-pp.lookup_fast
      0.08 ± 10%      +0.0        0.12 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.12 ±  6%      +0.0        0.17 ±  5%  perf-profile.children.cycles-pp.dput
      0.01 ±173%      +0.0        0.05 ±  9%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.01 ±173%      +0.0        0.06        perf-profile.children.cycles-pp.__inode_security_revalidate
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__dentry_kill
      0.07 ±  6%      +0.1        0.12 ±  8%  perf-profile.children.cycles-pp.___slab_alloc
      0.06 ±  7%      +0.1        0.11 ±  9%  perf-profile.children.cycles-pp.new_slab
      0.07 ±  6%      +0.1        0.12 ±  6%  perf-profile.children.cycles-pp.__slab_alloc
      0.00            +0.1        0.06 ±  6%  perf-profile.children.cycles-pp.inode_init_once
      0.19 ±  9%      +0.1        0.26 ±  4%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.00            +0.2        0.21 ±  7%  perf-profile.children.cycles-pp.cna_scan_main_queue
      0.84 ±  9%      +0.4        1.21 ± 10%  perf-profile.children.cycles-pp.__slab_free
      0.87 ±  9%      +0.4        1.25 ± 10%  perf-profile.children.cycles-pp.kmem_cache_free
      1.37 ± 10%      +0.5        1.87 ±  6%  perf-profile.children.cycles-pp.ret_from_fork
      1.37 ± 10%      +0.5        1.87 ±  6%  perf-profile.children.cycles-pp.kthread
      1.36 ± 10%      +0.5        1.86 ±  7%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.34 ± 10%      +0.5        1.85 ±  7%  perf-profile.children.cycles-pp.run_ksoftirqd
      2.32 ± 11%      +0.8        3.12 ± 11%  perf-profile.children.cycles-pp.__softirqentry_text_start
      2.28 ± 11%      +0.8        3.08 ± 10%  perf-profile.children.cycles-pp.rcu_do_batch
      2.28 ± 11%      +0.8        3.08 ± 10%  perf-profile.children.cycles-pp.rcu_core
      0.99 ± 36%      +2.0        3.02 ± 63%  perf-profile.children.cycles-pp.__alloc_fd
      0.91 ± 42%      +2.4        3.32 ± 68%  perf-profile.children.cycles-pp.__close_fd
      0.99 ± 39%      +2.4        3.41 ± 66%  perf-profile.children.cycles-pp.__x64_sys_close
      1.15 ± 35%      +2.5        3.60 ± 62%  perf-profile.children.cycles-pp.__GI___libc_close
      0.00           +57.1       57.05 ±  5%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     60.09 ±  7%     -60.1        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      1.33 ±  9%      -0.4        0.93 ±  6%  perf-profile.self.cycles-pp._raw_spin_lock
      0.74 ± 14%      -0.3        0.47 ± 11%  perf-profile.self.cycles-pp.generic_permission
      0.26 ± 16%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__mnt_want_write
      0.35 ± 16%      -0.1        0.23 ±  7%  perf-profile.self.cycles-pp.__alloc_file
      0.15 ± 22%      -0.1        0.06        perf-profile.self.cycles-pp.timestamp_truncate
      0.22 ±  5%      -0.1        0.14 ± 13%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.15 ±  8%      -0.1        0.07 ± 10%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.22 ± 20%      -0.1        0.14 ± 18%  perf-profile.self.cycles-pp.selinux_inode_permission
      0.15 ± 13%      -0.1        0.08 ± 10%  perf-profile.self.cycles-pp.__destroy_inode
      0.18 ± 12%      -0.1        0.11 ±  6%  perf-profile.self.cycles-pp.path_openat
      0.17 ± 12%      -0.1        0.11 ±  4%  perf-profile.self.cycles-pp.__list_add_valid
      0.12 ± 22%      -0.1        0.06        perf-profile.self.cycles-pp.inode_init_always
      0.08 ± 17%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__alloc_fd
      0.08 ± 15%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.drop_nlink
      0.09 ± 16%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.shmem_reserve_inode
      0.12 ± 25%      -0.0        0.07        perf-profile.self.cycles-pp.fsnotify
      0.09 ± 20%      -0.0        0.05        perf-profile.self.cycles-pp.__sb_start_write
      0.08 ± 14%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.__sb_end_write
      0.10 ± 16%      -0.0        0.06 ± 11%  perf-profile.self.cycles-pp.inode_init_owner
      0.04 ± 58%      +0.0        0.07        perf-profile.self.cycles-pp.___might_sleep
      0.03 ±100%      +0.0        0.07 ± 11%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.__call_rcu
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.inode_init_once
      0.00            +0.2        0.21 ±  9%  perf-profile.self.cycles-pp.cna_scan_main_queue
      0.84 ±  9%      +0.4        1.21 ± 10%  perf-profile.self.cycles-pp.__slab_free
      0.00           +55.9       55.88 ±  4%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
      1137 ± 44%     -64.3%     405.50 ± 33%  interrupts.33:PCI-MSI.524291-edge.eth0-TxRx-2
      5535 ± 20%     +25.4%       6939 ±  5%  interrupts.CPU0.NMI:Non-maskable_interrupts
      5535 ± 20%     +25.4%       6939 ±  5%  interrupts.CPU0.PMI:Performance_monitoring_interrupts
    699.00 ±  2%     +17.6%     822.25 ± 10%  interrupts.CPU1.TLB:TLB_shootdowns
      5464 ± 19%     +28.7%       7032 ±  4%  interrupts.CPU100.NMI:Non-maskable_interrupts
      5464 ± 19%     +28.7%       7032 ±  4%  interrupts.CPU100.PMI:Performance_monitoring_interrupts
      5489 ± 19%     +25.7%       6900 ±  5%  interrupts.CPU101.NMI:Non-maskable_interrupts
      5489 ± 19%     +25.7%       6900 ±  5%  interrupts.CPU101.PMI:Performance_monitoring_interrupts
      5447 ± 19%     +28.8%       7014 ±  5%  interrupts.CPU102.NMI:Non-maskable_interrupts
      5447 ± 19%     +28.8%       7014 ±  5%  interrupts.CPU102.PMI:Performance_monitoring_interrupts
      6448 ±  8%      +8.5%       6998 ±  5%  interrupts.CPU107.NMI:Non-maskable_interrupts
      6448 ±  8%      +8.5%       6998 ±  5%  interrupts.CPU107.PMI:Performance_monitoring_interrupts
      6457 ±  7%      +8.1%       6981 ±  5%  interrupts.CPU109.NMI:Non-maskable_interrupts
      6457 ±  7%      +8.1%       6981 ±  5%  interrupts.CPU109.PMI:Performance_monitoring_interrupts
      1137 ± 44%     -64.3%     405.50 ± 33%  interrupts.CPU11.33:PCI-MSI.524291-edge.eth0-TxRx-2
      5597 ± 26%     +24.9%       6990 ±  4%  interrupts.CPU11.NMI:Non-maskable_interrupts
      5597 ± 26%     +24.9%       6990 ±  4%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    829.50 ± 17%     +24.6%       1033 ±  6%  interrupts.CPU110.TLB:TLB_shootdowns
      6359 ±  8%      +9.4%       6956 ±  4%  interrupts.CPU111.NMI:Non-maskable_interrupts
      6359 ±  8%      +9.4%       6956 ±  4%  interrupts.CPU111.PMI:Performance_monitoring_interrupts
      6327 ±  8%      +9.4%       6921 ±  5%  interrupts.CPU114.NMI:Non-maskable_interrupts
      6327 ±  8%      +9.4%       6921 ±  5%  interrupts.CPU114.PMI:Performance_monitoring_interrupts
      6483 ±  7%      +7.2%       6949 ±  4%  interrupts.CPU115.NMI:Non-maskable_interrupts
      6483 ±  7%      +7.2%       6949 ±  4%  interrupts.CPU115.PMI:Performance_monitoring_interrupts
    732.00 ± 14%     +30.5%     955.25 ±  7%  interrupts.CPU116.TLB:TLB_shootdowns
      6341 ±  8%     +10.1%       6979 ±  4%  interrupts.CPU118.NMI:Non-maskable_interrupts
      6341 ±  8%     +10.1%       6979 ±  4%  interrupts.CPU118.PMI:Performance_monitoring_interrupts
      5612 ± 27%     +25.3%       7032 ±  4%  interrupts.CPU12.NMI:Non-maskable_interrupts
      5612 ± 27%     +25.3%       7032 ±  4%  interrupts.CPU12.PMI:Performance_monitoring_interrupts
    731.75 ± 15%     +35.7%     993.25 ± 18%  interrupts.CPU123.TLB:TLB_shootdowns
    657.75 ± 14%     +50.4%     989.50 ±  7%  interrupts.CPU134.TLB:TLB_shootdowns
    790.75 ± 14%     +21.7%     962.00 ±  6%  interrupts.CPU152.TLB:TLB_shootdowns
    733.25 ±  9%     +24.1%     910.00 ± 10%  interrupts.CPU157.TLB:TLB_shootdowns
      5628 ± 26%     +24.8%       7021 ±  3%  interrupts.CPU16.NMI:Non-maskable_interrupts
      5628 ± 26%     +24.8%       7021 ±  3%  interrupts.CPU16.PMI:Performance_monitoring_interrupts
     66.50 ±139%     -91.7%       5.50 ± 60%  interrupts.CPU16.RES:Rescheduling_interrupts
    712.50 ± 17%     +29.2%     920.25 ± 15%  interrupts.CPU160.TLB:TLB_shootdowns
      4900 ± 38%     +42.5%       6983 ±  5%  interrupts.CPU18.NMI:Non-maskable_interrupts
      4900 ± 38%     +42.5%       6983 ±  5%  interrupts.CPU18.PMI:Performance_monitoring_interrupts
      4899 ± 39%     +42.7%       6990 ±  4%  interrupts.CPU19.NMI:Non-maskable_interrupts
      4899 ± 39%     +42.7%       6990 ±  4%  interrupts.CPU19.PMI:Performance_monitoring_interrupts
    703.75 ± 12%     +15.9%     815.50 ±  9%  interrupts.CPU19.TLB:TLB_shootdowns
    787.00 ±  9%     +16.4%     916.25 ±  5%  interrupts.CPU3.TLB:TLB_shootdowns
    793.50 ± 14%     +16.7%     926.00 ±  6%  interrupts.CPU35.TLB:TLB_shootdowns
    729.50 ±  3%     +19.6%     872.25 ± 14%  interrupts.CPU45.TLB:TLB_shootdowns
    756.50 ± 13%     +26.0%     953.25 ±  6%  interrupts.CPU50.TLB:TLB_shootdowns
      5501 ± 19%     +26.9%       6979 ±  4%  interrupts.CPU57.NMI:Non-maskable_interrupts
      5501 ± 19%     +26.9%       6979 ±  4%  interrupts.CPU57.PMI:Performance_monitoring_interrupts
      5509 ± 19%     +28.2%       7061 ±  3%  interrupts.CPU58.NMI:Non-maskable_interrupts
      5509 ± 19%     +28.2%       7061 ±  3%  interrupts.CPU58.PMI:Performance_monitoring_interrupts
    788.00 ± 19%     +27.4%       1004 ±  7%  interrupts.CPU58.TLB:TLB_shootdowns
      5559 ± 20%     +25.6%       6984 ±  3%  interrupts.CPU59.NMI:Non-maskable_interrupts
      5559 ± 20%     +25.6%       6984 ±  3%  interrupts.CPU59.PMI:Performance_monitoring_interrupts
      5444 ± 19%     +27.4%       6936 ±  5%  interrupts.CPU60.NMI:Non-maskable_interrupts
      5444 ± 19%     +27.4%       6936 ±  5%  interrupts.CPU60.PMI:Performance_monitoring_interrupts
      5497 ± 20%     +26.4%       6948 ±  4%  interrupts.CPU61.NMI:Non-maskable_interrupts
      5497 ± 20%     +26.4%       6948 ±  4%  interrupts.CPU61.PMI:Performance_monitoring_interrupts
      5433 ± 19%     +28.4%       6977 ±  4%  interrupts.CPU62.NMI:Non-maskable_interrupts
      5433 ± 19%     +28.4%       6977 ±  4%  interrupts.CPU62.PMI:Performance_monitoring_interrupts
      5442 ± 19%     +26.9%       6904 ±  6%  interrupts.CPU63.NMI:Non-maskable_interrupts
      5442 ± 19%     +26.9%       6904 ±  6%  interrupts.CPU63.PMI:Performance_monitoring_interrupts
    728.50 ±  9%     +30.3%     949.50 ± 13%  interrupts.CPU63.TLB:TLB_shootdowns
      5457 ± 19%     +27.6%       6962 ±  5%  interrupts.CPU64.NMI:Non-maskable_interrupts
      5457 ± 19%     +27.6%       6962 ±  5%  interrupts.CPU64.PMI:Performance_monitoring_interrupts
      5474 ± 19%     +29.5%       7087 ±  3%  interrupts.CPU65.NMI:Non-maskable_interrupts
      5474 ± 19%     +29.5%       7087 ±  3%  interrupts.CPU65.PMI:Performance_monitoring_interrupts
    692.75 ± 15%     +34.0%     928.00 ± 16%  interrupts.CPU65.TLB:TLB_shootdowns
      5436 ± 19%     +27.5%       6931 ±  5%  interrupts.CPU66.NMI:Non-maskable_interrupts
      5436 ± 19%     +27.5%       6931 ±  5%  interrupts.CPU66.PMI:Performance_monitoring_interrupts
      5492 ± 19%     +25.8%       6907 ±  5%  interrupts.CPU67.NMI:Non-maskable_interrupts
      5492 ± 19%     +25.8%       6907 ±  5%  interrupts.CPU67.PMI:Performance_monitoring_interrupts
      5492 ± 19%     +27.0%       6973 ±  4%  interrupts.CPU68.NMI:Non-maskable_interrupts
      5492 ± 19%     +27.0%       6973 ±  4%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      5513 ± 19%     +26.7%       6983 ±  3%  interrupts.CPU69.NMI:Non-maskable_interrupts
      5513 ± 19%     +26.7%       6983 ±  3%  interrupts.CPU69.PMI:Performance_monitoring_interrupts
      5522 ± 19%     +26.2%       6971 ±  5%  interrupts.CPU70.NMI:Non-maskable_interrupts
      5522 ± 19%     +26.2%       6971 ±  5%  interrupts.CPU70.PMI:Performance_monitoring_interrupts
      5535 ± 20%     +25.2%       6928 ±  4%  interrupts.CPU71.NMI:Non-maskable_interrupts
      5535 ± 20%     +25.2%       6928 ±  4%  interrupts.CPU71.PMI:Performance_monitoring_interrupts
      5472 ± 19%     +28.4%       7026 ±  3%  interrupts.CPU72.NMI:Non-maskable_interrupts
      5472 ± 19%     +28.4%       7026 ±  3%  interrupts.CPU72.PMI:Performance_monitoring_interrupts
      5556 ± 20%     +25.1%       6951 ±  5%  interrupts.CPU73.NMI:Non-maskable_interrupts
      5556 ± 20%     +25.1%       6951 ±  5%  interrupts.CPU73.PMI:Performance_monitoring_interrupts
      5524 ± 19%     +25.8%       6948 ±  5%  interrupts.CPU74.NMI:Non-maskable_interrupts
      5524 ± 19%     +25.8%       6948 ±  5%  interrupts.CPU74.PMI:Performance_monitoring_interrupts
      5462 ± 19%     +28.4%       7012 ±  3%  interrupts.CPU75.NMI:Non-maskable_interrupts
      5462 ± 19%     +28.4%       7012 ±  3%  interrupts.CPU75.PMI:Performance_monitoring_interrupts
      5409 ± 19%     +28.5%       6949 ±  5%  interrupts.CPU76.NMI:Non-maskable_interrupts
      5409 ± 19%     +28.5%       6949 ±  5%  interrupts.CPU76.PMI:Performance_monitoring_interrupts
      5494 ± 20%     +27.0%       6978 ±  4%  interrupts.CPU77.NMI:Non-maskable_interrupts
      5494 ± 20%     +27.0%       6978 ±  4%  interrupts.CPU77.PMI:Performance_monitoring_interrupts
      5522 ± 19%     +26.4%       6978 ±  4%  interrupts.CPU78.NMI:Non-maskable_interrupts
      5522 ± 19%     +26.4%       6978 ±  4%  interrupts.CPU78.PMI:Performance_monitoring_interrupts
      5492 ± 19%     +25.2%       6878 ±  6%  interrupts.CPU79.NMI:Non-maskable_interrupts
      5492 ± 19%     +25.2%       6878 ±  6%  interrupts.CPU79.PMI:Performance_monitoring_interrupts
      6330 ±  8%     +10.3%       6981 ±  5%  interrupts.CPU8.NMI:Non-maskable_interrupts
      6330 ±  8%     +10.3%       6981 ±  5%  interrupts.CPU8.PMI:Performance_monitoring_interrupts
      5449 ± 19%     +27.4%       6945 ±  5%  interrupts.CPU80.NMI:Non-maskable_interrupts
      5449 ± 19%     +27.4%       6945 ±  5%  interrupts.CPU80.PMI:Performance_monitoring_interrupts
      5513 ± 20%     +25.7%       6930 ±  3%  interrupts.CPU81.NMI:Non-maskable_interrupts
      5513 ± 20%     +25.7%       6930 ±  3%  interrupts.CPU81.PMI:Performance_monitoring_interrupts
      5441 ± 19%     +27.2%       6919 ±  6%  interrupts.CPU82.NMI:Non-maskable_interrupts
      5441 ± 19%     +27.2%       6919 ±  6%  interrupts.CPU82.PMI:Performance_monitoring_interrupts
      5498 ± 19%     +26.2%       6941 ±  5%  interrupts.CPU83.NMI:Non-maskable_interrupts
      5498 ± 19%     +26.2%       6941 ±  5%  interrupts.CPU83.PMI:Performance_monitoring_interrupts
      5520 ± 19%     +25.4%       6924 ±  5%  interrupts.CPU85.NMI:Non-maskable_interrupts
      5520 ± 19%     +25.4%       6924 ±  5%  interrupts.CPU85.PMI:Performance_monitoring_interrupts
      5468 ± 19%     +24.8%       6827 ±  6%  interrupts.CPU86.NMI:Non-maskable_interrupts
      5468 ± 19%     +24.8%       6827 ±  6%  interrupts.CPU86.PMI:Performance_monitoring_interrupts
      5513 ± 20%     +24.7%       6875 ±  4%  interrupts.CPU87.NMI:Non-maskable_interrupts
      5513 ± 20%     +24.7%       6875 ±  4%  interrupts.CPU87.PMI:Performance_monitoring_interrupts
      5522 ± 20%     +26.7%       6996 ±  4%  interrupts.CPU88.NMI:Non-maskable_interrupts
      5522 ± 20%     +26.7%       6996 ±  4%  interrupts.CPU88.PMI:Performance_monitoring_interrupts
      5443 ± 19%     +27.7%       6950 ±  6%  interrupts.CPU89.NMI:Non-maskable_interrupts
      5443 ± 19%     +27.7%       6950 ±  6%  interrupts.CPU89.PMI:Performance_monitoring_interrupts
    778.25 ± 14%     +34.2%       1044 ±  8%  interrupts.CPU89.TLB:TLB_shootdowns
      5615 ± 27%     +25.7%       7060 ±  5%  interrupts.CPU9.NMI:Non-maskable_interrupts
      5615 ± 27%     +25.7%       7060 ±  5%  interrupts.CPU9.PMI:Performance_monitoring_interrupts
      5483 ± 20%     +26.0%       6908 ±  6%  interrupts.CPU90.NMI:Non-maskable_interrupts
      5483 ± 20%     +26.0%       6908 ±  6%  interrupts.CPU90.PMI:Performance_monitoring_interrupts
      5529 ± 19%     +25.9%       6960 ±  4%  interrupts.CPU91.NMI:Non-maskable_interrupts
      5529 ± 19%     +25.9%       6960 ±  4%  interrupts.CPU91.PMI:Performance_monitoring_interrupts
      5503 ± 20%     +25.9%       6931 ±  5%  interrupts.CPU92.NMI:Non-maskable_interrupts
      5503 ± 20%     +25.9%       6931 ±  5%  interrupts.CPU92.PMI:Performance_monitoring_interrupts
      5479 ± 19%     +27.7%       6998 ±  4%  interrupts.CPU93.NMI:Non-maskable_interrupts
      5479 ± 19%     +27.7%       6998 ±  4%  interrupts.CPU93.PMI:Performance_monitoring_interrupts
      5508 ± 19%     +24.9%       6878 ±  6%  interrupts.CPU94.NMI:Non-maskable_interrupts
      5508 ± 19%     +24.9%       6878 ±  6%  interrupts.CPU94.PMI:Performance_monitoring_interrupts
      5559 ± 20%     +23.8%       6882 ±  5%  interrupts.CPU95.NMI:Non-maskable_interrupts
      5559 ± 20%     +23.8%       6882 ±  5%  interrupts.CPU95.PMI:Performance_monitoring_interrupts
      5475 ± 19%     +28.3%       7023 ±  4%  interrupts.CPU96.NMI:Non-maskable_interrupts
      5475 ± 19%     +28.3%       7023 ±  4%  interrupts.CPU96.PMI:Performance_monitoring_interrupts
      5480 ± 19%     +28.0%       7015 ±  4%  interrupts.CPU97.NMI:Non-maskable_interrupts
      5480 ± 19%     +28.0%       7015 ±  4%  interrupts.CPU97.PMI:Performance_monitoring_interrupts
      5537 ± 20%     +26.7%       7017 ±  4%  interrupts.CPU98.NMI:Non-maskable_interrupts
      5537 ± 20%     +26.7%       7017 ±  4%  interrupts.CPU98.PMI:Performance_monitoring_interrupts
      5509 ± 19%     +26.2%       6952 ±  4%  interrupts.CPU99.NMI:Non-maskable_interrupts
      5509 ± 19%     +26.2%       6952 ±  4%  interrupts.CPU99.PMI:Performance_monitoring_interrupts
     32817           -75.0%       8195 ±  9%  softirqs.CPU0.RCU
     37804 ±  2%     -77.9%       8371 ±  6%  softirqs.CPU1.RCU
     37107           -76.7%       8662 ±  9%  softirqs.CPU10.RCU
     37389 ±  3%     -79.5%       7651 ±  7%  softirqs.CPU100.RCU
     37150           -78.8%       7864 ±  4%  softirqs.CPU101.RCU
     36237           -78.7%       7713 ±  4%  softirqs.CPU102.RCU
     36630 ±  2%     -79.6%       7470 ±  4%  softirqs.CPU103.RCU
     36437           -79.3%       7555 ±  5%  softirqs.CPU104.RCU
     36242 ±  2%     -81.0%       6875 ± 10%  softirqs.CPU105.RCU
     36592           -79.4%       7541 ±  3%  softirqs.CPU106.RCU
     36170           -78.2%       7885 ±  6%  softirqs.CPU107.RCU
     37424 ±  3%     -80.9%       7155 ±  9%  softirqs.CPU108.RCU
     36434           -78.8%       7740 ±  5%  softirqs.CPU109.RCU
     36767           -77.7%       8193 ±  4%  softirqs.CPU11.RCU
     36384           -79.1%       7609 ±  4%  softirqs.CPU110.RCU
     36819           -79.9%       7394 ±  3%  softirqs.CPU111.RCU
     36302           -77.8%       8076 ±  8%  softirqs.CPU112.RCU
     36874           -79.1%       7691 ±  7%  softirqs.CPU113.RCU
     37614 ±  3%     -80.0%       7537 ±  4%  softirqs.CPU114.RCU
     36309           -78.6%       7784 ±  3%  softirqs.CPU115.RCU
     36019           -78.9%       7607 ±  3%  softirqs.CPU116.RCU
     36325           -78.1%       7964 ±  5%  softirqs.CPU117.RCU
     36251           -79.0%       7605 ±  6%  softirqs.CPU118.RCU
     36363           -78.8%       7718 ±  6%  softirqs.CPU119.RCU
     36549           -73.0%       9853 ± 11%  softirqs.CPU12.RCU
     36629           -77.1%       8390 ±  5%  softirqs.CPU120.RCU
     36826           -76.3%       8724 ±  3%  softirqs.CPU121.RCU
     36974           -77.3%       8399 ±  7%  softirqs.CPU122.RCU
     36750           -77.2%       8375 ±  7%  softirqs.CPU123.RCU
     36763           -77.6%       8219 ±  6%  softirqs.CPU124.RCU
     36632           -76.4%       8651 ±  3%  softirqs.CPU125.RCU
     36767 ±  2%     -77.4%       8302 ±  3%  softirqs.CPU126.RCU
     36987           -75.5%       9069 ±  2%  softirqs.CPU127.RCU
     36897           -77.9%       8164 ±  4%  softirqs.CPU128.RCU
     36802           -77.5%       8293 ±  3%  softirqs.CPU129.RCU
     37345           -78.4%       8060 ±  6%  softirqs.CPU13.RCU
     36961           -78.4%       7965 ±  3%  softirqs.CPU130.RCU
     36821           -76.9%       8510 ±  6%  softirqs.CPU131.RCU
     37076           -77.1%       8474 ± 11%  softirqs.CPU132.RCU
     36790           -78.1%       8065 ±  7%  softirqs.CPU133.RCU
     36815           -77.3%       8341 ±  7%  softirqs.CPU134.RCU
     36919           -77.1%       8444 ±  6%  softirqs.CPU135.RCU
     36779           -76.5%       8631 ±  7%  softirqs.CPU136.RCU
     36743           -77.2%       8380 ±  5%  softirqs.CPU137.RCU
     36757           -77.7%       8182 ±  7%  softirqs.CPU138.RCU
     36672           -77.3%       8309 ± 10%  softirqs.CPU139.RCU
     36653           -78.0%       8047 ±  4%  softirqs.CPU14.RCU
     36633           -78.0%       8061 ±  7%  softirqs.CPU140.RCU
     36514           -77.9%       8077 ±  9%  softirqs.CPU141.RCU
     36639           -76.7%       8537 ±  7%  softirqs.CPU142.RCU
     37114           -77.2%       8447 ±  4%  softirqs.CPU143.RCU
     36127           -76.2%       8598 ±  5%  softirqs.CPU144.RCU
     36113           -75.5%       8833 ± 10%  softirqs.CPU145.RCU
     35878           -75.7%       8730 ±  8%  softirqs.CPU146.RCU
     35775           -76.5%       8418 ±  6%  softirqs.CPU147.RCU
     35833           -77.1%       8200 ± 10%  softirqs.CPU148.RCU
     36232           -77.7%       8066 ±  7%  softirqs.CPU149.RCU
     36878 ±  2%     -77.7%       8216 ±  8%  softirqs.CPU15.RCU
     36296 ±  2%     -76.8%       8434 ±  8%  softirqs.CPU150.RCU
     36273 ±  2%     -76.3%       8608 ±  9%  softirqs.CPU151.RCU
     36330           -76.3%       8613 ±  9%  softirqs.CPU152.RCU
     36127           -77.5%       8143 ±  6%  softirqs.CPU153.RCU
     35627           -76.8%       8262 ±  5%  softirqs.CPU154.RCU
     36544           -77.0%       8396 ±  8%  softirqs.CPU155.RCU
     36603           -77.8%       8120 ±  9%  softirqs.CPU156.RCU
     35955 ±  2%     -77.0%       8286 ±  7%  softirqs.CPU157.RCU
     36401           -77.2%       8309 ±  8%  softirqs.CPU158.RCU
     35992           -77.0%       8273 ± 12%  softirqs.CPU159.RCU
     36719           -77.5%       8258 ±  4%  softirqs.CPU16.RCU
     36245           -76.9%       8366 ±  9%  softirqs.CPU160.RCU
     36427           -75.2%       9027 ± 12%  softirqs.CPU161.RCU
     36674           -75.6%       8932 ± 12%  softirqs.CPU162.RCU
     37059           -77.2%       8440 ±  9%  softirqs.CPU163.RCU
     36414           -76.1%       8713 ±  9%  softirqs.CPU164.RCU
     36814           -76.2%       8757 ±  7%  softirqs.CPU165.RCU
     36797           -77.7%       8194 ±  7%  softirqs.CPU166.RCU
     36779 ±  2%     -76.2%       8768 ±  5%  softirqs.CPU167.RCU
     36322 ±  2%     -78.2%       7915 ± 12%  softirqs.CPU168.RCU
     36036           -77.6%       8089 ±  7%  softirqs.CPU169.RCU
     36888           -77.5%       8311 ±  4%  softirqs.CPU17.RCU
     36250 ±  2%     -79.1%       7578 ±  4%  softirqs.CPU170.RCU
     36123           -78.1%       7918 ±  7%  softirqs.CPU171.RCU
     36330           -77.1%       8306 ±  7%  softirqs.CPU172.RCU
     36640           -77.3%       8332 ±  8%  softirqs.CPU173.RCU
     36449 ±  2%     -78.3%       7913 ±  4%  softirqs.CPU174.RCU
     36338           -77.0%       8342 ±  5%  softirqs.CPU175.RCU
     36151 ±  2%     -78.5%       7776 ±  4%  softirqs.CPU176.RCU
     36145           -78.2%       7870 ±  5%  softirqs.CPU177.RCU
     35819 ±  2%     -78.6%       7655 ±  4%  softirqs.CPU178.RCU
     35742           -79.0%       7515 ±  6%  softirqs.CPU179.RCU
     36950           -78.1%       8094        softirqs.CPU18.RCU
     35624           -77.5%       8020 ±  5%  softirqs.CPU180.RCU
     36120           -79.1%       7535 ±  6%  softirqs.CPU181.RCU
     36321           -78.7%       7733 ±  3%  softirqs.CPU182.RCU
     35597           -77.0%       8196 ± 10%  softirqs.CPU183.RCU
     36132 ±  2%     -77.8%       8018 ±  9%  softirqs.CPU184.RCU
     36163 ±  2%     -78.6%       7730 ±  4%  softirqs.CPU185.RCU
     35733           -78.7%       7601 ±  4%  softirqs.CPU186.RCU
     36153 ±  2%     -79.3%       7472 ±  5%  softirqs.CPU187.RCU
     36185           -77.9%       7998 ± 10%  softirqs.CPU188.RCU
     36420 ±  2%     -78.0%       8026 ±  5%  softirqs.CPU189.RCU
     37188           -77.4%       8386 ±  5%  softirqs.CPU19.RCU
     36052 ±  2%     -78.4%       7785 ±  6%  softirqs.CPU190.RCU
     36624 ±  3%     -79.3%       7586 ±  5%  softirqs.CPU191.RCU
     37120           -78.1%       8144 ±  2%  softirqs.CPU2.RCU
     36746           -77.9%       8116 ±  8%  softirqs.CPU20.RCU
     37604           -78.2%       8185 ±  3%  softirqs.CPU21.RCU
     37218 ±  2%     -79.0%       7820 ±  5%  softirqs.CPU22.RCU
     36829           -78.5%       7931 ±  4%  softirqs.CPU23.RCU
     37515 ±  2%     -74.2%       9685 ±  4%  softirqs.CPU24.RCU
     37392           -75.9%       9019 ±  3%  softirqs.CPU25.RCU
     37491           -74.9%       9411 ±  3%  softirqs.CPU26.RCU
     37650           -76.5%       8843 ±  4%  softirqs.CPU27.RCU
     38138           -77.1%       8721 ±  7%  softirqs.CPU28.RCU
     37577           -76.4%       8851 ±  6%  softirqs.CPU29.RCU
     37042           -73.7%       9726 ± 23%  softirqs.CPU3.RCU
     37544           -76.3%       8893 ±  6%  softirqs.CPU30.RCU
     38053           -77.2%       8677 ±  5%  softirqs.CPU31.RCU
     37222           -76.6%       8719 ±  8%  softirqs.CPU32.RCU
     37838           -78.1%       8274 ±  4%  softirqs.CPU33.RCU
     36804 ±  2%     -76.5%       8640 ±  3%  softirqs.CPU34.RCU
     37027           -76.9%       8548 ±  3%  softirqs.CPU35.RCU
     37487           -76.3%       8894 ±  5%  softirqs.CPU36.RCU
     37491           -77.2%       8566 ±  5%  softirqs.CPU37.RCU
     37447 ±  2%     -76.6%       8767 ±  6%  softirqs.CPU38.RCU
     36926           -76.8%       8562 ±  4%  softirqs.CPU39.RCU
     37159           -74.4%       9524 ± 23%  softirqs.CPU4.RCU
     37474 ±  2%     -75.1%       9337 ±  5%  softirqs.CPU40.RCU
     36979           -77.0%       8516 ±  5%  softirqs.CPU41.RCU
     37649           -75.3%       9290 ±  7%  softirqs.CPU42.RCU
     37569           -76.1%       8988 ±  6%  softirqs.CPU43.RCU
     37125           -75.9%       8930 ±  8%  softirqs.CPU44.RCU
     37251           -76.6%       8723 ±  3%  softirqs.CPU45.RCU
     37746           -76.1%       9012 ±  7%  softirqs.CPU46.RCU
     37270           -76.9%       8621 ±  6%  softirqs.CPU47.RCU
     37328           -75.3%       9236 ±  3%  softirqs.CPU48.RCU
     36703           -76.4%       8669 ±  7%  softirqs.CPU49.RCU
     37053           -75.1%       9236 ± 20%  softirqs.CPU5.RCU
     36807           -76.5%       8656 ±  5%  softirqs.CPU50.RCU
     36488           -75.2%       9050 ±  6%  softirqs.CPU51.RCU
     36664           -76.5%       8605 ±  6%  softirqs.CPU52.RCU
     36710           -75.7%       8915 ±  8%  softirqs.CPU53.RCU
     36884           -76.3%       8735 ±  5%  softirqs.CPU54.RCU
     36527           -77.0%       8415 ±  5%  softirqs.CPU55.RCU
     37519           -77.5%       8440 ±  5%  softirqs.CPU56.RCU
     36882           -77.1%       8440 ±  6%  softirqs.CPU57.RCU
     36808           -76.6%       8630 ±  7%  softirqs.CPU58.RCU
     36680           -75.7%       8926 ±  5%  softirqs.CPU59.RCU
     36417           -77.2%       8321 ±  5%  softirqs.CPU6.RCU
     36783           -76.7%       8558 ±  7%  softirqs.CPU60.RCU
     36772           -76.9%       8490 ±  8%  softirqs.CPU61.RCU
     36673           -76.5%       8634 ±  7%  softirqs.CPU62.RCU
     37173           -76.9%       8576 ±  7%  softirqs.CPU63.RCU
     37344           -76.3%       8854 ±  7%  softirqs.CPU64.RCU
     36776           -75.4%       9059 ± 10%  softirqs.CPU65.RCU
     36794           -75.1%       9170 ± 14%  softirqs.CPU66.RCU
     36727           -74.9%       9200 ±  9%  softirqs.CPU67.RCU
     36881           -76.0%       8854 ±  4%  softirqs.CPU68.RCU
     37248           -76.0%       8924 ±  6%  softirqs.CPU69.RCU
     36853           -78.7%       7849 ±  3%  softirqs.CPU7.RCU
     37149           -75.0%       9269 ±  5%  softirqs.CPU70.RCU
     36727           -75.5%       9003 ±  7%  softirqs.CPU71.RCU
     36539 ±  3%     -75.4%       8993 ±  4%  softirqs.CPU72.RCU
     36858 ±  3%     -77.1%       8439 ±  7%  softirqs.CPU73.RCU
     37313 ±  3%     -77.8%       8302        softirqs.CPU74.RCU
     36604 ±  2%     -77.8%       8122 ±  4%  softirqs.CPU75.RCU
     36784           -77.8%       8184 ±  4%  softirqs.CPU76.RCU
     36613           -77.5%       8227 ±  6%  softirqs.CPU77.RCU
     36878           -76.5%       8670 ±  6%  softirqs.CPU78.RCU
     36555           -78.2%       7976 ±  7%  softirqs.CPU79.RCU
     37264           -78.9%       7876        softirqs.CPU8.RCU
     36651           -78.0%       8072 ±  6%  softirqs.CPU80.RCU
     36430           -78.0%       8006 ±  4%  softirqs.CPU81.RCU
     36702 ±  2%     -77.7%       8173 ±  9%  softirqs.CPU82.RCU
     36562           -76.7%       8529 ±  5%  softirqs.CPU83.RCU
     36679           -77.5%       8240 ±  6%  softirqs.CPU84.RCU
     36649           -77.1%       8397 ±  5%  softirqs.CPU85.RCU
     36732           -77.8%       8157 ±  3%  softirqs.CPU86.RCU
     36837 ±  2%     -77.6%       8253 ±  4%  softirqs.CPU87.RCU
     36234 ±  2%     -76.7%       8448 ±  8%  softirqs.CPU88.RCU
     36122 ±  2%     -76.8%       8390 ±  3%  softirqs.CPU89.RCU
     38312 ±  5%     -72.4%      10584 ±  9%  softirqs.CPU9.RCU
     36272           -77.3%       8231 ±  5%  softirqs.CPU90.RCU
     36411           -76.6%       8512 ±  2%  softirqs.CPU91.RCU
     36493           -77.6%       8180 ±  8%  softirqs.CPU92.RCU
     36389 ±  2%     -77.4%       8227 ±  8%  softirqs.CPU93.RCU
     36848 ±  2%     -77.8%       8173 ±  6%  softirqs.CPU94.RCU
     36528 ±  3%     -77.2%       8316 ±  4%  softirqs.CPU95.RCU
     36724 ±  2%     -77.5%       8270 ±  6%  softirqs.CPU96.RCU
     35835           -78.0%       7876 ±  8%  softirqs.CPU97.RCU
     39906 ±  5%     -78.1%       8758 ± 20%  softirqs.CPU98.RCU
     37384 ±  2%     -76.5%       8801 ± 20%  softirqs.CPU99.RCU
   7051654           -77.2%    1606631        softirqs.RCU


                                                                                
                            will-it-scale.per_thread_ops                        
                                                                                
  13000 +-+-----------------------------------------------------------------+   
        |    O                            O        O                        |   
  12000 O-O    O            O                           O                   |   
        |               O                            O    O O               |   
  11000 +-+      O                      O        O                          |   
        |                                                                   |   
  10000 +-+                          O         O                            |   
        |                                                                   |   
   9000 +-+           O   O      O O        O                               |   
        |          O           O                                            |   
   8000 +-+                                                                 |   
        |                                                                   |   
   7000 +-+..+.      .+. .+.        .+..+.      .+.+.  .+.   .+..+.+.      .|   
        |      +.+.+.   +   +..+.+.+      +.+..+     +.   +.+        +.+..+ |   
   6000 +-+-----------------------------------------------------------------+   
                                                                                
                                                                                
[*] bisect-good sample
[O] bisect-bad  sample

***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-2019-09-23.cgz/lkp-csl-2ap4/unlink2/will-it-scale/0x500002b

commit: 
  2f65452ad7 ("locking/qspinlock: Refactor the qspinlock slow path")
  ad3836e30e ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

2f65452ad747deeb ad3836e30e6f5f5e97867707b57 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :4           25%           1:5     kmsg.ipmi_si_dmi-ipmi-si.#:IRQ_index#not_found
           :4           25%           1:5     dmesg.WARNING:at_ip__slab_free/0x
          2:4          -50%            :5     dmesg.WARNING:stack_recursion
         %stddev     %change         %stddev
             \          |                \  
      3589          +200.6%      10789 ± 28%  will-it-scale.per_thread_ops
    301.80           +51.6%     457.59 ± 25%  will-it-scale.time.elapsed_time
    301.80           +51.6%     457.59 ± 25%  will-it-scale.time.elapsed_time.max
    538317 ± 19%     -49.8%     270260 ± 19%  will-it-scale.time.involuntary_context_switches
     18974            -4.5%      18120        will-it-scale.time.percent_of_cpu_this_job_got
     57208           +44.4%      82631 ± 24%  will-it-scale.time.system_time
     57.16 ± 12%    +117.3%     124.19 ± 27%  will-it-scale.time.user_time
    689308          +200.5%    2071580 ± 28%  will-it-scale.workload
 2.967e+08 ±  3%     +71.1%  5.077e+08 ± 12%  cpuidle.C6.time
    133491 ± 12%    +148.4%     331599 ± 21%  cpuidle.C6.usage
      0.54 ± 10%      +0.8        1.34 ± 30%  mpstat.cpu.all.idle%
      0.99 ± 17%      +6.5        7.46 ± 35%  mpstat.cpu.all.soft%
      0.12 ± 10%      +0.0        0.16 ±  2%  mpstat.cpu.all.usr%
     53283 ± 29%    +153.3%     134950 ± 32%  turbostat.C6
      0.23          +143.5%       0.56 ± 25%  turbostat.CPU%c1
  60554120           +49.2%   90359967 ± 24%  turbostat.IRQ
   1385680           +70.8%    2366201 ± 31%  vmstat.memory.cache
    191.50           +38.8%     265.75 ± 16%  vmstat.procs.r
      3928 ± 17%     -36.7%       2487 ±  8%  vmstat.system.cs
    395703           +56.9%     620682 ± 28%  vmstat.system.in
  14040232 ±  2%     -11.7%   12403899 ±  8%  meminfo.DirectMap2M
    139666          +625.1%    1012761 ± 64%  meminfo.KReclaimable
   2976334          +185.5%    8495952 ± 47%  meminfo.Memused
    139666          +625.1%    1012761 ± 64%  meminfo.SReclaimable
    460844         +1005.1%    5092995 ± 66%  meminfo.SUnreclaim
    600511          +916.8%    6105757 ± 66%  meminfo.Slab
     12287          +823.6%     113477 ± 70%  meminfo.max_used_kB
    563285 ± 45%   +1181.6%    7218926 ±  9%  numa-numastat.node0.local_node
    571064 ± 44%   +1169.0%    7246937 ±  9%  numa-numastat.node0.numa_hit
      7784 ±172%    +259.9%      28014 ± 19%  numa-numastat.node0.other_node
    303638 ± 24%   +4426.1%   13742834 ± 47%  numa-numastat.node1.local_node
    334813 ± 22%   +4011.2%   13764707 ± 47%  numa-numastat.node1.numa_hit
    392452 ± 43%   +2457.2%   10035735 ± 49%  numa-numastat.node2.local_node
    415860 ± 40%   +2318.1%   10055889 ± 49%  numa-numastat.node2.numa_hit
    608923 ± 35%   +1556.8%   10088489 ± 48%  numa-numastat.node3.local_node
    640100 ± 34%   +1479.7%   10111949 ± 47%  numa-numastat.node3.numa_hit
   4843522            -2.8%    4710146 ±  2%  proc-vmstat.nr_dirty_background_threshold
   9698888            -2.8%    9431809 ±  2%  proc-vmstat.nr_dirty_threshold
  48688478            -2.7%   47350797 ±  2%  proc-vmstat.nr_free_pages
     34909          +606.2%     246543 ± 63%  proc-vmstat.nr_slab_reclaimable
    115142          +974.2%    1236854 ± 66%  proc-vmstat.nr_slab_unreclaimable
      4202 ± 13%     +55.1%       6516 ± 52%  proc-vmstat.numa_hint_faults_local
   1981117 ± 12%   +1978.2%   41171805 ± 36%  proc-vmstat.numa_hit
   1887557 ± 13%   +2076.3%   41078283 ± 37%  proc-vmstat.numa_local
   7997319 ± 22%   +1966.2%  1.652e+08 ± 35%  proc-vmstat.pgalloc_normal
   1059857           -19.1%     857263 ±  9%  proc-vmstat.pgfault
   7913949 ± 22%   +1982.9%  1.648e+08 ± 35%  proc-vmstat.pgfree
    356338         +1313.0%    5035198 ± 69%  slabinfo.Acpi-Parse.active_objs
      4882         +1313.3%      68999 ± 69%  slabinfo.Acpi-Parse.active_slabs
    356438         +1313.1%    5036995 ± 69%  slabinfo.Acpi-Parse.num_objs
      4882         +1313.3%      68999 ± 69%  slabinfo.Acpi-Parse.num_slabs
    326546         +1430.7%    4998350 ± 70%  slabinfo.dentry.active_objs
      7782         +1430.2%     119076 ± 69%  slabinfo.dentry.active_slabs
    326859         +1430.1%    5001249 ± 69%  slabinfo.dentry.num_objs
      7782         +1430.2%     119076 ± 69%  slabinfo.dentry.num_slabs
      4469 ±  6%     +37.8%       6159 ± 18%  slabinfo.eventpoll_pwq.active_objs
      4469 ±  6%     +37.8%       6159 ± 18%  slabinfo.eventpoll_pwq.num_objs
    219095         +2134.9%    4896580 ± 71%  slabinfo.filp.active_objs
      3450         +2119.1%      76558 ± 71%  slabinfo.filp.active_slabs
    220845         +2118.6%    4899769 ± 71%  slabinfo.filp.num_objs
      3450         +2119.1%      76558 ± 71%  slabinfo.filp.num_slabs
    111.50 ± 13%     +96.4%     219.00 ± 29%  slabinfo.nfs_read_data.active_objs
    111.50 ± 13%     +96.4%     219.00 ± 29%  slabinfo.nfs_read_data.num_objs
    183747 ±  2%   +2552.9%    4874568 ± 71%  slabinfo.shmem_inode_cache.active_objs
      4159 ±  3%   +2449.4%     106043 ± 71%  slabinfo.shmem_inode_cache.active_slabs
    191357 ±  3%   +2449.2%    4878015 ± 71%  slabinfo.shmem_inode_cache.num_objs
      4159 ±  3%   +2449.4%     106043 ± 71%  slabinfo.shmem_inode_cache.num_slabs
    719.25 ± 16%     +27.6%     917.50 ± 10%  slabinfo.skbuff_fclone_cache.active_objs
    719.25 ± 16%     +27.6%     917.50 ± 10%  slabinfo.skbuff_fclone_cache.num_objs
      6.00 ±173%  +19462.5%       1173 ± 56%  numa-meminfo.node0.Active(file)
     39356 ± 14%    +318.1%     164559 ± 50%  numa-meminfo.node0.KReclaimable
    808315 ±  8%     +94.3%    1570721 ± 33%  numa-meminfo.node0.MemUsed
     39356 ± 14%    +318.1%     164559 ± 50%  numa-meminfo.node0.SReclaimable
    116559 ±  4%    +595.7%     810925 ± 49%  numa-meminfo.node0.SUnreclaim
    155916 ±  6%    +525.6%     975485 ± 50%  numa-meminfo.node0.Slab
     37129 ± 15%    +862.1%     357208 ± 73%  numa-meminfo.node1.KReclaimable
     11138 ± 12%     -30.2%       7770 ± 17%  numa-meminfo.node1.Mapped
    702582 ±  9%    +293.0%    2761456 ± 60%  numa-meminfo.node1.MemUsed
     37129 ± 15%    +862.1%     357208 ± 73%  numa-meminfo.node1.SReclaimable
    117793 ±  7%   +1447.1%    1822364 ± 75%  numa-meminfo.node1.SUnreclaim
    154922 ±  9%   +1306.9%    2179573 ± 75%  numa-meminfo.node1.Slab
     28700 ± 17%    +819.5%     263899 ± 81%  numa-meminfo.node2.KReclaimable
      7756 ± 28%     +51.2%      11730 ± 15%  numa-meminfo.node2.Mapped
    723422 ± 10%    +196.8%    2147227 ± 62%  numa-meminfo.node2.MemUsed
     28700 ± 17%    +819.5%     263899 ± 81%  numa-meminfo.node2.SReclaimable
    104664 ±  6%   +1155.0%    1313542 ± 86%  numa-meminfo.node2.SUnreclaim
    133365 ±  8%   +1082.8%    1577442 ± 85%  numa-meminfo.node2.Slab
     34401 ± 24%    +584.3%     235412 ± 70%  numa-meminfo.node3.KReclaimable
    741509 ± 11%    +179.9%    2075506 ± 49%  numa-meminfo.node3.MemUsed
     34401 ± 24%    +584.3%     235412 ± 70%  numa-meminfo.node3.SReclaimable
    121556 ± 14%    +883.1%    1195072 ± 72%  numa-meminfo.node3.SUnreclaim
    155958 ± 16%    +817.2%    1430484 ± 72%  numa-meminfo.node3.Slab
      1.50 ±173%  +19450.0%     293.25 ± 56%  numa-vmstat.node0.nr_active_file
     15.50 ±173%    +874.2%     151.00 ± 37%  numa-vmstat.node0.nr_inactive_file
      9842 ± 14%    +289.4%      38325 ± 48%  numa-vmstat.node0.nr_slab_reclaimable
     29112 ±  4%    +544.4%     187593 ± 47%  numa-vmstat.node0.nr_slab_unreclaimable
      1.50 ±173%  +19450.0%     293.25 ± 56%  numa-vmstat.node0.nr_zone_active_file
     15.50 ±173%    +874.2%     151.00 ± 37%  numa-vmstat.node0.nr_zone_inactive_file
    638578 ± 25%    +510.3%    3897375 ±  8%  numa-vmstat.node0.numa_hit
    630696 ± 26%    +513.7%    3870337 ±  8%  numa-vmstat.node0.numa_local
      9286 ± 15%    +831.0%      86457 ± 72%  numa-vmstat.node1.nr_slab_reclaimable
     29415 ±  7%   +1397.3%     440435 ± 74%  numa-vmstat.node1.nr_slab_unreclaimable
    571276 ± 22%   +1089.9%    6797874 ± 41%  numa-vmstat.node1.numa_hit
    453323 ± 27%   +1375.6%    6689282 ± 42%  numa-vmstat.node1.numa_local
      1974 ± 28%     +52.4%       3009 ± 11%  numa-vmstat.node2.nr_mapped
      7177 ± 17%    +797.9%      64450 ± 79%  numa-vmstat.node2.nr_slab_reclaimable
     26146 ±  6%   +1124.7%     320206 ± 84%  numa-vmstat.node2.nr_slab_unreclaimable
    586126 ± 18%    +804.9%    5303822 ± 48%  numa-vmstat.node2.numa_hit
    475643 ± 24%    +992.6%    5197049 ± 49%  numa-vmstat.node2.numa_local
    156.00 ± 36%     -78.2%      34.00 ±173%  numa-vmstat.node3.nr_inactive_file
      8603 ± 24%    +577.7%      58303 ± 69%  numa-vmstat.node3.nr_slab_reclaimable
     30372 ± 14%    +874.9%     296109 ± 71%  numa-vmstat.node3.nr_slab_unreclaimable
    156.00 ± 36%     -78.2%      34.00 ±173%  numa-vmstat.node3.nr_zone_inactive_file
    668125 ± 21%    +706.8%    5390506 ± 48%  numa-vmstat.node3.numa_hit
    549973 ± 26%    +860.1%    5280260 ± 50%  numa-vmstat.node3.numa_local
      4.32 ±  5%     +96.0%       8.47 ±  3%  perf-stat.i.MPKI
 1.317e+10            +9.7%  1.444e+10        perf-stat.i.branch-instructions
      0.26 ±  2%      +0.1        0.38 ±  5%  perf-stat.i.branch-miss-rate%
  34807513 ±  2%     +51.2%   52616513        perf-stat.i.branch-misses
     58.73           -46.0       12.76 ± 18%  perf-stat.i.cache-miss-rate%
 1.412e+08 ±  5%     -55.8%   62468202 ± 13%  perf-stat.i.cache-misses
 2.405e+08 ±  5%    +118.1%  5.245e+08 ±  3%  perf-stat.i.cache-references
      3875 ± 17%     -49.3%       1963 ± 21%  perf-stat.i.context-switches
     10.63            -9.2%       9.65 ±  4%  perf-stat.i.cpi
      4203 ±  5%    +226.2%      13713 ±  9%  perf-stat.i.cycles-between-cache-misses
   1555417 ±  6%    +165.2%    4125218 ± 57%  perf-stat.i.dTLB-load-misses
 1.449e+10           +16.5%  1.688e+10        perf-stat.i.dTLB-loads
      0.01 ±  4%      +0.0        0.01 ± 40%  perf-stat.i.dTLB-store-miss-rate%
    181513 ±  5%    +236.7%     611231 ± 41%  perf-stat.i.dTLB-store-misses
 2.498e+09           +86.8%  4.666e+09        perf-stat.i.dTLB-stores
  15294329 ±  2%     +71.4%   26213317 ±  2%  perf-stat.i.iTLB-load-misses
    115030 ± 12%    +262.9%     417416 ± 31%  perf-stat.i.iTLB-loads
 5.563e+10           +13.7%  6.327e+10        perf-stat.i.instructions
      3643 ±  2%     -33.6%       2417 ±  3%  perf-stat.i.instructions-per-iTLB-miss
      0.09           +14.3%       0.11        perf-stat.i.ipc
      3280           -34.4%       2151 ± 22%  perf-stat.i.minor-faults
     92.85           -49.9       42.93 ±  2%  perf-stat.i.node-load-miss-rate%
  35667342 ±  5%     -93.3%    2372307 ± 15%  perf-stat.i.node-load-misses
   2735742 ±  7%     +87.8%    5138809 ± 28%  perf-stat.i.node-loads
     89.40           -75.2       14.24 ± 23%  perf-stat.i.node-store-miss-rate%
  18852127 ±  6%     -90.6%    1763129 ± 11%  perf-stat.i.node-store-misses
   2248299 ±  8%    +328.4%    9632213 ±  6%  perf-stat.i.node-stores
      3280           -34.3%       2154 ± 22%  perf-stat.i.page-faults
      4.32 ±  5%     +90.5%       8.24 ±  3%  perf-stat.overall.MPKI
      0.26 ±  2%      +0.1        0.36        perf-stat.overall.branch-miss-rate%
     58.71           -48.7       10.02 ±  3%  perf-stat.overall.cache-miss-rate%
     10.63           -14.5%       9.09        perf-stat.overall.cpi
      4200 ±  5%    +162.6%      11029        perf-stat.overall.cycles-between-cache-misses
      0.01 ±  4%      +0.0        0.01 ± 42%  perf-stat.overall.dTLB-store-miss-rate%
      3639 ±  2%     -32.8%       2444 ±  2%  perf-stat.overall.instructions-per-iTLB-miss
      0.09           +16.9%       0.11        perf-stat.overall.ipc
     92.84           -60.7       32.17 ± 27%  perf-stat.overall.node-load-miss-rate%
     89.33           -76.8       12.49 ± 35%  perf-stat.overall.node-store-miss-rate%
  24046863           -40.3%   14350058 ±  2%  perf-stat.overall.path-length
 1.312e+10           +12.5%  1.477e+10        perf-stat.ps.branch-instructions
  34690150 ±  2%     +51.4%   52532984        perf-stat.ps.branch-misses
 1.408e+08 ±  5%     -62.1%   53302394        perf-stat.ps.cache-misses
 2.397e+08 ±  5%    +122.2%  5.326e+08 ±  3%  perf-stat.ps.cache-references
      3863 ± 17%     -56.5%       1678 ± 36%  perf-stat.ps.context-switches
   1550097 ±  6%    +182.3%    4376644 ± 59%  perf-stat.ps.dTLB-load-misses
 1.444e+10           +19.9%  1.732e+10        perf-stat.ps.dTLB-loads
    180902 ±  5%    +255.2%     642581 ± 43%  perf-stat.ps.dTLB-store-misses
 2.489e+09           +90.8%   4.75e+09 ±  2%  perf-stat.ps.dTLB-stores
  15242824 ±  2%     +73.6%   26467618 ±  2%  perf-stat.ps.iTLB-load-misses
    114701 ± 12%    +159.5%     297692 ± 10%  perf-stat.ps.iTLB-loads
 5.544e+10           +16.6%  6.467e+10        perf-stat.ps.instructions
      3269           -42.6%       1876 ± 36%  perf-stat.ps.minor-faults
  35546821 ±  5%     -94.8%    1856314 ± 37%  perf-stat.ps.node-load-misses
   2726533 ±  7%     +38.2%    3768365 ±  4%  perf-stat.ps.node-loads
  18788461 ±  6%     -92.7%    1365043 ± 33%  perf-stat.ps.node-store-misses
   2240782 ±  8%    +329.8%    9631092 ±  6%  perf-stat.ps.node-stores
      3269           -42.6%       1876 ± 36%  perf-stat.ps.page-faults
 1.657e+13           +78.0%  2.951e+13 ± 26%  perf-stat.total.instructions
    143828 ± 52%   +7207.2%   10509827 ± 66%  sched_debug.cfs_rq:/.MIN_vruntime.avg
   8894516 ± 85%    +296.8%   35290213 ± 39%  sched_debug.cfs_rq:/.MIN_vruntime.max
   1032105 ± 64%   +1063.2%   12005835 ± 54%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
    148958           +46.3%     217939 ± 25%  sched_debug.cfs_rq:/.exec_clock.avg
    150094           +47.0%     220673 ± 25%  sched_debug.cfs_rq:/.exec_clock.max
    360.31 ±  2%    +386.4%       1752 ± 43%  sched_debug.cfs_rq:/.exec_clock.stddev
     11523 ± 23%   +1707.6%     208286 ± 56%  sched_debug.cfs_rq:/.load.avg
    469761 ± 35%    +114.2%    1006039 ± 29%  sched_debug.cfs_rq:/.load.max
     50657 ± 10%    +414.3%     260520 ± 44%  sched_debug.cfs_rq:/.load.stddev
     17.29 ±  7%   +1485.5%     274.11 ± 40%  sched_debug.cfs_rq:/.load_avg.avg
    348.46 ± 24%    +188.9%       1006 ± 22%  sched_debug.cfs_rq:/.load_avg.max
     36.02 ± 11%    +638.7%     266.12 ± 34%  sched_debug.cfs_rq:/.load_avg.stddev
    143828 ± 52%   +7207.2%   10509827 ± 66%  sched_debug.cfs_rq:/.max_vruntime.avg
   8894519 ± 85%    +296.8%   35290213 ± 39%  sched_debug.cfs_rq:/.max_vruntime.max
   1032105 ± 64%   +1063.2%   12005835 ± 54%  sched_debug.cfs_rq:/.max_vruntime.stddev
    222058 ±  9%    +274.2%     831019 ± 41%  sched_debug.cfs_rq:/.min_vruntime.stddev
      0.85           +26.1%       1.07 ± 12%  sched_debug.cfs_rq:/.nr_running.avg
      0.08 ± 14%    +247.9%       0.27 ± 38%  sched_debug.cfs_rq:/.nr_running.stddev
     78.88 ± 75%    +446.7%     431.21 ± 44%  sched_debug.cfs_rq:/.nr_spread_over.min
      5.40 ± 12%   +3319.4%     184.60 ± 63%  sched_debug.cfs_rq:/.runnable_load_avg.avg
    164.75 ± 51%    +352.3%     745.09 ± 37%  sched_debug.cfs_rq:/.runnable_load_avg.max
     12.43 ± 52%   +1615.7%     213.25 ± 51%  sched_debug.cfs_rq:/.runnable_load_avg.stddev
     11501 ± 24%   +1710.7%     208250 ± 56%  sched_debug.cfs_rq:/.runnable_weight.avg
    468967 ± 35%    +114.4%    1005509 ± 29%  sched_debug.cfs_rq:/.runnable_weight.max
     50599 ± 10%    +414.8%     260487 ± 44%  sched_debug.cfs_rq:/.runnable_weight.stddev
    234855 ±122%    -364.0%    -619990        sched_debug.cfs_rq:/.spread0.avg
    490058 ± 46%     +64.6%     806833 ± 44%  sched_debug.cfs_rq:/.spread0.max
  -1117727          +278.5%   -4230958        sched_debug.cfs_rq:/.spread0.min
    222024 ±  9%    +274.3%     830997 ± 41%  sched_debug.cfs_rq:/.spread0.stddev
      1190 ±  9%     +27.5%       1517 ± 12%  sched_debug.cfs_rq:/.util_est_enqueued.max
     91.17 ± 42%    +168.4%     244.74 ± 29%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    932000           +18.3%    1102425 ±  3%  sched_debug.cpu.avg_idle.avg
   1268099 ± 22%    +225.5%    4127538 ± 41%  sched_debug.cpu.avg_idle.max
     94372 ± 17%    +292.9%     370789 ± 40%  sched_debug.cpu.avg_idle.stddev
    188367           +37.4%     258907 ± 21%  sched_debug.cpu.clock.avg
    188401           +37.5%     258960 ± 21%  sched_debug.cpu.clock.max
    188334           +37.4%     258803 ± 21%  sched_debug.cpu.clock.min
     20.76 ± 10%     +87.6%      38.94 ± 18%  sched_debug.cpu.clock.stddev
    188367           +37.4%     258907 ± 21%  sched_debug.cpu.clock_task.avg
    188401           +37.5%     258960 ± 21%  sched_debug.cpu.clock_task.max
    188334           +37.4%     258803 ± 21%  sched_debug.cpu.clock_task.min
     20.76 ± 10%     +87.6%      38.94 ± 18%  sched_debug.cpu.clock_task.stddev
      7529           -13.8%       6492 ±  6%  sched_debug.cpu.curr->pid.max
    546445 ±  8%    +157.5%    1407312 ± 37%  sched_debug.cpu.max_idle_balance_cost.max
      4750 ±107%   +1740.9%      87449 ± 53%  sched_debug.cpu.max_idle_balance_cost.stddev
      0.86           +38.4%       1.19 ± 15%  sched_debug.cpu.nr_running.avg
      2.04 ±  8%     +45.6%       2.97 ± 14%  sched_debug.cpu.nr_running.max
      0.15 ±  9%    +170.6%       0.41 ± 29%  sched_debug.cpu.nr_running.stddev
      5561 ±  6%     -28.2%       3994 ±  4%  sched_debug.cpu.nr_switches.avg
     48679 ± 18%     -60.7%      19152 ±  2%  sched_debug.cpu.nr_switches.max
      3158 ± 23%     -26.9%       2308 ±  4%  sched_debug.cpu.nr_switches.min
      4223 ±  9%     -53.6%       1958        sched_debug.cpu.nr_switches.stddev
     44292 ± 19%     -72.7%      12088 ± 19%  sched_debug.cpu.sched_count.max
      3803 ± 11%     -61.2%       1476 ± 16%  sched_debug.cpu.sched_count.stddev
     41.56 ± 11%     +38.2%      57.42 ±  6%  sched_debug.cpu.sched_goidle.avg
      1686 ± 10%     -44.8%     931.12 ±  9%  sched_debug.cpu.ttwu_count.avg
     21371 ± 19%     -76.5%       5022 ± 17%  sched_debug.cpu.ttwu_count.max
      1814 ± 10%     -64.5%     643.57 ±  8%  sched_debug.cpu.ttwu_count.stddev
      1576 ± 11%     -49.3%     799.95 ± 13%  sched_debug.cpu.ttwu_local.avg
     21206 ± 19%     -79.8%       4293 ± 14%  sched_debug.cpu.ttwu_local.max
      1764 ± 11%     -69.4%     539.72 ±  6%  sched_debug.cpu.ttwu_local.stddev
    188334           +37.4%     258803 ± 21%  sched_debug.cpu_clk
    184280           +38.2%     254675 ± 21%  sched_debug.ktime
      0.01           -75.0%       0.00 ±173%  sched_debug.rt_rq:/.rt_nr_migratory.stddev
      0.01           -75.0%       0.00 ±173%  sched_debug.rt_rq:/.rt_nr_running.stddev
      0.48 ± 65%     -61.2%       0.19 ±152%  sched_debug.rt_rq:/.rt_time.avg
     91.72 ± 65%     -61.2%      35.56 ±152%  sched_debug.rt_rq:/.rt_time.max
      6.60 ± 65%     -61.2%       2.56 ±152%  sched_debug.rt_rq:/.rt_time.stddev
    194032           +36.3%     264511 ± 20%  sched_debug.sched_clk
     21.26 ± 79%     -21.3        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
     21.15 ± 79%     -21.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
     13.11 ±129%     -13.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.selinux_inode_free_security.security_inode_free.__destroy_inode
     13.10 ±129%     -13.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.inode_doinit_with_dentry.security_d_instantiate.d_instantiate
     12.07 ± 96%     -12.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
     12.01 ± 97%     -12.0        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_open.do_syscall_64
      0.76 ± 15%      +2.2        2.94 ± 80%  perf-profile.calltrace.cycles-pp.file_free_rcu.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd
      1.18 ± 16%      +4.0        5.20 ± 83%  perf-profile.calltrace.cycles-pp.rcu_do_batch.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn
      1.19 ± 16%      +4.0        5.21 ± 83%  perf-profile.calltrace.cycles-pp.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.19 ± 16%      +4.0        5.21 ± 83%  perf-profile.calltrace.cycles-pp.rcu_core.__softirqentry_text_start.run_ksoftirqd.smpboot_thread_fn.kthread
      1.19 ± 16%      +4.0        5.21 ± 83%  perf-profile.calltrace.cycles-pp.run_ksoftirqd.smpboot_thread_fn.kthread.ret_from_fork
      1.20 ± 16%      +4.0        5.23 ± 83%  perf-profile.calltrace.cycles-pp.ret_from_fork
      1.20 ± 16%      +4.0        5.23 ± 83%  perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
      1.19 ± 16%      +4.0        5.23 ± 83%  perf-profile.calltrace.cycles-pp.smpboot_thread_fn.kthread.ret_from_fork
      0.00            +6.9        6.88 ± 45%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.selinux_inode_free_security.security_inode_free.__destroy_inode
      0.00            +7.1        7.10 ± 45%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.inode_doinit_with_dentry.security_d_instantiate.d_instantiate
      0.00           +11.9       11.93 ± 24%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.evict.do_unlinkat.do_syscall_64
      0.00           +13.2       13.19 ± 25%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.inode_sb_list_add.new_inode.shmem_get_inode
      0.00           +23.7       23.68 ± 13%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__alloc_fd.do_sys_open.do_syscall_64
      0.00           +25.1       25.07 ± 14%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock.__close_fd.__x64_sys_close.do_syscall_64
     93.29           -93.3        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     94.16            -4.7       89.47 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock
     98.68            -4.1       94.60 ±  4%  perf-profile.children.cycles-pp.do_syscall_64
     98.69            -4.1       94.61 ±  4%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.21 ±  6%      -0.1        0.11 ±  8%  perf-profile.children.cycles-pp.__mnt_want_write
      0.23 ±  6%      -0.1        0.13 ±  6%  perf-profile.children.cycles-pp.mnt_want_write
      0.09            -0.0        0.04 ± 58%  perf-profile.children.cycles-pp.find_next_zero_bit
      0.11 ±  9%      -0.0        0.07 ± 17%  perf-profile.children.cycles-pp.__list_del_entry_valid
      0.15 ±  7%      -0.0        0.10 ±  8%  perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.13 ± 10%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.timestamp_truncate
      0.12 ±  8%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__list_add_valid
      0.11 ±  9%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.fsnotify
      0.09 ±  5%      -0.0        0.06 ±  9%  perf-profile.children.cycles-pp.__sb_start_write
      0.12 ±  5%      -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.shmem_unlink
      0.18 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.do_dentry_open
      0.14 ±  3%      +0.0        0.15        perf-profile.children.cycles-pp.d_alloc_parallel
      0.08 ±  5%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.filp_close
      0.07            +0.0        0.09 ±  5%  perf-profile.children.cycles-pp.simple_lookup
      0.07 ±  7%      +0.0        0.08        perf-profile.children.cycles-pp._cond_resched
      0.06            +0.0        0.08 ±  6%  perf-profile.children.cycles-pp.__d_alloc
      0.06 ±  7%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.security_inode_unlink
      0.07 ± 10%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.__fput
      0.05            +0.0        0.07 ±  6%  perf-profile.children.cycles-pp.may_link
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp._raw_spin_lock_irq
      0.07 ±  6%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.d_alloc
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__x64_sys_unlink
      0.06            +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.strncpy_from_user
      0.06 ± 11%      +0.0        0.09 ±  4%  perf-profile.children.cycles-pp.___might_sleep
      0.05            +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.lookup_fast
      0.29 ±  7%      +0.0        0.33 ±  2%  perf-profile.children.cycles-pp.new_inode_pseudo
      0.06            +0.0        0.10 ±  4%  perf-profile.children.cycles-pp.walk_component
      0.04 ± 58%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.security_inode_alloc
      0.10 ± 10%      +0.0        0.15 ±  2%  perf-profile.children.cycles-pp.task_work_run
      0.03 ±100%      +0.0        0.07        perf-profile.children.cycles-pp.__inode_security_revalidate
      0.21 ±  6%      +0.0        0.26 ±  3%  perf-profile.children.cycles-pp.alloc_inode
      0.09            +0.0        0.14 ±  3%  perf-profile.children.cycles-pp.getname_flags
      0.11 ±  9%      +0.1        0.16 ±  5%  perf-profile.children.cycles-pp.exit_to_usermode_loop
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__dentry_kill
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__might_sleep
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.__check_object_size
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.complete_walk
      0.06 ± 11%      +0.1        0.11 ±  3%  perf-profile.children.cycles-pp.shmem_alloc_inode
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.avc_has_perm_noaudit
      0.00            +0.1        0.05 ±  9%  perf-profile.children.cycles-pp.new_slab
      0.00            +0.1        0.06 ±  9%  perf-profile.children.cycles-pp.shmem_undo_range
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.d_add
      0.10            +0.1        0.17 ±  5%  perf-profile.children.cycles-pp.dput
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.__slab_alloc
      0.00            +0.1        0.07 ±  7%  perf-profile.children.cycles-pp.___slab_alloc
      0.34 ±  2%      +0.1        0.43 ± 20%  perf-profile.children.cycles-pp.vfs_unlink
      0.15 ±  7%      +0.1        0.26 ±  3%  perf-profile.children.cycles-pp.kmem_cache_alloc
      0.15 ±  8%      +0.1        0.27 ± 19%  perf-profile.children.cycles-pp.selinux_inode_permission
      0.15 ±  9%      +0.1        0.28 ± 18%  perf-profile.children.cycles-pp.security_inode_permission
      0.23            +0.1        0.38 ± 36%  perf-profile.children.cycles-pp.__alloc_file
      0.27            +0.2        0.42 ± 32%  perf-profile.children.cycles-pp.alloc_empty_file
      0.00            +0.3        0.25        perf-profile.children.cycles-pp.cna_scan_main_queue
      0.04 ± 58%      +0.3        0.30 ± 79%  perf-profile.children.cycles-pp.rcu_cblist_dequeue
      0.26 ±  6%      +0.3        0.56 ± 46%  perf-profile.children.cycles-pp.path_parentat
      0.27 ±  6%      +0.3        0.58 ± 44%  perf-profile.children.cycles-pp.filename_parentat
      0.42 ±  8%      +0.4        0.80 ± 20%  perf-profile.children.cycles-pp.irq_exit
      1.04 ± 15%      +0.4        1.46 ± 14%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      1.08 ± 16%      +0.4        1.53 ± 11%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.48 ±  5%      +0.5        1.02 ± 51%  perf-profile.children.cycles-pp.link_path_walk
      0.45 ± 14%      +1.3        1.77 ± 67%  perf-profile.children.cycles-pp.__slab_free
      0.49 ± 13%      +1.7        2.15 ± 72%  perf-profile.children.cycles-pp.kmem_cache_free
      1.02 ± 11%      +2.4        3.43 ± 67%  perf-profile.children.cycles-pp.file_free_rcu
      1.19 ± 16%      +4.0        5.21 ± 83%  perf-profile.children.cycles-pp.run_ksoftirqd
      1.20 ± 16%      +4.0        5.23 ± 83%  perf-profile.children.cycles-pp.ret_from_fork
      1.20 ± 16%      +4.0        5.23 ± 83%  perf-profile.children.cycles-pp.kthread
      1.19 ± 16%      +4.0        5.23 ± 83%  perf-profile.children.cycles-pp.smpboot_thread_fn
      1.58 ± 12%      +4.4        5.98 ± 69%  perf-profile.children.cycles-pp.rcu_do_batch
      1.58 ± 12%      +4.4        5.99 ± 69%  perf-profile.children.cycles-pp.rcu_core
      1.60 ± 12%      +4.4        6.01 ± 69%  perf-profile.children.cycles-pp.__softirqentry_text_start
      0.00           +88.7       88.72 ±  5%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     92.36           -92.4        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.85 ±  2%      -0.1        0.74        perf-profile.self.cycles-pp._raw_spin_lock
      0.21 ±  6%      -0.1        0.11 ±  8%  perf-profile.self.cycles-pp.__mnt_want_write
      0.11 ±  9%      -0.1        0.06 ± 20%  perf-profile.self.cycles-pp.__list_del_entry_valid
      0.08 ±  5%      -0.1        0.03 ±100%  perf-profile.self.cycles-pp.__sb_start_write
      0.09 ±  4%      -0.1        0.04 ± 57%  perf-profile.self.cycles-pp.find_next_zero_bit
      0.11 ±  6%      -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.__destroy_inode
      0.15 ±  7%      -0.0        0.10 ±  8%  perf-profile.self.cycles-pp.rcu_segcblist_enqueue
      0.12 ±  8%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__list_add_valid
      0.08 ± 10%      -0.0        0.04 ± 57%  perf-profile.self.cycles-pp.inode_init_always
      0.13 ±  8%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.timestamp_truncate
      0.11 ±  6%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.fsnotify
      0.10 ± 11%      -0.0        0.06        perf-profile.self.cycles-pp.shmem_get_inode
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.__alloc_fd
      0.06 ± 11%      +0.0        0.08 ±  5%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.05 ±  8%      +0.0        0.08        perf-profile.self.cycles-pp.kmem_cache_alloc
      0.06 ±  7%      +0.0        0.09        perf-profile.self.cycles-pp.___might_sleep
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.avc_has_perm_noaudit
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.link_path_walk
      0.09 ± 13%      +0.1        0.18 ± 32%  perf-profile.self.cycles-pp.selinux_inode_permission
      0.00            +0.1        0.09 ± 49%  perf-profile.self.cycles-pp.kmem_cache_free
      0.17 ±  2%      +0.1        0.29 ± 45%  perf-profile.self.cycles-pp.__alloc_file
      0.00            +0.2        0.25 ±  3%  perf-profile.self.cycles-pp.cna_scan_main_queue
      0.04 ± 58%      +0.3        0.30 ± 78%  perf-profile.self.cycles-pp.rcu_cblist_dequeue
      0.45 ± 14%      +1.3        1.76 ± 67%  perf-profile.self.cycles-pp.__slab_free
      1.01 ± 11%      +2.4        3.41 ± 67%  perf-profile.self.cycles-pp.file_free_rcu
      0.00           +87.1       87.10 ±  5%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
    601350           +51.9%     913379 ± 25%  interrupts.CPU0.LOC:Local_timer_interrupts
    601046           +51.9%     912961 ± 25%  interrupts.CPU1.LOC:Local_timer_interrupts
    601112           +51.9%     913326 ± 25%  interrupts.CPU10.LOC:Local_timer_interrupts
    601067           +51.9%     913245 ± 25%  interrupts.CPU100.LOC:Local_timer_interrupts
      4605 ± 51%     -39.6%       2781 ±  8%  interrupts.CPU100.TLB:TLB_shootdowns
    601039           +52.0%     913375 ± 25%  interrupts.CPU101.LOC:Local_timer_interrupts
    601054           +52.0%     913416 ± 25%  interrupts.CPU102.LOC:Local_timer_interrupts
    601120           +51.9%     913315 ± 25%  interrupts.CPU103.LOC:Local_timer_interrupts
    601152           +51.9%     912929 ± 25%  interrupts.CPU104.LOC:Local_timer_interrupts
    601148           +51.8%     912772 ± 25%  interrupts.CPU105.LOC:Local_timer_interrupts
    601007           +51.9%     913225 ± 25%  interrupts.CPU106.LOC:Local_timer_interrupts
    601060           +51.9%     912870 ± 25%  interrupts.CPU107.LOC:Local_timer_interrupts
    601161           +51.9%     913355 ± 25%  interrupts.CPU108.LOC:Local_timer_interrupts
      8732           -34.2%       5744 ± 31%  interrupts.CPU108.NMI:Non-maskable_interrupts
      8732           -34.2%       5744 ± 31%  interrupts.CPU108.PMI:Performance_monitoring_interrupts
    601098           +51.9%     913229 ± 25%  interrupts.CPU109.LOC:Local_timer_interrupts
    601304           +51.7%     912281 ± 25%  interrupts.CPU11.LOC:Local_timer_interrupts
    601084           +52.0%     913404 ± 25%  interrupts.CPU110.LOC:Local_timer_interrupts
    600974           +52.0%     913378 ± 25%  interrupts.CPU111.LOC:Local_timer_interrupts
    601046           +52.0%     913375 ± 25%  interrupts.CPU112.LOC:Local_timer_interrupts
      4626 ± 51%     -38.3%       2856 ± 12%  interrupts.CPU112.TLB:TLB_shootdowns
    601016           +51.9%     913141 ± 25%  interrupts.CPU113.LOC:Local_timer_interrupts
    601236           +51.8%     912742 ± 25%  interrupts.CPU114.LOC:Local_timer_interrupts
    601069           +51.9%     913086 ± 25%  interrupts.CPU115.LOC:Local_timer_interrupts
    564.75 ± 89%     -83.2%      95.00 ± 26%  interrupts.CPU115.RES:Rescheduling_interrupts
    601005           +52.0%     913296 ± 25%  interrupts.CPU116.LOC:Local_timer_interrupts
    601058           +52.0%     913376 ± 25%  interrupts.CPU117.LOC:Local_timer_interrupts
     29.50 ± 88%    +313.6%     122.00 ± 23%  interrupts.CPU117.RES:Rescheduling_interrupts
    601164           +52.0%     913473 ± 25%  interrupts.CPU118.LOC:Local_timer_interrupts
    601075           +51.9%     912767 ± 25%  interrupts.CPU119.LOC:Local_timer_interrupts
    601164           +51.9%     913118 ± 25%  interrupts.CPU12.LOC:Local_timer_interrupts
    601055           +52.0%     913667 ± 25%  interrupts.CPU120.LOC:Local_timer_interrupts
     15.00 ± 39%   +1790.0%     283.50 ±147%  interrupts.CPU120.RES:Rescheduling_interrupts
    600986           +52.0%     913637 ± 25%  interrupts.CPU121.LOC:Local_timer_interrupts
    601024           +52.0%     913721 ± 25%  interrupts.CPU122.LOC:Local_timer_interrupts
    601020           +52.1%     913938 ± 25%  interrupts.CPU123.LOC:Local_timer_interrupts
    601038           +52.0%     913631 ± 25%  interrupts.CPU124.LOC:Local_timer_interrupts
    601369           +51.9%     913634 ± 25%  interrupts.CPU125.LOC:Local_timer_interrupts
    601037           +52.0%     913683 ± 25%  interrupts.CPU126.LOC:Local_timer_interrupts
    600989           +52.0%     913758 ± 25%  interrupts.CPU127.LOC:Local_timer_interrupts
    601026           +52.1%     914097 ± 25%  interrupts.CPU128.LOC:Local_timer_interrupts
    600962           +52.1%     914048 ± 25%  interrupts.CPU129.LOC:Local_timer_interrupts
    601086           +52.0%     913424 ± 25%  interrupts.CPU13.LOC:Local_timer_interrupts
    601004           +52.0%     913680 ± 25%  interrupts.CPU130.LOC:Local_timer_interrupts
    601032           +52.0%     913593 ± 25%  interrupts.CPU131.LOC:Local_timer_interrupts
      4615 ± 51%     -39.7%       2781 ± 10%  interrupts.CPU131.TLB:TLB_shootdowns
    600999           +52.1%     914053 ± 25%  interrupts.CPU132.LOC:Local_timer_interrupts
    601044           +52.0%     913749 ± 25%  interrupts.CPU133.LOC:Local_timer_interrupts
    601011           +52.0%     913631 ± 25%  interrupts.CPU134.LOC:Local_timer_interrupts
    600989           +52.0%     913768 ± 25%  interrupts.CPU135.LOC:Local_timer_interrupts
    601026           +52.0%     913740 ± 25%  interrupts.CPU136.LOC:Local_timer_interrupts
    600996           +52.0%     913692 ± 25%  interrupts.CPU137.LOC:Local_timer_interrupts
    600992           +52.0%     913679 ± 25%  interrupts.CPU138.LOC:Local_timer_interrupts
    601018           +52.0%     913776 ± 25%  interrupts.CPU139.LOC:Local_timer_interrupts
    601206           +52.0%     913664 ± 25%  interrupts.CPU14.LOC:Local_timer_interrupts
    600992           +52.0%     913790 ± 25%  interrupts.CPU140.LOC:Local_timer_interrupts
     29.00 ± 84%    +477.6%     167.50 ± 48%  interrupts.CPU140.RES:Rescheduling_interrupts
    601029           +52.0%     913814 ± 25%  interrupts.CPU141.LOC:Local_timer_interrupts
     20.25 ± 75%   +2679.0%     562.75 ±113%  interrupts.CPU141.RES:Rescheduling_interrupts
    601282           +52.0%     913765 ± 25%  interrupts.CPU142.LOC:Local_timer_interrupts
    601114           +52.0%     913792 ± 25%  interrupts.CPU143.LOC:Local_timer_interrupts
    601195           +52.0%     913989 ± 25%  interrupts.CPU144.LOC:Local_timer_interrupts
    601281           +52.0%     913771 ± 25%  interrupts.CPU145.LOC:Local_timer_interrupts
      9097 ± 24%     -28.9%       6464 ±  8%  interrupts.CPU146.CAL:Function_call_interrupts
    601129           +52.0%     913890 ± 25%  interrupts.CPU146.LOC:Local_timer_interrupts
     31.00 ± 87%    +622.6%     224.00 ±114%  interrupts.CPU146.RES:Rescheduling_interrupts
    601167           +52.0%     913914 ± 25%  interrupts.CPU147.LOC:Local_timer_interrupts
      4628 ± 51%     -39.6%       2796 ± 11%  interrupts.CPU147.TLB:TLB_shootdowns
    601151           +52.0%     913771 ± 25%  interrupts.CPU148.LOC:Local_timer_interrupts
    601203           +52.0%     913794 ± 25%  interrupts.CPU149.LOC:Local_timer_interrupts
    601401           +51.8%     913148 ± 25%  interrupts.CPU15.LOC:Local_timer_interrupts
    601207           +52.0%     913821 ± 25%  interrupts.CPU150.LOC:Local_timer_interrupts
    601208           +52.0%     913875 ± 25%  interrupts.CPU151.LOC:Local_timer_interrupts
    601204           +52.0%     913845 ± 25%  interrupts.CPU152.LOC:Local_timer_interrupts
     33.50 ± 67%    +260.4%     120.75 ± 84%  interrupts.CPU152.RES:Rescheduling_interrupts
    601163           +52.0%     913963 ± 25%  interrupts.CPU153.LOC:Local_timer_interrupts
    601140           +52.0%     913912 ± 25%  interrupts.CPU154.LOC:Local_timer_interrupts
    601194           +52.0%     913724 ± 25%  interrupts.CPU155.LOC:Local_timer_interrupts
     34.50 ±129%    +156.5%      88.50 ± 56%  interrupts.CPU155.RES:Rescheduling_interrupts
    601121           +52.0%     913853 ± 25%  interrupts.CPU156.LOC:Local_timer_interrupts
    601185           +52.0%     913935 ± 25%  interrupts.CPU157.LOC:Local_timer_interrupts
    601139           +52.0%     913967 ± 25%  interrupts.CPU158.LOC:Local_timer_interrupts
    601244           +52.0%     914006 ± 25%  interrupts.CPU159.LOC:Local_timer_interrupts
    601125           +51.9%     913407 ± 25%  interrupts.CPU16.LOC:Local_timer_interrupts
    601191           +52.0%     913831 ± 25%  interrupts.CPU160.LOC:Local_timer_interrupts
    601214           +52.0%     913956 ± 25%  interrupts.CPU161.LOC:Local_timer_interrupts
     20.75 ± 76%    +362.7%      96.00 ± 24%  interrupts.CPU161.RES:Rescheduling_interrupts
    601122           +52.0%     913994 ± 25%  interrupts.CPU162.LOC:Local_timer_interrupts
      9094 ± 24%     -25.3%       6794 ±  9%  interrupts.CPU163.CAL:Function_call_interrupts
    601137           +52.0%     913829 ± 25%  interrupts.CPU163.LOC:Local_timer_interrupts
    601098           +52.0%     913964 ± 25%  interrupts.CPU164.LOC:Local_timer_interrupts
    601259           +52.0%     914011 ± 25%  interrupts.CPU165.LOC:Local_timer_interrupts
    601195           +52.0%     913979 ± 25%  interrupts.CPU166.LOC:Local_timer_interrupts
    601329           +52.0%     913863 ± 25%  interrupts.CPU167.LOC:Local_timer_interrupts
    601108           +52.0%     913806 ± 25%  interrupts.CPU168.LOC:Local_timer_interrupts
    601425           +52.0%     914272 ± 25%  interrupts.CPU169.LOC:Local_timer_interrupts
    601093           +51.9%     912884 ± 25%  interrupts.CPU17.LOC:Local_timer_interrupts
      4624 ± 51%     -39.1%       2814 ± 12%  interrupts.CPU17.TLB:TLB_shootdowns
    601035           +52.1%     914277 ± 25%  interrupts.CPU170.LOC:Local_timer_interrupts
    601090           +52.0%     913882 ± 25%  interrupts.CPU171.LOC:Local_timer_interrupts
    133.50 ± 83%     -80.7%      25.75 ± 38%  interrupts.CPU171.RES:Rescheduling_interrupts
    601167           +52.0%     913519 ± 25%  interrupts.CPU172.LOC:Local_timer_interrupts
    601099           +52.1%     914287 ± 25%  interrupts.CPU173.LOC:Local_timer_interrupts
    601095           +52.1%     914245 ± 25%  interrupts.CPU174.LOC:Local_timer_interrupts
    601219           +52.0%     913858 ± 25%  interrupts.CPU175.LOC:Local_timer_interrupts
    601150           +51.9%     913437 ± 25%  interrupts.CPU176.LOC:Local_timer_interrupts
    601155           +52.0%     913519 ± 25%  interrupts.CPU177.LOC:Local_timer_interrupts
    601007           +52.1%     913976 ± 25%  interrupts.CPU178.LOC:Local_timer_interrupts
    601105           +52.1%     914223 ± 25%  interrupts.CPU179.LOC:Local_timer_interrupts
    601362           +51.8%     913144 ± 25%  interrupts.CPU18.LOC:Local_timer_interrupts
    601137           +52.0%     913924 ± 25%  interrupts.CPU180.LOC:Local_timer_interrupts
    601197           +52.0%     913568 ± 25%  interrupts.CPU181.LOC:Local_timer_interrupts
    601149           +52.0%     913945 ± 25%  interrupts.CPU182.LOC:Local_timer_interrupts
    601086           +52.1%     914292 ± 25%  interrupts.CPU183.LOC:Local_timer_interrupts
    601067           +52.0%     913700 ± 25%  interrupts.CPU184.LOC:Local_timer_interrupts
    601170           +52.1%     914231 ± 25%  interrupts.CPU185.LOC:Local_timer_interrupts
    601139           +52.0%     913746 ± 25%  interrupts.CPU186.LOC:Local_timer_interrupts
    601117           +52.1%     914143 ± 25%  interrupts.CPU187.LOC:Local_timer_interrupts
    601082           +52.1%     914222 ± 25%  interrupts.CPU188.LOC:Local_timer_interrupts
    601096           +52.1%     914054 ± 25%  interrupts.CPU189.LOC:Local_timer_interrupts
    601318           +51.8%     913095 ± 25%  interrupts.CPU19.LOC:Local_timer_interrupts
    601492           +52.0%     914260 ± 25%  interrupts.CPU190.LOC:Local_timer_interrupts
    601127           +52.1%     914531 ± 25%  interrupts.CPU191.LOC:Local_timer_interrupts
    601108           +52.0%     913480 ± 25%  interrupts.CPU2.LOC:Local_timer_interrupts
    601443           +51.8%     913085 ± 25%  interrupts.CPU20.LOC:Local_timer_interrupts
    601076           +52.0%     913401 ± 25%  interrupts.CPU21.LOC:Local_timer_interrupts
    601110           +52.0%     913461 ± 25%  interrupts.CPU22.LOC:Local_timer_interrupts
    601241           +51.9%     913251 ± 25%  interrupts.CPU23.LOC:Local_timer_interrupts
      4610 ± 51%     -39.1%       2808 ± 12%  interrupts.CPU23.TLB:TLB_shootdowns
    601272           +52.0%     913706 ± 25%  interrupts.CPU24.LOC:Local_timer_interrupts
     50.75 ± 63%    +288.2%     197.00 ± 31%  interrupts.CPU24.RES:Rescheduling_interrupts
    601079           +52.1%     913946 ± 25%  interrupts.CPU25.LOC:Local_timer_interrupts
    601142           +52.0%     913796 ± 25%  interrupts.CPU26.LOC:Local_timer_interrupts
     26.00 ± 51%   +1607.7%     444.00 ±135%  interrupts.CPU26.RES:Rescheduling_interrupts
    600999           +52.0%     913404 ± 25%  interrupts.CPU27.LOC:Local_timer_interrupts
    601058           +52.0%     913471 ± 25%  interrupts.CPU28.LOC:Local_timer_interrupts
    601053           +52.0%     913762 ± 25%  interrupts.CPU29.LOC:Local_timer_interrupts
    601387           +51.8%     912824 ± 25%  interrupts.CPU3.LOC:Local_timer_interrupts
      4597 ± 50%     -39.1%       2798 ± 11%  interrupts.CPU3.TLB:TLB_shootdowns
    600976           +52.0%     913724 ± 25%  interrupts.CPU30.LOC:Local_timer_interrupts
    601024           +52.0%     913694 ± 25%  interrupts.CPU31.LOC:Local_timer_interrupts
     37.75 ± 41%    +133.1%      88.00 ± 10%  interrupts.CPU31.RES:Rescheduling_interrupts
      4621 ± 51%     -37.0%       2914 ±  6%  interrupts.CPU31.TLB:TLB_shootdowns
    601004           +52.0%     913535 ± 25%  interrupts.CPU32.LOC:Local_timer_interrupts
     21.00 ± 43%    +509.5%     128.00 ± 55%  interrupts.CPU32.RES:Rescheduling_interrupts
    601094           +52.1%     914138 ± 25%  interrupts.CPU33.LOC:Local_timer_interrupts
    601008           +52.0%     913660 ± 25%  interrupts.CPU34.LOC:Local_timer_interrupts
    600990           +52.0%     913589 ± 25%  interrupts.CPU35.LOC:Local_timer_interrupts
    601092           +52.0%     913630 ± 25%  interrupts.CPU36.LOC:Local_timer_interrupts
    601060           +52.1%     913980 ± 25%  interrupts.CPU37.LOC:Local_timer_interrupts
    202.75 ± 91%     -89.4%      21.50 ± 64%  interrupts.CPU37.RES:Rescheduling_interrupts
    600979           +52.0%     913533 ± 25%  interrupts.CPU38.LOC:Local_timer_interrupts
    601168           +52.0%     913785 ± 25%  interrupts.CPU39.LOC:Local_timer_interrupts
    601133           +52.0%     913467 ± 25%  interrupts.CPU4.LOC:Local_timer_interrupts
    601010           +52.0%     913759 ± 25%  interrupts.CPU40.LOC:Local_timer_interrupts
    600994           +52.0%     913705 ± 25%  interrupts.CPU41.LOC:Local_timer_interrupts
    600977           +52.0%     913671 ± 25%  interrupts.CPU42.LOC:Local_timer_interrupts
    601004           +52.0%     913651 ± 25%  interrupts.CPU43.LOC:Local_timer_interrupts
     27.75 ± 53%    +249.5%      97.00 ± 42%  interrupts.CPU43.RES:Rescheduling_interrupts
    601038           +52.0%     913832 ± 25%  interrupts.CPU44.LOC:Local_timer_interrupts
    601037           +52.0%     913845 ± 25%  interrupts.CPU45.LOC:Local_timer_interrupts
     26.50 ± 61%    +206.6%      81.25 ± 20%  interrupts.CPU45.RES:Rescheduling_interrupts
    601080           +52.1%     913949 ± 25%  interrupts.CPU46.LOC:Local_timer_interrupts
    601011           +52.0%     913742 ± 25%  interrupts.CPU47.LOC:Local_timer_interrupts
    601561           +51.9%     913909 ± 25%  interrupts.CPU48.LOC:Local_timer_interrupts
    601199           +52.0%     913959 ± 25%  interrupts.CPU49.LOC:Local_timer_interrupts
    601239           +52.0%     913644 ± 25%  interrupts.CPU5.LOC:Local_timer_interrupts
      4617 ± 51%     -36.5%       2930 ± 10%  interrupts.CPU5.TLB:TLB_shootdowns
      9146 ± 24%     -29.8%       6419 ± 13%  interrupts.CPU50.CAL:Function_call_interrupts
    601393           +52.0%     913863 ± 25%  interrupts.CPU50.LOC:Local_timer_interrupts
     25.25 ±107%    +470.3%     144.00 ± 19%  interrupts.CPU50.RES:Rescheduling_interrupts
    601182           +52.0%     913815 ± 25%  interrupts.CPU51.LOC:Local_timer_interrupts
    601198           +52.1%     914215 ± 25%  interrupts.CPU52.LOC:Local_timer_interrupts
    601138           +52.0%     913865 ± 25%  interrupts.CPU53.LOC:Local_timer_interrupts
    601169           +52.0%     913772 ± 25%  interrupts.CPU54.LOC:Local_timer_interrupts
    601293           +52.0%     913829 ± 25%  interrupts.CPU55.LOC:Local_timer_interrupts
    601214           +52.0%     913895 ± 25%  interrupts.CPU56.LOC:Local_timer_interrupts
     41.50 ±122%    +912.0%     420.00 ±117%  interrupts.CPU56.RES:Rescheduling_interrupts
    601207           +52.0%     913831 ± 25%  interrupts.CPU57.LOC:Local_timer_interrupts
    601191           +52.0%     913698 ± 25%  interrupts.CPU58.LOC:Local_timer_interrupts
    601450           +51.9%     913892 ± 25%  interrupts.CPU59.LOC:Local_timer_interrupts
    601003           +52.0%     913473 ± 25%  interrupts.CPU6.LOC:Local_timer_interrupts
    601131           +52.0%     913906 ± 25%  interrupts.CPU60.LOC:Local_timer_interrupts
    601136           +52.0%     913934 ± 25%  interrupts.CPU61.LOC:Local_timer_interrupts
    601116           +52.0%     913825 ± 25%  interrupts.CPU62.LOC:Local_timer_interrupts
    601181           +52.0%     913875 ± 25%  interrupts.CPU63.LOC:Local_timer_interrupts
    601530           +51.9%     913886 ± 25%  interrupts.CPU64.LOC:Local_timer_interrupts
    601120           +52.0%     913903 ± 25%  interrupts.CPU65.LOC:Local_timer_interrupts
    601302           +52.0%     913820 ± 25%  interrupts.CPU66.LOC:Local_timer_interrupts
      8997 ± 20%     -25.4%       6714 ±  9%  interrupts.CPU67.CAL:Function_call_interrupts
    601210           +52.0%     913603 ± 25%  interrupts.CPU67.LOC:Local_timer_interrupts
    601253           +52.0%     913801 ± 25%  interrupts.CPU68.LOC:Local_timer_interrupts
    601093           +52.0%     913801 ± 25%  interrupts.CPU69.LOC:Local_timer_interrupts
    601047           +51.9%     913053 ± 25%  interrupts.CPU7.LOC:Local_timer_interrupts
    601172           +52.0%     913851 ± 25%  interrupts.CPU70.LOC:Local_timer_interrupts
    601192           +52.0%     913921 ± 25%  interrupts.CPU71.LOC:Local_timer_interrupts
    601048           +52.1%     913935 ± 25%  interrupts.CPU72.LOC:Local_timer_interrupts
    600964           +52.1%     914102 ± 25%  interrupts.CPU73.LOC:Local_timer_interrupts
    601086           +52.1%     914248 ± 25%  interrupts.CPU74.LOC:Local_timer_interrupts
    601072           +52.0%     913613 ± 25%  interrupts.CPU75.LOC:Local_timer_interrupts
    601058           +52.0%     913695 ± 25%  interrupts.CPU76.LOC:Local_timer_interrupts
    601111           +52.1%     914191 ± 25%  interrupts.CPU77.LOC:Local_timer_interrupts
    510.00 ± 96%     -86.9%      67.00 ± 92%  interrupts.CPU77.RES:Rescheduling_interrupts
    601214           +52.1%     914462 ± 25%  interrupts.CPU78.LOC:Local_timer_interrupts
    601228           +52.0%     913901 ± 25%  interrupts.CPU79.LOC:Local_timer_interrupts
    601102           +51.9%     912996 ± 25%  interrupts.CPU8.LOC:Local_timer_interrupts
    601218           +52.1%     914283 ± 25%  interrupts.CPU80.LOC:Local_timer_interrupts
    601186           +52.1%     914164 ± 25%  interrupts.CPU81.LOC:Local_timer_interrupts
    601076           +52.1%     914212 ± 25%  interrupts.CPU82.LOC:Local_timer_interrupts
    601085           +52.1%     914160 ± 25%  interrupts.CPU83.LOC:Local_timer_interrupts
    601094           +52.1%     914232 ± 25%  interrupts.CPU84.LOC:Local_timer_interrupts
    292.75 ± 47%     -66.1%      99.25 ± 86%  interrupts.CPU84.RES:Rescheduling_interrupts
    601098           +52.1%     914257 ± 25%  interrupts.CPU85.LOC:Local_timer_interrupts
    601142           +52.1%     914230 ± 25%  interrupts.CPU86.LOC:Local_timer_interrupts
    601045           +52.0%     913633 ± 25%  interrupts.CPU87.LOC:Local_timer_interrupts
    601171           +52.0%     913748 ± 25%  interrupts.CPU88.LOC:Local_timer_interrupts
    601279           +52.1%     914340 ± 25%  interrupts.CPU89.LOC:Local_timer_interrupts
    220.00 ± 53%     -71.6%      62.50 ± 56%  interrupts.CPU89.RES:Rescheduling_interrupts
    601269           +51.8%     912796 ± 25%  interrupts.CPU9.LOC:Local_timer_interrupts
    601182           +52.0%     913729 ± 25%  interrupts.CPU90.LOC:Local_timer_interrupts
    183.00 ± 92%     -80.6%      35.50 ± 47%  interrupts.CPU90.RES:Rescheduling_interrupts
    601249           +52.1%     914243 ± 25%  interrupts.CPU91.LOC:Local_timer_interrupts
    242.00 ±104%     -84.1%      38.50 ± 49%  interrupts.CPU91.RES:Rescheduling_interrupts
    601136           +52.1%     914181 ± 25%  interrupts.CPU92.LOC:Local_timer_interrupts
    601115           +52.1%     914271 ± 25%  interrupts.CPU93.LOC:Local_timer_interrupts
    601059           +52.1%     914225 ± 25%  interrupts.CPU94.LOC:Local_timer_interrupts
    601350           +52.0%     914261 ± 25%  interrupts.CPU95.LOC:Local_timer_interrupts
    600993           +51.9%     912787 ± 25%  interrupts.CPU96.LOC:Local_timer_interrupts
    601098           +51.8%     912683 ± 25%  interrupts.CPU97.LOC:Local_timer_interrupts
    601136           +51.9%     913362 ± 25%  interrupts.CPU98.LOC:Local_timer_interrupts
    601131           +51.9%     913375 ± 25%  interrupts.CPU99.LOC:Local_timer_interrupts
 1.154e+08           +52.0%  1.754e+08 ± 25%  interrupts.LOC:Local_timer_interrupts
     52752 ± 44%     -56.3%      23030 ± 15%  softirqs.CPU1.RCU
     74179 ± 49%     -68.4%      23430 ±  9%  softirqs.CPU10.RCU
     51891 ± 44%     -56.2%      22751 ±  9%  softirqs.CPU100.RCU
     52951 ± 42%     -57.1%      22704 ±  7%  softirqs.CPU101.RCU
     55961 ± 54%     -59.1%      22870 ±  7%  softirqs.CPU102.RCU
     67355 ± 45%     -67.0%      22246 ± 10%  softirqs.CPU103.RCU
     52253 ± 44%     -56.7%      22642 ± 13%  softirqs.CPU104.RCU
     52250 ± 45%     -55.4%      23307 ±  9%  softirqs.CPU105.RCU
     53056 ± 44%     -56.7%      22960 ±  9%  softirqs.CPU106.RCU
     51921 ± 45%     -56.7%      22468 ± 15%  softirqs.CPU107.RCU
     53400 ± 42%     -58.9%      21923 ± 12%  softirqs.CPU108.RCU
    113674 ±  5%     +35.5%     154034 ± 19%  softirqs.CPU108.TIMER
     52082 ± 45%     -57.2%      22290 ± 10%  softirqs.CPU109.RCU
     52205 ± 43%     -55.2%      23373 ± 10%  softirqs.CPU11.RCU
     67064 ± 44%     -67.2%      21996 ±  9%  softirqs.CPU110.RCU
     51559 ± 46%     -57.2%      22064 ±  8%  softirqs.CPU111.RCU
     52545 ± 44%     -56.7%      22756 ±  9%  softirqs.CPU112.RCU
     52137 ± 44%     -56.2%      22850 ±  8%  softirqs.CPU113.RCU
     52168 ± 44%     -57.2%      22316 ±  8%  softirqs.CPU114.RCU
     51984 ± 46%     -56.3%      22720 ± 10%  softirqs.CPU116.RCU
     52576 ± 44%     -58.2%      21961 ± 10%  softirqs.CPU117.RCU
     52386 ± 44%     -58.5%      21755 ±  7%  softirqs.CPU118.RCU
     52220 ± 44%     -58.4%      21729 ± 13%  softirqs.CPU119.RCU
     52805 ± 43%     -56.0%      23221 ± 14%  softirqs.CPU12.RCU
    114814 ±  5%     +41.1%     162027 ± 15%  softirqs.CPU12.TIMER
     53207 ± 44%     -61.5%      20481 ±  6%  softirqs.CPU121.RCU
     99208 ±  7%     +51.0%     149847 ± 25%  softirqs.CPU121.TIMER
     52962 ± 44%     -62.9%      19643 ±  7%  softirqs.CPU122.RCU
     98757 ±  7%     +51.5%     149665 ± 25%  softirqs.CPU122.TIMER
     52865 ± 44%     -61.4%      20416 ±  3%  softirqs.CPU123.RCU
     98423 ±  7%     +53.7%     151284 ± 25%  softirqs.CPU123.TIMER
     53274 ± 45%     -63.9%      19225 ±  6%  softirqs.CPU124.RCU
     99126 ±  6%     +52.6%     151229 ± 25%  softirqs.CPU124.TIMER
     63855 ± 41%     -68.5%      20133 ±  3%  softirqs.CPU125.RCU
     98827 ±  6%     +52.7%     150882 ± 25%  softirqs.CPU125.TIMER
     52741 ± 45%     -60.9%      20613 ±  5%  softirqs.CPU126.RCU
     99240 ±  6%     +52.3%     151157 ± 24%  softirqs.CPU126.TIMER
     53003 ± 44%     -62.6%      19848 ±  4%  softirqs.CPU127.RCU
     98688 ±  6%     +51.0%     149019 ± 24%  softirqs.CPU127.TIMER
     52505 ± 45%     -62.2%      19856 ±  6%  softirqs.CPU128.RCU
     98227 ±  6%     +52.0%     149342 ± 25%  softirqs.CPU128.TIMER
     52229 ± 44%     -62.1%      19782 ±  4%  softirqs.CPU129.RCU
     97901 ±  6%     +51.9%     148689 ± 24%  softirqs.CPU129.TIMER
     52428 ± 45%     -56.0%      23050 ± 14%  softirqs.CPU13.RCU
     52343 ± 44%     -61.2%      20301 ±  3%  softirqs.CPU130.RCU
     98951 ±  6%     +53.0%     151435 ± 25%  softirqs.CPU130.TIMER
     52646 ± 44%     -61.3%      20375 ±  4%  softirqs.CPU131.RCU
     98560 ±  6%     +53.4%     151209 ± 25%  softirqs.CPU131.TIMER
     52409 ± 44%     -62.4%      19731 ±  7%  softirqs.CPU132.RCU
     98614 ±  6%     +73.8%     171423 ± 37%  softirqs.CPU132.TIMER
     52752 ± 44%     -61.2%      20471 ±  6%  softirqs.CPU133.RCU
     52275 ± 44%     -63.6%      19031 ±  5%  softirqs.CPU134.RCU
     98069 ±  6%     +51.5%     148560 ± 24%  softirqs.CPU134.TIMER
     52396 ± 44%     -62.1%      19860 ±  5%  softirqs.CPU135.RCU
     98126 ±  6%     +51.9%     149005 ± 24%  softirqs.CPU135.TIMER
     52698 ± 44%     -62.4%      19829 ±  4%  softirqs.CPU136.RCU
     98621 ±  6%     +53.0%     150888 ± 25%  softirqs.CPU136.TIMER
     52418 ± 45%     -63.0%      19415 ±  5%  softirqs.CPU137.RCU
     98965 ±  6%     +52.5%     150937 ± 25%  softirqs.CPU137.TIMER
     52420 ± 44%     -63.2%      19316 ±  4%  softirqs.CPU138.RCU
     98616 ±  6%     +52.9%     150751 ± 25%  softirqs.CPU138.TIMER
     52579 ± 44%     -62.5%      19701 ±  5%  softirqs.CPU139.RCU
     97893 ±  7%     +52.2%     148945 ± 24%  softirqs.CPU139.TIMER
     51429 ± 45%     -55.4%      22961 ± 10%  softirqs.CPU14.RCU
     52334 ± 44%     -62.1%      19856 ±  3%  softirqs.CPU140.RCU
     52224 ± 44%     -60.3%      20714        softirqs.CPU141.RCU
     98396 ±  6%     +53.6%     151175 ± 24%  softirqs.CPU141.TIMER
     51988 ± 43%     -62.6%      19469 ±  6%  softirqs.CPU142.RCU
     98787 ±  6%     +51.3%     149501 ± 25%  softirqs.CPU142.TIMER
     52276 ± 44%     -58.4%      21756 ±  2%  softirqs.CPU143.RCU
     98571 ±  6%     +51.9%     149701 ± 24%  softirqs.CPU143.TIMER
     52198 ± 43%     -61.4%      20138 ±  9%  softirqs.CPU144.RCU
     98058 ±  5%     +48.9%     146016 ± 23%  softirqs.CPU144.TIMER
     51616 ± 43%     -57.4%      22011 ± 10%  softirqs.CPU145.RCU
     97012 ±  6%     +50.4%     145877 ± 22%  softirqs.CPU145.TIMER
     51953 ± 44%     -62.2%      19631 ±  3%  softirqs.CPU146.RCU
     97113 ±  6%     +50.8%     146436 ± 23%  softirqs.CPU146.TIMER
     51799 ± 44%     -62.3%      19551 ±  8%  softirqs.CPU147.RCU
     97082 ±  6%     +51.1%     146725 ± 23%  softirqs.CPU147.TIMER
     51881 ± 43%     -62.3%      19566 ±  4%  softirqs.CPU148.RCU
     97129 ±  6%     +56.6%     152104 ± 21%  softirqs.CPU148.TIMER
     52012 ± 43%     -61.8%      19876 ±  6%  softirqs.CPU149.RCU
     97560 ±  6%     +50.1%     146393 ± 23%  softirqs.CPU149.TIMER
     63722 ± 38%     -67.0%      21058 ±  6%  softirqs.CPU150.RCU
     99044 ±  5%     +47.6%     146156 ± 22%  softirqs.CPU150.TIMER
     52114 ± 43%     -60.8%      20405 ±  7%  softirqs.CPU151.RCU
     96876 ±  6%     +49.5%     144816 ± 22%  softirqs.CPU151.TIMER
     52150 ± 44%     -59.9%      20894 ±  5%  softirqs.CPU152.RCU
     52147 ± 44%     -61.7%      19950 ±  4%  softirqs.CPU153.RCU
     97801 ±  6%     +51.0%     147661 ± 23%  softirqs.CPU153.TIMER
     52387 ± 43%     -61.1%      20365 ±  7%  softirqs.CPU154.RCU
     97461 ±  6%     +51.0%     147135 ± 23%  softirqs.CPU154.TIMER
     52457 ± 44%     -62.2%      19826 ±  6%  softirqs.CPU155.RCU
     98132 ±  6%     +49.4%     146614 ± 23%  softirqs.CPU155.TIMER
     52267 ± 44%     -62.2%      19762 ±  4%  softirqs.CPU156.RCU
     96311 ±  6%     +50.6%     145042 ± 22%  softirqs.CPU156.TIMER
     52345 ± 43%     -62.4%      19691 ±  2%  softirqs.CPU157.RCU
     52039 ± 43%     -61.5%      20023 ±  3%  softirqs.CPU158.RCU
     97078 ±  6%     +50.6%     146237 ± 23%  softirqs.CPU158.TIMER
     52081 ± 44%     -60.9%      20345 ± 10%  softirqs.CPU159.RCU
     97540 ±  6%     +51.2%     147514 ± 23%  softirqs.CPU159.TIMER
     52798 ± 43%     -55.9%      23305 ± 15%  softirqs.CPU16.RCU
     52603 ± 43%     -61.9%      20025 ±  5%  softirqs.CPU160.RCU
     97475 ±  6%     +51.3%     147434 ± 22%  softirqs.CPU160.TIMER
     52691 ± 42%     -62.8%      19613 ±  5%  softirqs.CPU161.RCU
     97358 ±  6%     +50.9%     146883 ± 23%  softirqs.CPU161.TIMER
     97224 ±  6%     +50.4%     146203 ± 22%  softirqs.CPU162.TIMER
     97470 ±  7%     +49.7%     145897 ± 23%  softirqs.CPU163.TIMER
     52412 ± 43%     -61.4%      20235 ±  8%  softirqs.CPU164.RCU
     96832 ±  6%     +49.9%     145127 ± 22%  softirqs.CPU164.TIMER
     52748 ± 43%     -61.8%      20166 ±  7%  softirqs.CPU165.RCU
     97414 ±  6%     +51.6%     147725 ± 23%  softirqs.CPU165.TIMER
     52549 ± 43%     -61.5%      20210 ±  4%  softirqs.CPU166.RCU
     97492 ±  6%     +51.4%     147639 ± 23%  softirqs.CPU166.TIMER
     52130 ± 43%     -59.0%      21348 ±  7%  softirqs.CPU167.RCU
     97249 ±  6%     +51.3%     147091 ± 23%  softirqs.CPU167.TIMER
     63144 ± 37%     -65.2%      21957 ±  7%  softirqs.CPU168.RCU
    109843 ±  2%     +47.0%     161430 ± 24%  softirqs.CPU168.TIMER
     63751 ± 36%     -66.8%      21172 ±  6%  softirqs.CPU169.RCU
     52715 ± 44%     -55.5%      23473 ± 10%  softirqs.CPU17.RCU
     63309 ± 37%     -67.0%      20863 ±  6%  softirqs.CPU170.RCU
    109657 ±  2%     +46.5%     160603 ± 24%  softirqs.CPU170.TIMER
     63011 ± 38%     -65.2%      21949 ± 10%  softirqs.CPU171.RCU
    108862 ±  2%     +47.3%     160315 ± 24%  softirqs.CPU171.TIMER
     63097 ± 38%     -66.6%      21105 ± 10%  softirqs.CPU172.RCU
    109504 ±  2%     +48.2%     162319 ± 24%  softirqs.CPU172.TIMER
     63186 ± 38%     -66.5%      21143 ± 10%  softirqs.CPU173.RCU
    110095 ±  2%     +46.6%     161361 ± 24%  softirqs.CPU173.TIMER
     62914 ± 38%     -66.4%      21124 ± 10%  softirqs.CPU174.RCU
    110750 ±  2%     +46.1%     161799 ± 24%  softirqs.CPU174.TIMER
     73942 ± 30%     -70.4%      21912 ±  7%  softirqs.CPU175.RCU
    109262 ±  2%     +45.4%     158907 ± 24%  softirqs.CPU175.TIMER
     63064 ± 38%     -66.8%      20959 ± 11%  softirqs.CPU176.RCU
    109271 ±  2%     +45.7%     159212 ± 24%  softirqs.CPU176.TIMER
     52190 ± 45%     -59.1%      21360 ±  7%  softirqs.CPU177.RCU
    109591 ±  2%     +47.9%     162092 ± 24%  softirqs.CPU177.TIMER
     62695 ± 38%     -66.9%      20775 ±  8%  softirqs.CPU178.RCU
    110553 ±  2%     +47.0%     162540 ± 24%  softirqs.CPU178.TIMER
     63241 ± 38%     -67.4%      20619 ± 10%  softirqs.CPU179.RCU
    109352 ±  2%     +47.4%     161142 ± 24%  softirqs.CPU179.TIMER
     53015 ± 43%     -55.2%      23729 ± 10%  softirqs.CPU18.RCU
     63562 ± 37%     -67.2%      20868 ± 11%  softirqs.CPU180.RCU
    108776 ±  3%     +46.4%     159268 ± 24%  softirqs.CPU180.TIMER
     62801 ± 35%     -66.1%      21291 ± 10%  softirqs.CPU181.RCU
    110792 ±  4%     +43.7%     159219 ± 24%  softirqs.CPU181.TIMER
     63036 ± 38%     -66.3%      21242 ±  7%  softirqs.CPU182.RCU
    108453 ±  3%     +47.3%     159755 ± 24%  softirqs.CPU182.TIMER
     62804 ± 38%     -65.3%      21790 ± 10%  softirqs.CPU183.RCU
    109676 ±  2%     +47.5%     161820 ± 24%  softirqs.CPU183.TIMER
     62781 ± 38%     -66.1%      21307 ± 13%  softirqs.CPU184.RCU
    109571 ±  2%     +48.3%     162539 ± 24%  softirqs.CPU184.TIMER
     54016 ± 31%     -60.7%      21220 ±  9%  softirqs.CPU185.RCU
    110523 ±  2%     +46.7%     162165 ± 24%  softirqs.CPU185.TIMER
     62904 ± 38%     -66.2%      21266 ± 12%  softirqs.CPU186.RCU
    109140 ±  3%     +46.2%     159580 ± 24%  softirqs.CPU186.TIMER
     63152 ± 37%     -66.5%      21150 ±  8%  softirqs.CPU187.RCU
    108026 ±  3%     +48.0%     159836 ± 23%  softirqs.CPU187.TIMER
     63015 ± 38%     -65.9%      21467 ± 10%  softirqs.CPU188.RCU
    108603 ±  2%     +47.9%     160602 ± 24%  softirqs.CPU188.TIMER
     63405 ± 38%     -65.4%      21932 ± 16%  softirqs.CPU189.RCU
    109973 ±  2%     +47.9%     162627 ± 23%  softirqs.CPU189.TIMER
    111425           +45.3%     161921 ± 24%  softirqs.CPU190.TIMER
     62650 ± 37%     -65.7%      21519 ±  5%  softirqs.CPU191.RCU
    110312 ±  2%     +47.9%     163193 ± 24%  softirqs.CPU191.TIMER
     52227 ± 44%     -56.7%      22596 ± 12%  softirqs.CPU2.RCU
     52802 ± 43%     -56.9%      22773 ± 12%  softirqs.CPU20.RCU
     52358 ± 44%     -56.2%      22936 ±  8%  softirqs.CPU21.RCU
     52658 ± 44%     -55.0%      23715 ± 11%  softirqs.CPU22.RCU
     52348 ± 44%     -58.2%      21870 ±  9%  softirqs.CPU23.RCU
     98891 ±  7%     +50.4%     148736 ± 24%  softirqs.CPU24.TIMER
     52884 ± 43%     -61.7%      20251 ±  7%  softirqs.CPU25.RCU
     99421 ±  6%     +49.5%     148663 ± 24%  softirqs.CPU25.TIMER
     52954 ± 43%     -60.5%      20929 ±  8%  softirqs.CPU26.RCU
     99661 ±  7%     +50.0%     149485 ± 24%  softirqs.CPU26.TIMER
     53073 ± 43%     -61.0%      20680 ±  4%  softirqs.CPU27.RCU
     99096 ±  7%     +51.2%     149851 ± 24%  softirqs.CPU27.TIMER
     52987 ± 44%     -62.5%      19884 ±  5%  softirqs.CPU28.RCU
     99469 ±  6%     +51.7%     150901 ± 24%  softirqs.CPU28.TIMER
     53310 ± 43%     -60.9%      20829 ±  8%  softirqs.CPU29.RCU
     53168 ± 43%     -62.6%      19880 ±  7%  softirqs.CPU30.RCU
     99558 ±  6%     +52.2%     151532 ± 24%  softirqs.CPU30.TIMER
     53425 ± 44%     -61.3%      20675 ±  5%  softirqs.CPU31.RCU
     99184 ±  6%     +49.8%     148549 ± 24%  softirqs.CPU31.TIMER
     52971 ± 44%     -60.9%      20716 ±  6%  softirqs.CPU32.RCU
     99047 ±  6%     +50.2%     148735 ± 24%  softirqs.CPU32.TIMER
     62849 ± 40%     -66.7%      20903 ±  5%  softirqs.CPU33.RCU
     98419 ±  6%     +51.2%     148841 ± 24%  softirqs.CPU33.TIMER
     52896 ± 44%     -62.9%      19649 ±  5%  softirqs.CPU34.RCU
     99681 ±  6%     +52.1%     151665 ± 24%  softirqs.CPU34.TIMER
     53180 ± 44%     -60.8%      20825 ±  6%  softirqs.CPU35.RCU
     99229 ±  7%     +52.5%     151301 ± 24%  softirqs.CPU35.TIMER
     52940 ± 44%     -62.1%      20079 ±  8%  softirqs.CPU36.RCU
     99643 ±  6%     +59.3%     158747 ± 28%  softirqs.CPU36.TIMER
     53012 ± 44%     -62.8%      19745 ±  5%  softirqs.CPU37.RCU
     98531 ±  7%     +50.7%     148462 ± 24%  softirqs.CPU37.TIMER
     52968 ± 44%     -62.3%      19982 ±  5%  softirqs.CPU38.RCU
     98644 ±  7%     +51.3%     149223 ± 24%  softirqs.CPU38.TIMER
     53394 ± 44%     -62.2%      20182 ±  3%  softirqs.CPU39.RCU
     99000 ±  6%     +51.1%     149595 ± 24%  softirqs.CPU39.TIMER
     52252 ± 44%     -55.1%      23445 ±  9%  softirqs.CPU4.RCU
     52983 ± 44%     -62.5%      19858 ±  8%  softirqs.CPU40.RCU
     99349 ±  7%     +52.2%     151224 ± 24%  softirqs.CPU40.TIMER
     53017 ± 44%     -61.6%      20355 ±  7%  softirqs.CPU41.RCU
     99582 ±  6%     +51.6%     150968 ± 24%  softirqs.CPU41.TIMER
     52939 ± 44%     -61.5%      20385 ±  6%  softirqs.CPU42.RCU
     99355 ±  6%     +52.0%     151035 ± 24%  softirqs.CPU42.TIMER
     53093 ± 44%     -61.7%      20348 ±  4%  softirqs.CPU43.RCU
     98724 ±  7%     +50.7%     148812 ± 24%  softirqs.CPU43.TIMER
     53410 ± 43%     -61.7%      20453 ±  6%  softirqs.CPU44.RCU
     98761 ±  7%     +51.4%     149534 ± 24%  softirqs.CPU44.TIMER
     53011 ± 44%     -62.2%      20025 ±  6%  softirqs.CPU45.RCU
     99342 ±  6%     +51.5%     150526 ± 24%  softirqs.CPU45.TIMER
     53067 ± 44%     -61.5%      20408 ±  4%  softirqs.CPU46.RCU
     99408 ±  6%     +51.0%     150090 ± 24%  softirqs.CPU46.TIMER
     53057 ± 44%     -60.9%      20768 ±  4%  softirqs.CPU47.RCU
     99258 ±  7%     +51.2%     150089 ± 24%  softirqs.CPU47.TIMER
     98522 ±  6%     +49.3%     147127 ± 22%  softirqs.CPU48.TIMER
     52622 ± 43%     -59.7%      21212 ±  4%  softirqs.CPU49.RCU
     98388 ±  7%     +48.7%     146349 ± 23%  softirqs.CPU49.TIMER
     52326 ± 43%     -54.7%      23704 ±  8%  softirqs.CPU5.RCU
     53296 ± 44%     -62.9%      19759 ±  7%  softirqs.CPU50.RCU
     53176 ± 44%     -62.0%      20208 ±  5%  softirqs.CPU51.RCU
     52785 ± 43%     -60.0%      21088 ±  5%  softirqs.CPU52.RCU
     98426 ±  7%     +64.3%     161697 ± 21%  softirqs.CPU52.TIMER
     52446 ± 43%     -61.6%      20118 ±  4%  softirqs.CPU53.RCU
     98506 ±  6%     +50.2%     147915 ± 23%  softirqs.CPU53.TIMER
     63443 ± 36%     -66.2%      21444 ±  6%  softirqs.CPU54.RCU
     52654 ± 43%     -61.6%      20211 ±  3%  softirqs.CPU55.RCU
     97514 ±  6%     +49.7%     145977 ± 22%  softirqs.CPU55.TIMER
     53050 ± 42%     -60.6%      20923 ±  4%  softirqs.CPU56.RCU
     52849 ± 42%     -61.1%      20543 ±  3%  softirqs.CPU57.RCU
     98839 ±  5%     +50.1%     148366 ± 23%  softirqs.CPU57.TIMER
     52810 ± 43%     -62.0%      20066 ±  5%  softirqs.CPU58.RCU
     98169 ±  6%     +50.2%     147428 ± 22%  softirqs.CPU58.TIMER
     98431 ±  6%     +50.2%     147888 ± 22%  softirqs.CPU59.TIMER
     55291 ± 51%     -58.5%      22964 ± 13%  softirqs.CPU6.RCU
     52610 ± 43%     -60.5%      20760 ±  7%  softirqs.CPU60.RCU
     97558 ±  6%     +49.3%     145689 ± 22%  softirqs.CPU60.TIMER
     52376 ± 43%     -60.0%      20953 ±  4%  softirqs.CPU61.RCU
     52803 ± 42%     -61.1%      20514        softirqs.CPU62.RCU
     97776 ±  6%     +49.5%     146204 ± 22%  softirqs.CPU62.TIMER
     52978 ± 42%     -61.0%      20652 ±  3%  softirqs.CPU63.RCU
     99513 ±  5%     +48.3%     147566 ± 23%  softirqs.CPU63.TIMER
     99166 ±  5%     +49.8%     148518 ± 23%  softirqs.CPU64.TIMER
     53149 ± 42%     -61.6%      20397 ±  5%  softirqs.CPU65.RCU
     98053 ±  6%     +50.9%     148003 ± 23%  softirqs.CPU65.TIMER
     97543 ±  6%     +50.6%     146924 ± 22%  softirqs.CPU66.TIMER
     98024 ±  6%     +49.3%     146396 ± 22%  softirqs.CPU67.TIMER
     53209 ± 42%     -61.7%      20385 ±  6%  softirqs.CPU68.RCU
     97685 ±  6%     +49.5%     146077 ± 22%  softirqs.CPU68.TIMER
     52987 ± 43%     -61.7%      20283 ±  3%  softirqs.CPU69.RCU
     98100 ±  6%     +52.1%     149255 ± 23%  softirqs.CPU69.TIMER
     54157 ± 41%     -57.8%      22872 ± 13%  softirqs.CPU7.RCU
     53110 ± 42%     -61.1%      20670 ±  6%  softirqs.CPU70.RCU
     98246 ±  6%     +51.1%     148418 ± 22%  softirqs.CPU70.TIMER
     52937 ± 42%     -59.0%      21725 ±  7%  softirqs.CPU71.RCU
     98303 ±  6%     +50.5%     147903 ± 22%  softirqs.CPU71.TIMER
     63737 ± 38%     -64.5%      22622 ± 14%  softirqs.CPU72.RCU
    110467 ±  2%     +44.9%     160033 ± 23%  softirqs.CPU72.TIMER
     63283 ± 37%     -66.6%      21164 ±  7%  softirqs.CPU73.RCU
    110488 ±  2%     +45.4%     160671 ± 24%  softirqs.CPU73.TIMER
     63387 ± 38%     -65.4%      21951 ± 12%  softirqs.CPU74.RCU
    109636 ±  3%     +46.3%     160357 ± 24%  softirqs.CPU74.TIMER
     63261 ± 37%     -66.5%      21187 ±  3%  softirqs.CPU75.RCU
    109669 ±  2%     +45.9%     159968 ± 23%  softirqs.CPU75.TIMER
     63503 ± 38%     -65.9%      21643 ±  7%  softirqs.CPU76.RCU
    110451 ±  2%     +47.2%     162617 ± 24%  softirqs.CPU76.TIMER
     63642 ± 38%     -66.4%      21357 ± 10%  softirqs.CPU77.RCU
    110824 ±  2%     +45.9%     161669 ± 24%  softirqs.CPU77.TIMER
     63499 ± 37%     -65.7%      21774 ±  4%  softirqs.CPU78.RCU
    110833 ±  2%     +46.7%     162596 ± 24%  softirqs.CPU78.TIMER
     74429 ± 29%     -70.5%      21959 ±  6%  softirqs.CPU79.RCU
    109840 ±  2%     +44.7%     158935 ± 24%  softirqs.CPU79.TIMER
     52201 ± 44%     -55.9%      23019 ±  9%  softirqs.CPU8.RCU
     52061 ± 43%     -59.5%      21074 ±  9%  softirqs.CPU80.RCU
    110183 ±  2%     +45.1%     159824 ± 24%  softirqs.CPU80.TIMER
     63444 ± 37%     -65.8%      21682 ±  8%  softirqs.CPU81.RCU
    110233 ±  2%     +48.0%     163162 ± 23%  softirqs.CPU81.TIMER
     52500 ± 44%     -59.4%      21337 ±  6%  softirqs.CPU82.RCU
    112044           +45.1%     162626 ± 24%  softirqs.CPU82.TIMER
     63416 ± 38%     -66.4%      21302 ±  3%  softirqs.CPU83.RCU
    110098 ±  2%     +47.2%     162069 ± 24%  softirqs.CPU83.TIMER
     63734 ± 38%     -67.1%      20994 ±  9%  softirqs.CPU84.RCU
    109739 ±  2%     +45.1%     159281 ± 23%  softirqs.CPU84.TIMER
     63574 ± 37%     -67.0%      20966 ±  8%  softirqs.CPU85.RCU
    110101 ±  3%     +44.5%     159112 ± 24%  softirqs.CPU85.TIMER
     63264 ± 37%     -66.3%      21333 ±  8%  softirqs.CPU86.RCU
    108989 ±  3%     +47.3%     160521 ± 24%  softirqs.CPU86.TIMER
     63505 ± 38%     -66.3%      21406 ± 10%  softirqs.CPU87.RCU
    110812           +45.9%     161711 ± 24%  softirqs.CPU87.TIMER
     63412 ± 37%     -65.5%      21888 ±  7%  softirqs.CPU88.RCU
    110509 ±  2%     +48.1%     163677 ± 24%  softirqs.CPU88.TIMER
     54192 ± 31%     -58.8%      22349 ± 11%  softirqs.CPU89.RCU
    110958 ±  2%     +46.8%     162933 ± 24%  softirqs.CPU89.TIMER
     52375 ± 44%     -57.2%      22404 ±  8%  softirqs.CPU9.RCU
     63058 ± 37%     -65.9%      21476 ± 11%  softirqs.CPU90.RCU
    109339 ±  3%     +46.2%     159890 ± 23%  softirqs.CPU90.TIMER
     63304 ± 37%     -66.2%      21392 ± 10%  softirqs.CPU91.RCU
    108899 ±  3%     +47.5%     160595 ± 23%  softirqs.CPU91.TIMER
     63296 ± 38%     -64.8%      22291 ±  9%  softirqs.CPU92.RCU
    109657 ±  2%     +47.2%     161441 ± 23%  softirqs.CPU92.TIMER
     63559 ± 37%     -63.7%      23046 ± 10%  softirqs.CPU93.RCU
    109730 ±  2%     +48.0%     162421 ± 23%  softirqs.CPU93.TIMER
     63701 ± 38%     -65.8%      21767 ±  8%  softirqs.CPU94.RCU
    111979           +45.1%     162467 ± 23%  softirqs.CPU94.TIMER
     51616 ± 43%     -58.3%      21535 ±  6%  softirqs.CPU95.RCU
    111373 ±  2%     +45.7%     162314 ± 23%  softirqs.CPU95.TIMER
     52067 ± 44%     -55.8%      23000 ± 10%  softirqs.CPU97.RCU
     51971 ± 44%     -57.0%      22355 ±  6%  softirqs.CPU98.RCU
  10523405 ± 39%     -61.3%    4076167 ±  5%  softirqs.RCU
    464032           +43.7%     666826 ± 17%  softirqs.SCHED
  20273510 ±  2%     +44.0%   29202119 ± 23%  softirqs.TIMER



***************************************************************************************************
lkp-csl-2ap4: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/100%/debian-x86_64-2019-09-23.cgz/lkp-csl-2ap4/signal1/will-it-scale/0x500002b

commit: 
  2f65452ad7 ("locking/qspinlock: Refactor the qspinlock slow path")
  ad3836e30e ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

2f65452ad747deeb ad3836e30e6f5f5e97867707b57 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
           :2           50%           1:2     dmesg.RIP:smp_call_function_many
          2:2         -100%            :2     dmesg.WARNING:at#for_ip_swapgs_restore_regs_and_return_to_usermode/0x
          2:2         -100%            :2     dmesg.WARNING:stack_recursion



***************************************************************************************************
lkp-csl-2ap3: 192 threads Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz with 192G memory
=========================================================================================
compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase/ucode:
  gcc-7/performance/x86_64-rhel-7.6/thread/50%/debian-x86_64-2019-09-23.cgz/lkp-csl-2ap3/signal1/will-it-scale/0x500002b

commit: 
  2f65452ad7 ("locking/qspinlock: Refactor the qspinlock slow path")
  ad3836e30e ("locking/qspinlock: Introduce CNA into the slow path of qspinlock")

2f65452ad747deeb ad3836e30e6f5f5e97867707b57 
---------------- --------------------------- 
       fail:runs  %reproduction    fail:runs
           |             |             |    
          1:4          -25%            :4     dmesg.WARNING:at#for_ip_interrupt_entry/0x
         %stddev     %change         %stddev
             \          |                \  
      3727           +93.0%       7193        will-it-scale.per_thread_ops
    301.57           +12.4%     339.00 ±  6%  will-it-scale.time.elapsed_time
    301.57           +12.4%     339.00 ±  6%  will-it-scale.time.elapsed_time.max
     28874           +12.0%      32332 ±  6%  will-it-scale.time.system_time
     45.30 ±  3%    +381.3%     218.05 ± 12%  will-it-scale.time.user_time
    357808           +93.0%     690616        will-it-scale.workload
     58529           +19.7%      70041 ±  3%  cpuidle.POLL.usage
     10784 ±  4%     -15.0%       9163 ±  6%  meminfo.max_used_kB
      2.06 ± 53%      +2.5        4.59 ± 38%  turbostat.C6%
  60846670           -34.7%   39716892 ±  6%  turbostat.IRQ
     50.00           +47.0%      73.50        vmstat.cpu.id
    390430           -42.0%     226437 ±  6%  vmstat.system.in
     50.04           +24.1       74.18        mpstat.cpu.all.idle%
     49.87           -24.2       25.63 ±  3%  mpstat.cpu.all.sys%
      0.09            +0.1        0.19 ±  6%  mpstat.cpu.all.usr%
     12756 ± 97%    +168.4%      34240 ± 34%  numa-vmstat.node1.nr_active_anon
     12775 ± 96%    +121.3%      28265 ± 57%  numa-vmstat.node1.nr_anon_pages
     12756 ± 97%    +168.4%      34240 ± 34%  numa-vmstat.node1.nr_zone_active_anon
     40184 ± 28%     -60.5%      15887 ± 47%  numa-vmstat.node3.nr_active_anon
     27539 ± 36%     -61.2%      10685 ± 35%  numa-vmstat.node3.nr_anon_pages
     40184 ± 28%     -60.5%      15887 ± 47%  numa-vmstat.node3.nr_zone_active_anon
      4052 ± 12%     -18.2%       3315 ±  7%  slabinfo.eventpoll_pwq.active_objs
      4052 ± 12%     -18.2%       3315 ±  7%  slabinfo.eventpoll_pwq.num_objs
    994.50 ±  2%     -11.5%     879.75 ±  6%  slabinfo.mnt_cache.active_objs
    994.50 ±  2%     -11.5%     879.75 ±  6%  slabinfo.mnt_cache.num_objs
     17986 ±  3%      -9.2%      16335 ±  6%  slabinfo.proc_inode_cache.active_objs
     18197 ±  3%     -10.2%      16335 ±  6%  slabinfo.proc_inode_cache.num_objs
     51039 ± 97%    +168.6%     137086 ± 34%  numa-meminfo.node1.Active
     51039 ± 97%    +168.4%     136984 ± 34%  numa-meminfo.node1.Active(anon)
     30173 ± 98%    +168.4%      80971 ± 65%  numa-meminfo.node1.AnonHugePages
     51098 ± 96%    +121.2%     113036 ± 57%  numa-meminfo.node1.AnonPages
    160864 ± 28%     -60.4%      63658 ± 47%  numa-meminfo.node3.Active
    160695 ± 28%     -60.4%      63600 ± 47%  numa-meminfo.node3.Active(anon)
     70866 ± 42%     -72.7%      19312 ± 44%  numa-meminfo.node3.AnonHugePages
    110148 ± 36%     -61.2%      42725 ± 35%  numa-meminfo.node3.AnonPages
    776854 ± 16%     -21.2%     612312 ±  3%  numa-meminfo.node3.MemUsed
    110351            -3.8%     106144        proc-vmstat.nr_active_anon
     86745 ±  2%      -3.1%      84055        proc-vmstat.nr_anon_pages
     27424            -1.1%      27127        proc-vmstat.nr_kernel_stack
     24639            -1.9%      24166        proc-vmstat.nr_slab_reclaimable
    110351            -3.8%     106144        proc-vmstat.nr_zone_active_anon
      4120 ± 52%    +135.0%       9683 ±  8%  proc-vmstat.numa_hint_faults
      1830 ± 34%    +112.8%       3894 ± 40%  proc-vmstat.numa_hint_faults_local
   1016243            +9.6%    1113748 ±  4%  proc-vmstat.numa_hit
    922979           +10.6%    1020539 ±  4%  proc-vmstat.numa_local
    117413 ±  8%     +33.5%     156705 ± 17%  proc-vmstat.numa_pte_updates
   1152758            +8.3%    1248795 ±  3%  proc-vmstat.pgalloc_normal
   1091015           +12.2%    1224544 ±  5%  proc-vmstat.pgfault
    532.53 ± 66%     -97.6%      12.59 ±173%  sched_debug.cfs_rq:/.MIN_vruntime.avg
     65409 ± 65%     -98.1%       1246 ±173%  sched_debug.cfs_rq:/.MIN_vruntime.max
      5872 ± 66%     -97.9%     122.21 ±173%  sched_debug.cfs_rq:/.MIN_vruntime.stddev
     10631 ±  5%     -21.9%       8308 ± 13%  sched_debug.cfs_rq:/.load.avg
    447542 ± 19%     -68.1%     142964 ±100%  sched_debug.cfs_rq:/.load.max
     40733 ± 15%     -64.2%      14580 ± 78%  sched_debug.cfs_rq:/.load.stddev
    532.53 ± 66%     -97.6%      12.59 ±173%  sched_debug.cfs_rq:/.max_vruntime.avg
     65409 ± 65%     -98.1%       1246 ±173%  sched_debug.cfs_rq:/.max_vruntime.max
      5872 ± 66%     -97.9%     122.21 ±173%  sched_debug.cfs_rq:/.max_vruntime.stddev
      3.00 ± 32%    +670.8%      23.12 ± 44%  sched_debug.cfs_rq:/.nr_spread_over.max
      0.70 ± 29%    +262.7%       2.54 ± 36%  sched_debug.cfs_rq:/.nr_spread_over.stddev
     10626 ±  5%     -21.9%       8304 ± 13%  sched_debug.cfs_rq:/.runnable_weight.avg
    446851 ± 19%     -68.1%     142654 ±100%  sched_debug.cfs_rq:/.runnable_weight.max
     40692 ± 15%     -64.2%      14570 ± 78%  sched_debug.cfs_rq:/.runnable_weight.stddev
    393.78 ± 15%     +46.2%     575.51        sched_debug.cfs_rq:/.util_est_enqueued.avg
    261.04 ± 18%     +35.4%     353.35 ±  7%  sched_debug.cfs_rq:/.util_est_enqueued.stddev
    180819 ± 51%     -69.6%      55032 ± 54%  sched_debug.cpu.avg_idle.min
      1.33           -18.7%       1.08 ±  7%  sched_debug.cpu.nr_running.max
      1358 ±  5%     -18.1%       1112 ± 17%  sched_debug.cpu.nr_switches.min
     14.66 ±  2%      +7.2%      15.71 ±  3%  sched_debug.cpu.nr_uninterruptible.stddev
      0.00          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_migratory.avg
      0.17          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_migratory.max
      0.01          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_migratory.stddev
      0.00          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_running.avg
      0.17          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_running.max
      0.01          -100.0%       0.00        sched_debug.rt_rq:/.rt_nr_running.stddev
      2.52           -28.6%       1.80 ± 18%  sched_debug.rt_rq:/.rt_runtime.stddev
      0.40 ± 57%     -96.8%       0.01 ±173%  sched_debug.rt_rq:/.rt_time.avg
     76.25 ± 57%     -96.8%       2.48 ±173%  sched_debug.rt_rq:/.rt_time.max
      5.49 ± 57%     -96.8%       0.18 ±173%  sched_debug.rt_rq:/.rt_time.stddev
      1.90           +90.3%       3.61        perf-stat.i.MPKI
 6.714e+09            +4.8%  7.038e+09        perf-stat.i.branch-instructions
      0.19            +0.0        0.20 ±  3%  perf-stat.i.branch-miss-rate%
  12809243 ±  2%     +11.7%   14311637 ±  2%  perf-stat.i.branch-misses
     54.09           -53.2        0.91 ± 16%  perf-stat.i.cache-miss-rate%
  28039617 ±  2%     -96.6%     959554 ± 17%  perf-stat.i.cache-misses
  52077460          +100.8%  1.046e+08        perf-stat.i.cache-references
     10.89            -5.1%      10.33        perf-stat.i.cpi
     10674 ±  2%   +3050.7%     336310 ± 16%  perf-stat.i.cycles-between-cache-misses
      0.00 ±  6%      -0.0        0.00 ± 38%  perf-stat.i.dTLB-load-miss-rate%
    150739 ±  6%     -38.0%      93505 ± 35%  perf-stat.i.dTLB-load-misses
      0.00 ±  4%      -0.0        0.00 ±  8%  perf-stat.i.dTLB-store-miss-rate%
     11309 ±  3%      -8.5%      10349 ±  3%  perf-stat.i.dTLB-store-misses
 5.437e+08           +64.0%  8.919e+08 ±  5%  perf-stat.i.dTLB-stores
     67.06            +8.4       75.43        perf-stat.i.iTLB-load-miss-rate%
   3120825 ±  2%     -36.5%    1982185        perf-stat.i.iTLB-loads
 2.747e+10            +5.6%  2.901e+10        perf-stat.i.instructions
      4327 ±  2%     +10.6%       4785 ±  4%  perf-stat.i.instructions-per-iTLB-miss
      0.09            +5.4%       0.10        perf-stat.i.ipc
     99.34            -6.0       93.32        perf-stat.i.node-load-miss-rate%
   6282217 ±  2%     -94.3%     360175 ± 16%  perf-stat.i.node-load-misses
     42895 ± 10%     -25.1%      32135 ± 10%  perf-stat.i.node-loads
     99.93            -1.5       98.42        perf-stat.i.node-store-miss-rate%
   6985323 ±  2%     -98.2%     123964 ± 15%  perf-stat.i.node-store-misses
      4634 ± 14%     -44.8%       2559 ± 29%  perf-stat.i.node-stores
      1.90           +90.2%       3.61        perf-stat.overall.MPKI
      0.19            +0.0        0.20 ±  3%  perf-stat.overall.branch-miss-rate%
     53.84           -52.9        0.91 ± 16%  perf-stat.overall.cache-miss-rate%
     10.89            -5.1%      10.33        perf-stat.overall.cpi
     10673 ±  2%   +2909.6%     321225 ± 14%  perf-stat.overall.cycles-between-cache-misses
      0.00 ±  6%      -0.0        0.00 ± 38%  perf-stat.overall.dTLB-load-miss-rate%
      0.00 ±  4%      -0.0        0.00 ±  9%  perf-stat.overall.dTLB-store-miss-rate%
     67.10            +8.4       75.45        perf-stat.overall.iTLB-load-miss-rate%
      4317 ±  2%     +10.5%       4771 ±  4%  perf-stat.overall.instructions-per-iTLB-miss
      0.09            +5.4%       0.10        perf-stat.overall.ipc
     99.32            -7.6       91.72        perf-stat.overall.node-load-miss-rate%
     99.93            -1.9       98.01        perf-stat.overall.node-store-miss-rate%
  22887340           -48.8%   11728959 ±  9%  perf-stat.overall.path-length
 6.692e+09            +4.6%  6.998e+09        perf-stat.ps.branch-instructions
  12765641 ±  2%     +11.5%   14231573 ±  2%  perf-stat.ps.branch-misses
  27943868 ±  2%     -96.6%     953244 ± 17%  perf-stat.ps.cache-misses
  51899628          +100.4%   1.04e+08        perf-stat.ps.cache-references
    150234 ±  6%     -37.8%      93463 ± 35%  perf-stat.ps.dTLB-load-misses
     11274 ±  3%      -8.7%      10293 ±  3%  perf-stat.ps.dTLB-store-misses
 5.419e+08           +63.5%  8.858e+08 ±  5%  perf-stat.ps.dTLB-stores
   3110140 ±  2%     -36.7%    1967628        perf-stat.ps.iTLB-loads
 2.737e+10            +5.4%  2.884e+10        perf-stat.ps.instructions
   6260771 ±  2%     -94.3%     357806 ± 16%  perf-stat.ps.node-load-misses
     42756 ± 10%     -25.3%      31941 ± 10%  perf-stat.ps.node-loads
   6961478 ±  2%     -98.2%     123211 ± 15%  perf-stat.ps.node-store-misses
      4627 ± 14%     -45.0%       2544 ± 29%  perf-stat.ps.node-stores
     21.56 ±  5%     -21.6        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
     11.15 ±  5%     -11.2        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific
     11.05 ±  5%     -11.1        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.do_signal
     10.77 ±  5%     -10.8        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
     10.71 ±  5%     -10.7        0.00        perf-profile.calltrace.cycles-pp.native_queued_spin_lock_slowpath._raw_spin_lock_irq.get_signal.do_signal.exit_to_usermode_loop
     44.17 ±  5%      -3.5       40.67 ±  3%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     44.18 ±  5%      -3.5       40.68 ±  3%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.raise
     44.23 ±  5%      -3.5       40.76 ±  3%  perf-profile.calltrace.cycles-pp.raise
     11.17 ±  6%      -2.7        8.48 ±  5%  perf-profile.calltrace.cycles-pp.__set_current_blocked.signal_setup_done.do_signal.exit_to_usermode_loop.do_syscall_64
     11.17 ±  5%      -2.7        8.49 ±  5%  perf-profile.calltrace.cycles-pp.signal_setup_done.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.21 ±  5%      -2.7        8.54 ±  5%  perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.22 ±  5%      -2.7        8.54 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     11.10 ±  6%      -2.7        8.43 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.do_signal.exit_to_usermode_loop
     11.25 ±  5%      -2.6        8.64 ±  5%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe
     11.25 ±  5%      -2.6        8.64 ±  5%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.82 ±  5%      -2.2        8.67 ±  5%  perf-profile.calltrace.cycles-pp.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe
     10.91 ±  5%      -2.1        8.77 ±  5%  perf-profile.calltrace.cycles-pp.do_signal.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     10.73 ±  5%      -2.1        8.60 ±  5%  perf-profile.calltrace.cycles-pp._raw_spin_lock_irq.get_signal.do_signal.exit_to_usermode_loop.do_syscall_64
     10.91 ±  5%      -2.1        8.78 ±  5%  perf-profile.calltrace.cycles-pp.exit_to_usermode_loop.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     21.80 ±  5%      -1.4       20.42 ±  3%  perf-profile.calltrace.cycles-pp.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     21.83 ±  5%      -1.4       20.45 ±  3%  perf-profile.calltrace.cycles-pp.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe.raise
     21.78 ±  5%      -1.4       20.41 ±  3%  perf-profile.calltrace.cycles-pp.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.00            +8.4        8.40 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.signal_setup_done.do_signal
      0.00            +8.6        8.57 ±  5%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irq.get_signal.do_signal.exit_to_usermode_loop
      0.00           +11.2       11.19 ±  7%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irqsave.__lock_task_sighand.do_send_sig_info.do_send_specific
      0.00           +11.2       11.25 ±  4%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.__x64_sys_rt_sigreturn.do_syscall_64
      0.00           +20.2       20.22 ±  3%  perf-profile.calltrace.cycles-pp.__cna_queued_spin_lock_slowpath._raw_spin_lock_irq.__set_current_blocked.sigprocmask.__x64_sys_rt_sigprocmask
     65.24 ±  5%     -65.2        0.00        perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
     54.31 ±  5%      -5.7       48.62 ±  2%  perf-profile.children.cycles-pp._raw_spin_lock_irq
     66.33 ±  5%      -5.6       60.70 ±  2%  perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     66.32 ±  5%      -5.6       60.69 ±  2%  perf-profile.children.cycles-pp.do_syscall_64
     22.12 ±  5%      -4.8       17.31 ±  3%  perf-profile.children.cycles-pp.do_signal
     22.13 ±  5%      -4.8       17.32 ±  3%  perf-profile.children.cycles-pp.exit_to_usermode_loop
     43.86 ±  5%      -3.6       40.24 ±  2%  perf-profile.children.cycles-pp.__set_current_blocked
     44.25 ±  5%      -3.5       40.78 ±  3%  perf-profile.children.cycles-pp.raise
     11.17 ±  5%      -2.7        8.49 ±  5%  perf-profile.children.cycles-pp.signal_setup_done
     10.83 ±  5%      -2.2        8.67 ±  5%  perf-profile.children.cycles-pp.get_signal
     21.80 ±  5%      -1.4       20.42 ±  3%  perf-profile.children.cycles-pp.sigprocmask
     21.83 ±  5%      -1.4       20.45 ±  3%  perf-profile.children.cycles-pp.__x64_sys_rt_sigprocmask
      0.33 ± 30%      -0.2        0.09 ± 11%  perf-profile.children.cycles-pp.apic_timer_interrupt
      0.29 ± 32%      -0.2        0.08 ± 10%  perf-profile.children.cycles-pp.smp_apic_timer_interrupt
      0.21 ± 27%      -0.1        0.07 ± 14%  perf-profile.children.cycles-pp.hrtimer_interrupt
      0.12 ± 21%      -0.1        0.03 ±100%  perf-profile.children.cycles-pp.__hrtimer_run_queues
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__send_signal
      0.06 ±  6%      +0.0        0.08 ±  5%  perf-profile.children.cycles-pp.copy_fpstate_to_sigframe
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.fpu__clear
      0.00            +0.1        0.05 ±  8%  perf-profile.children.cycles-pp.__perf_event_read_value
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.smp_call_function_single
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.perf_read
      0.00            +0.1        0.09 ± 15%  perf-profile.children.cycles-pp.perf_event_read
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.ksys_read
      0.00            +0.1        0.09 ± 11%  perf-profile.children.cycles-pp.vfs_read
      0.00            +0.1        0.11        perf-profile.children.cycles-pp.cna_scan_main_queue
      0.00           +59.6       59.64 ±  2%  perf-profile.children.cycles-pp.__cna_queued_spin_lock_slowpath
     65.24 ±  5%     -65.2        0.00        perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.22 ±  7%      -0.0        0.18 ±  4%  perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.00            +0.1        0.09 ± 15%  perf-profile.self.cycles-pp.smp_call_function_single
      0.00            +0.1        0.11 ±  4%  perf-profile.self.cycles-pp.cna_scan_main_queue
      0.00           +59.5       59.53 ±  2%  perf-profile.self.cycles-pp.__cna_queued_spin_lock_slowpath
     38469 ± 39%     +70.1%      65425 ± 14%  softirqs.CPU0.SCHED
    109845 ± 11%     -22.1%      85541 ± 16%  softirqs.CPU1.TIMER
    149776 ±  6%     -64.5%      53122 ± 24%  softirqs.CPU100.TIMER
    136093 ± 14%     -62.1%      51597 ± 22%  softirqs.CPU101.TIMER
    148314 ±  6%     -63.1%      54795 ± 28%  softirqs.CPU102.TIMER
    154532           -60.4%      61147 ± 22%  softirqs.CPU103.TIMER
    149314 ±  7%     -65.7%      51213 ± 25%  softirqs.CPU104.TIMER
    143064 ± 13%     -64.4%      50921 ± 24%  softirqs.CPU105.TIMER
    149347 ±  7%     -61.6%      57414 ± 17%  softirqs.CPU106.TIMER
    148768 ±  7%     -65.6%      51139 ± 24%  softirqs.CPU107.TIMER
    146598 ±  9%     -64.9%      51445 ± 25%  softirqs.CPU108.TIMER
    143443 ± 13%     -61.7%      54910 ± 21%  softirqs.CPU109.TIMER
    148388 ±  6%     -64.5%      52664 ± 25%  softirqs.CPU110.TIMER
    142930 ± 13%     -63.7%      51818 ± 26%  softirqs.CPU111.TIMER
     18827 ± 76%     -72.4%       5204 ± 51%  softirqs.CPU112.SCHED
    121929 ± 20%     -56.9%      52576 ± 25%  softirqs.CPU112.TIMER
    148130 ±  6%     -53.4%      68978 ± 23%  softirqs.CPU113.TIMER
    148182 ±  6%     -64.7%      52365 ± 25%  softirqs.CPU114.TIMER
    136482 ± 14%     -63.0%      50525 ± 24%  softirqs.CPU115.TIMER
    148636 ±  7%     -65.8%      50801 ± 23%  softirqs.CPU116.TIMER
    138484 ± 12%     -63.6%      50449 ± 24%  softirqs.CPU117.TIMER
    148128 ±  6%     -65.8%      50625 ± 25%  softirqs.CPU118.TIMER
    148534 ±  7%     -57.5%      63157 ± 25%  softirqs.CPU119.TIMER
    148691 ±  6%     -72.9%      40267 ± 29%  softirqs.CPU120.TIMER
    148576 ±  6%     -72.7%      40593 ± 29%  softirqs.CPU121.TIMER
    141691 ± 15%     -71.1%      40896 ± 29%  softirqs.CPU122.TIMER
    154448           -73.9%      40344 ± 29%  softirqs.CPU123.TIMER
    154224           -74.1%      40010 ± 30%  softirqs.CPU124.TIMER
    154299           -74.0%      40089 ± 30%  softirqs.CPU125.TIMER
    148767 ±  6%     -73.0%      40187 ± 30%  softirqs.CPU126.TIMER
    148721 ±  6%     -73.0%      40160 ± 30%  softirqs.CPU127.TIMER
    141191 ± 15%     -71.4%      40414 ± 29%  softirqs.CPU128.TIMER
    154117           -73.8%      40353 ± 29%  softirqs.CPU129.TIMER
    148486 ±  6%     -72.6%      40619 ± 28%  softirqs.CPU130.TIMER
    154044           -73.6%      40628 ± 28%  softirqs.CPU131.TIMER
    154160           -74.0%      40146 ± 29%  softirqs.CPU132.TIMER
    148510 ±  6%     -73.0%      40027 ± 29%  softirqs.CPU133.TIMER
    154120           -74.0%      40045 ± 30%  softirqs.CPU134.TIMER
    134015 ± 16%     -70.1%      40040 ± 30%  softirqs.CPU135.TIMER
    148203 ±  6%     -73.0%      40049 ± 30%  softirqs.CPU136.TIMER
    135128 ± 15%     -70.4%      40006 ± 30%  softirqs.CPU137.TIMER
    148315 ±  6%     -72.8%      40393 ± 29%  softirqs.CPU138.TIMER
    141559 ± 15%     -71.6%      40161 ± 30%  softirqs.CPU139.TIMER
    115903 ± 21%     -26.7%      84926 ± 10%  softirqs.CPU14.TIMER
    155720           -74.2%      40139 ± 29%  softirqs.CPU140.TIMER
    148282 ±  6%     -73.1%      39917 ± 30%  softirqs.CPU141.TIMER
    148507 ±  6%     -72.9%      40275 ± 30%  softirqs.CPU142.TIMER
    139283 ± 12%     -71.0%      40417 ± 29%  softirqs.CPU143.TIMER
    135723 ± 14%     -58.1%      56805 ± 45%  softirqs.CPU144.TIMER
    148242 ±  6%     -72.2%      41209 ± 21%  softirqs.CPU145.TIMER
    148112 ±  6%     -72.2%      41157 ± 22%  softirqs.CPU146.TIMER
    148205 ±  6%     -67.5%      48141 ± 42%  softirqs.CPU147.TIMER
    153899           -73.2%      41291 ± 21%  softirqs.CPU148.TIMER
    148297 ±  6%     -72.3%      41073 ± 21%  softirqs.CPU149.TIMER
    134239 ± 16%     -69.2%      41320 ± 21%  softirqs.CPU150.TIMER
    136470 ± 13%     -69.8%      41170 ± 21%  softirqs.CPU151.TIMER
    136242 ± 14%     -69.4%      41690 ± 21%  softirqs.CPU152.TIMER
    148164 ±  6%     -72.1%      41358 ± 21%  softirqs.CPU153.TIMER
    124656 ± 16%     -67.0%      41151 ± 21%  softirqs.CPU154.TIMER
    134912 ± 15%     -69.6%      40965 ± 21%  softirqs.CPU155.TIMER
    135587 ± 15%     -69.7%      41136 ± 21%  softirqs.CPU156.TIMER
    126794 ± 12%     -67.5%      41157 ± 21%  softirqs.CPU157.TIMER
    147915 ±  6%     -70.5%      43639 ± 19%  softirqs.CPU158.TIMER
    154127           -73.5%      40884 ± 21%  softirqs.CPU159.TIMER
    146788 ± 11%     -43.2%      83385 ±  9%  softirqs.CPU16.TIMER
    136264 ± 13%     -69.8%      41149 ± 21%  softirqs.CPU160.TIMER
    153961           -73.4%      40950 ± 21%  softirqs.CPU161.TIMER
    135912 ± 14%     -69.6%      41304 ± 21%  softirqs.CPU162.TIMER
    136130 ± 13%     -70.0%      40898 ± 22%  softirqs.CPU163.TIMER
    147836 ±  6%     -61.9%      56347 ± 48%  softirqs.CPU164.TIMER
    128395 ± 19%     -68.1%      40903 ± 22%  softirqs.CPU165.TIMER
    135661 ± 14%     -69.6%      41179 ± 21%  softirqs.CPU166.TIMER
    136822 ± 13%     -69.4%      41933 ± 21%  softirqs.CPU167.TIMER
    149651 ±  7%     -73.8%      39274 ± 18%  softirqs.CPU168.TIMER
    148486 ±  6%     -73.6%      39198 ± 18%  softirqs.CPU169.TIMER
    114474 ± 21%     -41.0%      67501 ± 31%  softirqs.CPU17.TIMER
    138367 ± 20%     -71.3%      39763 ± 17%  softirqs.CPU170.TIMER
    148076 ±  6%     -73.5%      39292 ± 19%  softirqs.CPU171.TIMER
    135262 ± 14%     -70.7%      39670 ± 17%  softirqs.CPU172.TIMER
    141848 ± 14%     -72.1%      39546 ± 18%  softirqs.CPU173.TIMER
    153762           -74.4%      39423 ± 17%  softirqs.CPU174.TIMER
    137278 ± 12%     -71.2%      39588 ± 17%  softirqs.CPU175.TIMER
    147932 ±  6%     -73.3%      39450 ± 18%  softirqs.CPU176.TIMER
    147733 ±  6%     -72.3%      40862 ± 15%  softirqs.CPU177.TIMER
    142171 ± 14%     -72.2%      39537 ± 18%  softirqs.CPU178.TIMER
    154034           -74.5%      39206 ± 18%  softirqs.CPU179.TIMER
    120594 ± 18%     -29.5%      85068 ±  8%  softirqs.CPU18.TIMER
    153840           -74.0%      40043 ± 18%  softirqs.CPU180.TIMER
    127306 ± 15%     -69.2%      39230 ± 18%  softirqs.CPU181.TIMER
    135478 ± 15%     -71.2%      39082 ± 18%  softirqs.CPU182.TIMER
    140999 ± 15%     -72.1%      39348 ± 17%  softirqs.CPU183.TIMER
    135904 ± 14%     -71.1%      39301 ± 18%  softirqs.CPU184.TIMER
    135052 ± 15%     -70.7%      39598 ± 17%  softirqs.CPU185.TIMER
    135746 ± 14%     -71.2%      39091 ± 18%  softirqs.CPU186.TIMER
    147761 ±  6%     -72.3%      40888 ± 16%  softirqs.CPU187.TIMER
    154798           -74.5%      39543 ± 18%  softirqs.CPU188.TIMER
    140624 ± 15%     -72.1%      39236 ± 18%  softirqs.CPU189.TIMER
    143360 ±  7%     -72.5%      39478 ± 17%  softirqs.CPU190.TIMER
    148430 ±  6%     -73.4%      39529 ± 18%  softirqs.CPU191.TIMER
      8224 ± 63%    +143.4%      20014 ± 57%  softirqs.CPU26.SCHED
      8692 ± 75%    +167.3%      23236 ± 41%  softirqs.CPU32.SCHED
      6193 ± 52%    +219.1%      19765 ± 55%  softirqs.CPU39.SCHED
    118030 ± 19%     -28.9%      83893 ± 10%  softirqs.CPU4.TIMER
      5775 ± 36%    +261.0%      20850 ± 56%  softirqs.CPU43.SCHED
    120622 ± 19%     -28.6%      86131 ± 10%  softirqs.CPU43.TIMER
    108122 ± 14%     -21.9%      84398 ± 11%  softirqs.CPU44.TIMER
    122385 ± 18%     -30.7%      84858 ± 10%  softirqs.CPU47.TIMER
    139916 ± 20%     -46.6%      74714 ± 27%  softirqs.CPU48.TIMER
    111871 ± 22%     -29.3%      79100 ± 15%  softirqs.CPU51.TIMER
    111498 ± 22%     -23.1%      85732 ± 11%  softirqs.CPU53.TIMER
    136254 ± 15%     -37.7%      84823 ± 11%  softirqs.CPU58.TIMER
    139662 ± 18%     -37.9%      86791 ± 11%  softirqs.CPU61.TIMER
    111954 ± 22%     -36.0%      71681 ± 25%  softirqs.CPU68.TIMER
    113356 ± 22%     -24.2%      85885 ± 11%  softirqs.CPU72.TIMER
    116408 ± 21%     -24.7%      87660 ± 10%  softirqs.CPU73.TIMER
    122698 ± 17%     -29.9%      86007 ± 12%  softirqs.CPU74.TIMER
    142166 ± 16%     -39.3%      86352 ± 10%  softirqs.CPU79.TIMER
    116018 ± 20%     -28.8%      82623 ± 14%  softirqs.CPU8.TIMER
    137480 ± 14%     -63.4%      50359 ± 20%  softirqs.CPU96.TIMER
    155283           -66.9%      51430 ± 24%  softirqs.CPU97.TIMER
    151862 ±  6%     -64.8%      53508 ± 24%  softirqs.CPU98.TIMER
    154615           -67.3%      50607 ± 24%  softirqs.CPU99.TIMER
   3398889 ± 16%     -22.4%    2636078 ± 12%  softirqs.SCHED
  25265046 ±  5%     -50.8%   12440482 ± 13%  softirqs.TIMER
    607.00           +11.9%     679.00 ±  5%  interrupts.9:IO-APIC.9-fasteoi.acpi
      4075 ± 21%     -28.4%       2919 ±  4%  interrupts.CPU0.CAL:Function_call_interrupts
      6112 ± 53%   +1087.1%      72552 ± 47%  interrupts.CPU0.RES:Rescheduling_interrupts
    607.00           +11.9%     679.00 ±  5%  interrupts.CPU1.9:IO-APIC.9-fasteoi.acpi
      4591 ± 18%     +41.6%       6501 ± 18%  interrupts.CPU10.NMI:Non-maskable_interrupts
      4591 ± 18%     +41.6%       6501 ± 18%  interrupts.CPU10.PMI:Performance_monitoring_interrupts
    601943           -62.1%     228243 ± 19%  interrupts.CPU100.LOC:Local_timer_interrupts
    601850           -66.5%     201818 ± 13%  interrupts.CPU101.LOC:Local_timer_interrupts
      3306 ± 90%    +119.2%       7250 ± 28%  interrupts.CPU101.TLB:TLB_shootdowns
    601858           -67.1%     198115 ± 15%  interrupts.CPU102.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU102.TLB:TLB_shootdowns
    601851           -51.7%     290646 ± 56%  interrupts.CPU103.LOC:Local_timer_interrupts
    602179           -66.9%     199175 ± 14%  interrupts.CPU104.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU104.TLB:TLB_shootdowns
    601905           -67.0%     198352 ± 15%  interrupts.CPU105.LOC:Local_timer_interrupts
      2927 ±111%    +147.6%       7250 ± 28%  interrupts.CPU105.TLB:TLB_shootdowns
    602090           -56.9%     259430 ± 43%  interrupts.CPU106.LOC:Local_timer_interrupts
    602012           -66.0%     204685 ± 10%  interrupts.CPU107.LOC:Local_timer_interrupts
    601965           -66.8%     199985 ± 14%  interrupts.CPU108.LOC:Local_timer_interrupts
      2926 ±111%    +147.8%       7251 ± 28%  interrupts.CPU108.TLB:TLB_shootdowns
    602165           -65.9%     205217 ±  9%  interrupts.CPU109.LOC:Local_timer_interrupts
      3873 ± 21%     +43.2%       5546 ±  5%  interrupts.CPU11.NMI:Non-maskable_interrupts
      3873 ± 21%     +43.2%       5546 ±  5%  interrupts.CPU11.PMI:Performance_monitoring_interrupts
    601906           -62.9%     223229 ± 23%  interrupts.CPU110.LOC:Local_timer_interrupts
    601917           -66.9%     199442 ± 14%  interrupts.CPU111.LOC:Local_timer_interrupts
      2927 ±111%    +147.6%       7250 ± 28%  interrupts.CPU111.TLB:TLB_shootdowns
    602399           -63.1%     222294 ± 25%  interrupts.CPU112.LOC:Local_timer_interrupts
      1139 ±103%    +387.6%       5556 ± 50%  interrupts.CPU112.TLB:TLB_shootdowns
    601913           -38.9%     367637 ± 49%  interrupts.CPU113.LOC:Local_timer_interrupts
    601808           -63.3%     221088 ± 25%  interrupts.CPU114.LOC:Local_timer_interrupts
    601881           -67.0%     198830 ± 15%  interrupts.CPU115.LOC:Local_timer_interrupts
      3318 ± 90%    +118.5%       7250 ± 28%  interrupts.CPU115.TLB:TLB_shootdowns
    601825           -67.0%     198442 ± 15%  interrupts.CPU116.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU116.TLB:TLB_shootdowns
    601918           -67.1%     197919 ± 15%  interrupts.CPU117.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU117.TLB:TLB_shootdowns
    602168           -67.2%     197631 ± 15%  interrupts.CPU118.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU118.TLB:TLB_shootdowns
      4407 ± 21%     -34.1%       2906 ±  4%  interrupts.CPU12.CAL:Function_call_interrupts
    601796           -69.2%     185490 ± 10%  interrupts.CPU120.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU120.TLB:TLB_shootdowns
    601800           -69.0%     186433 ±  9%  interrupts.CPU121.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7251 ± 28%  interrupts.CPU121.TLB:TLB_shootdowns
    601838           -69.3%     184910 ± 10%  interrupts.CPU122.LOC:Local_timer_interrupts
      2926 ±111%    +147.8%       7251 ± 28%  interrupts.CPU122.TLB:TLB_shootdowns
    601832           -69.2%     185242 ± 10%  interrupts.CPU123.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU123.TLB:TLB_shootdowns
    601806           -69.3%     184763 ± 10%  interrupts.CPU124.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU124.TLB:TLB_shootdowns
    601819           -69.2%     185388 ± 10%  interrupts.CPU125.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7249 ± 28%  interrupts.CPU125.TLB:TLB_shootdowns
    601806           -69.3%     184822 ± 10%  interrupts.CPU126.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU126.TLB:TLB_shootdowns
    601885           -69.2%     185309 ± 10%  interrupts.CPU127.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7250 ± 28%  interrupts.CPU127.TLB:TLB_shootdowns
    601841           -69.1%     186027 ± 10%  interrupts.CPU128.LOC:Local_timer_interrupts
      2926 ±111%    +147.8%       7250 ± 28%  interrupts.CPU128.TLB:TLB_shootdowns
    601810           -69.1%     185827 ± 11%  interrupts.CPU129.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU129.TLB:TLB_shootdowns
    601819           -69.3%     184843 ± 10%  interrupts.CPU130.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU130.TLB:TLB_shootdowns
    601837           -69.1%     185992 ± 11%  interrupts.CPU131.LOC:Local_timer_interrupts
      5818 ± 30%     +47.4%       8578 ±  5%  interrupts.CPU131.NMI:Non-maskable_interrupts
      5818 ± 30%     +47.4%       8578 ±  5%  interrupts.CPU131.PMI:Performance_monitoring_interrupts
      3244 ± 93%    +123.5%       7252 ± 28%  interrupts.CPU131.TLB:TLB_shootdowns
    601824           -69.1%     185690 ±  9%  interrupts.CPU132.LOC:Local_timer_interrupts
      5808 ± 30%     +47.7%       8577 ±  5%  interrupts.CPU132.NMI:Non-maskable_interrupts
      5808 ± 30%     +47.7%       8577 ±  5%  interrupts.CPU132.PMI:Performance_monitoring_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU132.TLB:TLB_shootdowns
    601829           -69.2%     185288 ± 10%  interrupts.CPU133.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7250 ± 28%  interrupts.CPU133.TLB:TLB_shootdowns
    601811           -69.3%     184659 ± 10%  interrupts.CPU134.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU134.TLB:TLB_shootdowns
    601837           -69.3%     184699 ± 10%  interrupts.CPU135.LOC:Local_timer_interrupts
      5442 ± 45%     +57.6%       8577 ±  5%  interrupts.CPU135.NMI:Non-maskable_interrupts
      5442 ± 45%     +57.6%       8577 ±  5%  interrupts.CPU135.PMI:Performance_monitoring_interrupts
      2518 ±133%    +187.9%       7251 ± 28%  interrupts.CPU135.TLB:TLB_shootdowns
    601859           -69.2%     185221 ± 10%  interrupts.CPU136.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7250 ± 28%  interrupts.CPU136.TLB:TLB_shootdowns
    601807           -69.3%     184489 ± 10%  interrupts.CPU137.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU137.TLB:TLB_shootdowns
    601818           -69.2%     185438 ± 10%  interrupts.CPU138.LOC:Local_timer_interrupts
      3625 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU138.TLB:TLB_shootdowns
    601851           -69.2%     185648 ± 10%  interrupts.CPU139.LOC:Local_timer_interrupts
      2926 ±111%    +147.8%       7250 ± 28%  interrupts.CPU139.TLB:TLB_shootdowns
      4536 ± 19%     +26.2%       5726        interrupts.CPU14.NMI:Non-maskable_interrupts
      4536 ± 19%     +26.2%       5726        interrupts.CPU14.PMI:Performance_monitoring_interrupts
    601876           -69.1%     185800 ± 10%  interrupts.CPU140.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7249 ± 28%  interrupts.CPU140.TLB:TLB_shootdowns
    601854           -69.3%     184954 ± 10%  interrupts.CPU141.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7250 ± 28%  interrupts.CPU141.TLB:TLB_shootdowns
    601804           -69.1%     186223 ± 10%  interrupts.CPU142.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU142.TLB:TLB_shootdowns
      5609 ± 11%     +62.9%       9139 ± 22%  interrupts.CPU143.CAL:Function_call_interrupts
    601804           -69.3%     184931 ± 10%  interrupts.CPU143.LOC:Local_timer_interrupts
      1851 ± 29%    +291.5%       7250 ± 28%  interrupts.CPU143.TLB:TLB_shootdowns
    601878           -71.4%     172258 ± 23%  interrupts.CPU145.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU145.TLB:TLB_shootdowns
    601935           -71.4%     172248 ± 23%  interrupts.CPU146.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU146.TLB:TLB_shootdowns
    601872           -60.0%     240901 ± 52%  interrupts.CPU147.LOC:Local_timer_interrupts
    601882           -71.3%     172461 ± 24%  interrupts.CPU148.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU148.TLB:TLB_shootdowns
    601903           -71.4%     172014 ± 23%  interrupts.CPU149.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU149.TLB:TLB_shootdowns
      4447 ± 22%     -34.4%       2915 ±  4%  interrupts.CPU15.CAL:Function_call_interrupts
    600258           -71.2%     172667 ± 23%  interrupts.CPU150.LOC:Local_timer_interrupts
      2949 ±107%    +145.9%       7251 ± 28%  interrupts.CPU150.TLB:TLB_shootdowns
    600184           -71.2%     172981 ± 23%  interrupts.CPU151.LOC:Local_timer_interrupts
      2949 ±107%    +145.8%       7250 ± 28%  interrupts.CPU151.TLB:TLB_shootdowns
    600158           -71.3%     172256 ± 23%  interrupts.CPU152.LOC:Local_timer_interrupts
      2949 ±107%    +145.7%       7245 ± 28%  interrupts.CPU152.TLB:TLB_shootdowns
    601824           -71.5%     171400 ± 23%  interrupts.CPU153.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU153.TLB:TLB_shootdowns
      5217 ± 17%     +73.6%       9058 ± 22%  interrupts.CPU154.CAL:Function_call_interrupts
    600745           -71.4%     171518 ± 23%  interrupts.CPU154.LOC:Local_timer_interrupts
      1177 ± 60%    +515.8%       7250 ± 28%  interrupts.CPU154.TLB:TLB_shootdowns
    600232           -71.2%     172938 ± 23%  interrupts.CPU155.LOC:Local_timer_interrupts
      2949 ±107%    +145.9%       7250 ± 28%  interrupts.CPU155.TLB:TLB_shootdowns
    601922           -71.4%     172242 ± 24%  interrupts.CPU156.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7251 ± 28%  interrupts.CPU156.TLB:TLB_shootdowns
    601370           -71.4%     171986 ± 23%  interrupts.CPU157.LOC:Local_timer_interrupts
      2631 ±127%    +175.5%       7250 ± 28%  interrupts.CPU157.TLB:TLB_shootdowns
    601813           -71.3%     172958 ± 22%  interrupts.CPU158.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7251 ± 28%  interrupts.CPU158.TLB:TLB_shootdowns
    601843           -71.5%     171664 ± 23%  interrupts.CPU159.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU159.TLB:TLB_shootdowns
    601832           -71.4%     172005 ± 23%  interrupts.CPU160.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU160.TLB:TLB_shootdowns
    601853           -71.4%     172032 ± 23%  interrupts.CPU161.LOC:Local_timer_interrupts
      3244 ± 93%    +123.5%       7250 ± 28%  interrupts.CPU161.TLB:TLB_shootdowns
    601899           -71.4%     171918 ± 23%  interrupts.CPU162.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU162.TLB:TLB_shootdowns
    601878           -71.5%     171664 ± 23%  interrupts.CPU163.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU163.TLB:TLB_shootdowns
    600238           -71.4%     171572 ± 23%  interrupts.CPU165.LOC:Local_timer_interrupts
      2251 ±155%    +222.0%       7250 ± 28%  interrupts.CPU165.TLB:TLB_shootdowns
    601773           -71.3%     172794 ± 24%  interrupts.CPU166.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7250 ± 28%  interrupts.CPU166.TLB:TLB_shootdowns
    601795           -71.3%     172782 ± 24%  interrupts.CPU167.LOC:Local_timer_interrupts
      3306 ± 90%    +119.3%       7251 ± 28%  interrupts.CPU167.TLB:TLB_shootdowns
    601936           -68.6%     188943 ± 11%  interrupts.CPU168.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7250 ± 28%  interrupts.CPU168.TLB:TLB_shootdowns
    601956           -68.7%     188544 ± 10%  interrupts.CPU169.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU169.TLB:TLB_shootdowns
    599814           -32.9%     402293 ± 37%  interrupts.CPU17.LOC:Local_timer_interrupts
      5089 ± 26%     +80.1%       9163 ± 22%  interrupts.CPU170.CAL:Function_call_interrupts
    601727           -68.4%     190293 ± 11%  interrupts.CPU170.LOC:Local_timer_interrupts
      1169 ± 91%    +520.0%       7249 ± 28%  interrupts.CPU170.TLB:TLB_shootdowns
    602029           -68.8%     188094 ± 10%  interrupts.CPU171.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU171.TLB:TLB_shootdowns
    601979           -68.5%     189400 ± 11%  interrupts.CPU172.LOC:Local_timer_interrupts
      3301 ± 90%    +119.6%       7250 ± 28%  interrupts.CPU172.TLB:TLB_shootdowns
    602021           -68.6%     189122 ± 11%  interrupts.CPU173.LOC:Local_timer_interrupts
      2976 ±107%    +143.6%       7249 ± 28%  interrupts.CPU173.TLB:TLB_shootdowns
    601927           -68.5%     189306 ± 11%  interrupts.CPU174.LOC:Local_timer_interrupts
      3250 ± 93%    +123.1%       7250 ± 28%  interrupts.CPU174.TLB:TLB_shootdowns
    601137           -68.4%     190126 ± 10%  interrupts.CPU175.LOC:Local_timer_interrupts
      2951 ±107%    +145.6%       7249 ± 28%  interrupts.CPU175.TLB:TLB_shootdowns
    601903           -68.5%     189781 ± 10%  interrupts.CPU176.LOC:Local_timer_interrupts
      3625 ± 75%    +100.0%       7251 ± 28%  interrupts.CPU176.TLB:TLB_shootdowns
    601903           -68.3%     190951 ± 11%  interrupts.CPU177.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU177.TLB:TLB_shootdowns
    601407           -68.4%     189929 ± 11%  interrupts.CPU178.LOC:Local_timer_interrupts
      2573 ±130%    +181.7%       7250 ± 28%  interrupts.CPU178.TLB:TLB_shootdowns
    601943           -68.6%     188869 ± 11%  interrupts.CPU179.LOC:Local_timer_interrupts
      3249 ± 93%    +123.1%       7250 ± 28%  interrupts.CPU179.TLB:TLB_shootdowns
      4557 ± 19%     +25.7%       5726        interrupts.CPU18.NMI:Non-maskable_interrupts
      4557 ± 19%     +25.7%       5726        interrupts.CPU18.PMI:Performance_monitoring_interrupts
    601927           -68.7%     188588 ± 10%  interrupts.CPU180.LOC:Local_timer_interrupts
      3250 ± 93%    +123.0%       7250 ± 28%  interrupts.CPU180.TLB:TLB_shootdowns
    601250           -68.4%     189864 ± 10%  interrupts.CPU181.LOC:Local_timer_interrupts
      2426 ±140%    +198.7%       7248 ± 28%  interrupts.CPU181.TLB:TLB_shootdowns
    600443           -68.6%     188607 ± 10%  interrupts.CPU182.LOC:Local_timer_interrupts
      2955 ±107%    +145.3%       7248 ± 28%  interrupts.CPU182.TLB:TLB_shootdowns
    601967           -68.3%     191018 ± 11%  interrupts.CPU183.LOC:Local_timer_interrupts
      2936 ±110%    +147.0%       7250 ± 28%  interrupts.CPU183.TLB:TLB_shootdowns
    602042           -68.7%     188708 ± 10%  interrupts.CPU184.LOC:Local_timer_interrupts
      3318 ± 90%    +118.5%       7250 ± 28%  interrupts.CPU184.TLB:TLB_shootdowns
    600518           -68.3%     190238 ± 11%  interrupts.CPU185.LOC:Local_timer_interrupts
      2950 ±107%    +145.8%       7251 ± 28%  interrupts.CPU185.TLB:TLB_shootdowns
    601960           -68.8%     188008 ± 10%  interrupts.CPU186.LOC:Local_timer_interrupts
      3315 ± 90%    +118.7%       7251 ± 28%  interrupts.CPU186.TLB:TLB_shootdowns
    602001           -68.3%     190561 ± 11%  interrupts.CPU187.LOC:Local_timer_interrupts
      3625 ± 75%    +100.0%       7250 ± 28%  interrupts.CPU187.TLB:TLB_shootdowns
    601971           -68.2%     191404 ± 11%  interrupts.CPU188.LOC:Local_timer_interrupts
      3624 ± 75%    +100.0%       7251 ± 28%  interrupts.CPU188.TLB:TLB_shootdowns
    602240           -68.6%     189382 ± 11%  interrupts.CPU189.LOC:Local_timer_interrupts
      2572 ±130%    +181.9%       7251 ± 28%  interrupts.CPU189.TLB:TLB_shootdowns
      4060 ± 22%     -28.4%       2908 ±  4%  interrupts.CPU19.CAL:Function_call_interrupts
    601967           -68.3%     190865 ± 11%  interrupts.CPU190.LOC:Local_timer_interrupts
      3435 ± 84%    +111.1%       7251 ± 28%  interrupts.CPU190.TLB:TLB_shootdowns
    601980           -68.1%     191744 ± 11%  interrupts.CPU191.LOC:Local_timer_interrupts
      3538 ± 78%    +100.9%       7108 ± 26%  interrupts.CPU191.TLB:TLB_shootdowns
      3780 ±  9%     -22.6%       2925 ±  4%  interrupts.CPU2.CAL:Function_call_interrupts
      4561 ± 19%     +25.7%       5734        interrupts.CPU2.NMI:Non-maskable_interrupts
      4561 ± 19%     +25.7%       5734        interrupts.CPU2.PMI:Performance_monitoring_interrupts
      1803 ±146%    +492.1%      10677 ± 76%  interrupts.CPU2.RES:Rescheduling_interrupts
      3743 ±  9%     -22.4%       2903 ±  4%  interrupts.CPU20.CAL:Function_call_interrupts
      4511 ± 19%     +26.9%       5724        interrupts.CPU20.NMI:Non-maskable_interrupts
      4511 ± 19%     +26.9%       5724        interrupts.CPU20.PMI:Performance_monitoring_interrupts
      4065 ± 22%     -28.6%       2901 ±  5%  interrupts.CPU21.CAL:Function_call_interrupts
      3742 ±  9%     -22.2%       2912 ±  4%  interrupts.CPU22.CAL:Function_call_interrupts
      4527 ± 19%     +26.5%       5727        interrupts.CPU22.NMI:Non-maskable_interrupts
      4527 ± 19%     +26.5%       5727        interrupts.CPU22.PMI:Performance_monitoring_interrupts
      3489 ±  4%     -15.7%       2941 ±  3%  interrupts.CPU24.CAL:Function_call_interrupts
      3829 ± 11%     -22.8%       2957 ±  3%  interrupts.CPU25.CAL:Function_call_interrupts
      4538 ± 19%     +26.3%       5730        interrupts.CPU25.NMI:Non-maskable_interrupts
      4538 ± 19%     +26.3%       5730        interrupts.CPU25.PMI:Performance_monitoring_interrupts
      4497 ± 22%     -34.6%       2943 ±  3%  interrupts.CPU26.CAL:Function_call_interrupts
      4162 ± 17%     -28.8%       2964 ±  3%  interrupts.CPU27.CAL:Function_call_interrupts
      4161 ± 17%     -29.0%       2954 ±  3%  interrupts.CPU28.CAL:Function_call_interrupts
      4199 ± 17%     -29.5%       2960 ±  3%  interrupts.CPU29.CAL:Function_call_interrupts
      4053 ± 21%     -28.1%       2912 ±  5%  interrupts.CPU3.CAL:Function_call_interrupts
      3816 ± 11%     -34.7%       2494 ± 33%  interrupts.CPU30.CAL:Function_call_interrupts
      4584 ± 19%     +27.7%       5854 ±  3%  interrupts.CPU30.NMI:Non-maskable_interrupts
      4584 ± 19%     +27.7%       5854 ±  3%  interrupts.CPU30.PMI:Performance_monitoring_interrupts
      3817 ± 11%     -34.2%       2513 ± 34%  interrupts.CPU31.CAL:Function_call_interrupts
      4570 ± 19%     +27.7%       5834 ±  3%  interrupts.CPU31.NMI:Non-maskable_interrupts
      4570 ± 19%     +27.7%       5834 ±  3%  interrupts.CPU31.PMI:Performance_monitoring_interrupts
      4523 ± 22%     -34.5%       2963 ±  3%  interrupts.CPU32.CAL:Function_call_interrupts
      4208 ± 17%     -29.6%       2964 ±  3%  interrupts.CPU33.CAL:Function_call_interrupts
      3844 ± 12%     -23.0%       2961 ±  3%  interrupts.CPU34.CAL:Function_call_interrupts
      4540 ± 19%     +26.1%       5727        interrupts.CPU34.NMI:Non-maskable_interrupts
      4540 ± 19%     +26.1%       5727        interrupts.CPU34.PMI:Performance_monitoring_interrupts
      4227 ± 17%     -30.1%       2956 ±  3%  interrupts.CPU35.CAL:Function_call_interrupts
      4210 ± 17%     -29.7%       2959 ±  3%  interrupts.CPU36.CAL:Function_call_interrupts
      3825 ± 12%     -22.8%       2954 ±  3%  interrupts.CPU37.CAL:Function_call_interrupts
      4537 ± 19%     +26.2%       5725        interrupts.CPU37.NMI:Non-maskable_interrupts
      4537 ± 19%     +26.2%       5725        interrupts.CPU37.PMI:Performance_monitoring_interrupts
      4210 ± 17%     -29.7%       2960 ±  3%  interrupts.CPU38.CAL:Function_call_interrupts
      4238 ± 11%     +35.2%       5728        interrupts.CPU38.NMI:Non-maskable_interrupts
      4238 ± 11%     +35.2%       5728        interrupts.CPU38.PMI:Performance_monitoring_interrupts
      4940 ± 18%     -40.1%       2960 ±  3%  interrupts.CPU39.CAL:Function_call_interrupts
      4567 ± 19%     +25.4%       5729        interrupts.CPU4.NMI:Non-maskable_interrupts
      4567 ± 19%     +25.4%       5729        interrupts.CPU4.PMI:Performance_monitoring_interrupts
      3829 ± 12%     -22.7%       2960 ±  3%  interrupts.CPU40.CAL:Function_call_interrupts
      3854 ± 20%     +48.6%       5728        interrupts.CPU40.NMI:Non-maskable_interrupts
      3854 ± 20%     +48.6%       5728        interrupts.CPU40.PMI:Performance_monitoring_interrupts
      4149 ± 24%     -29.0%       2944 ±  4%  interrupts.CPU41.CAL:Function_call_interrupts
      3823 ± 12%     -21.9%       2987 ±  2%  interrupts.CPU42.CAL:Function_call_interrupts
      3844 ± 20%     +49.0%       5728        interrupts.CPU42.NMI:Non-maskable_interrupts
      3844 ± 20%     +49.0%       5728        interrupts.CPU42.PMI:Performance_monitoring_interrupts
      4525 ± 23%     -34.6%       2961 ±  3%  interrupts.CPU43.CAL:Function_call_interrupts
      4198 ± 17%     -29.5%       2960 ±  3%  interrupts.CPU44.CAL:Function_call_interrupts
      4224 ± 12%     +30.6%       5519 ±  6%  interrupts.CPU44.NMI:Non-maskable_interrupts
      4224 ± 12%     +30.6%       5519 ±  6%  interrupts.CPU44.PMI:Performance_monitoring_interrupts
      3813 ± 12%     -22.7%       2948 ±  3%  interrupts.CPU45.CAL:Function_call_interrupts
      3838 ± 20%     +49.2%       5728        interrupts.CPU45.NMI:Non-maskable_interrupts
      3838 ± 20%     +49.2%       5728        interrupts.CPU45.PMI:Performance_monitoring_interrupts
      3815 ± 12%     -22.4%       2959 ±  3%  interrupts.CPU46.CAL:Function_call_interrupts
      3898 ± 20%     +46.9%       5728        interrupts.CPU46.NMI:Non-maskable_interrupts
      3898 ± 20%     +46.9%       5728        interrupts.CPU46.PMI:Performance_monitoring_interrupts
      5591 ± 52%     -47.1%       2959 ±  3%  interrupts.CPU47.CAL:Function_call_interrupts
      3771 ± 11%     -21.6%       2958 ±  4%  interrupts.CPU49.CAL:Function_call_interrupts
      4067 ± 21%     -28.0%       2926 ±  4%  interrupts.CPU5.CAL:Function_call_interrupts
      3771 ± 11%     -38.5%       2319 ± 40%  interrupts.CPU50.CAL:Function_call_interrupts
      4149 ± 17%     -29.8%       2914 ±  3%  interrupts.CPU52.CAL:Function_call_interrupts
      3763 ± 11%     -22.5%       2916 ±  3%  interrupts.CPU53.CAL:Function_call_interrupts
      4437 ± 24%     -34.3%       2916 ±  3%  interrupts.CPU54.CAL:Function_call_interrupts
      4465 ± 23%     -33.7%       2961 ±  3%  interrupts.CPU55.CAL:Function_call_interrupts
      4444 ± 23%     -34.2%       2925 ±  3%  interrupts.CPU56.CAL:Function_call_interrupts
      3762 ± 11%     -21.2%       2966 ±  4%  interrupts.CPU57.CAL:Function_call_interrupts
      6185 ± 43%     -52.9%       2916 ±  3%  interrupts.CPU58.CAL:Function_call_interrupts
      4434 ± 24%     -34.2%       2916 ±  3%  interrupts.CPU59.CAL:Function_call_interrupts
      3763 ±  9%     -22.4%       2919 ±  4%  interrupts.CPU6.CAL:Function_call_interrupts
      4626 ± 18%     +23.9%       5730        interrupts.CPU6.NMI:Non-maskable_interrupts
      4626 ± 18%     +23.9%       5730        interrupts.CPU6.PMI:Performance_monitoring_interrupts
      4078 ± 24%     -28.5%       2917 ±  3%  interrupts.CPU60.CAL:Function_call_interrupts
      4733 ± 25%     -38.4%       2914 ±  3%  interrupts.CPU61.CAL:Function_call_interrupts
      3757 ± 11%     -22.3%       2920 ±  3%  interrupts.CPU62.CAL:Function_call_interrupts
      4143 ± 17%     -30.3%       2888 ±  3%  interrupts.CPU63.CAL:Function_call_interrupts
      4070 ± 24%     -28.3%       2917 ±  3%  interrupts.CPU64.CAL:Function_call_interrupts
      4146 ± 17%     -30.9%       2863 ±  4%  interrupts.CPU65.CAL:Function_call_interrupts
      4074 ± 23%     -28.4%       2917 ±  3%  interrupts.CPU66.CAL:Function_call_interrupts
      4077 ± 24%     -28.4%       2918 ±  3%  interrupts.CPU67.CAL:Function_call_interrupts
    598385           -21.5%     470005 ± 29%  interrupts.CPU68.LOC:Local_timer_interrupts
      3386 ± 35%     +58.7%       5375 ± 11%  interrupts.CPU68.NMI:Non-maskable_interrupts
      3386 ± 35%     +58.7%       5375 ± 11%  interrupts.CPU68.PMI:Performance_monitoring_interrupts
      5123 ± 20%     -43.1%       2912 ±  3%  interrupts.CPU69.CAL:Function_call_interrupts
      1374 ± 69%     -99.9%       1.50 ±173%  interrupts.CPU69.TLB:TLB_shootdowns
      4068 ± 23%     -28.4%       2911 ±  3%  interrupts.CPU70.CAL:Function_call_interrupts
      4065 ± 23%     -28.4%       2911 ±  3%  interrupts.CPU71.CAL:Function_call_interrupts
      3768 ± 11%     -21.6%       2955 ±  4%  interrupts.CPU72.CAL:Function_call_interrupts
      3772 ± 11%     -21.6%       2956 ±  3%  interrupts.CPU73.CAL:Function_call_interrupts
      6224 ± 51%     -52.4%       2963 ±  3%  interrupts.CPU74.CAL:Function_call_interrupts
      2469 ±138%     -99.8%       5.00 ±103%  interrupts.CPU74.TLB:TLB_shootdowns
      3773 ± 12%     -21.4%       2965 ±  3%  interrupts.CPU75.CAL:Function_call_interrupts
      4095 ± 24%     -27.7%       2960 ±  3%  interrupts.CPU76.CAL:Function_call_interrupts
    340.00 ±158%     -99.4%       2.00 ±173%  interrupts.CPU76.TLB:TLB_shootdowns
      4462 ± 23%     -33.6%       2964 ±  3%  interrupts.CPU77.CAL:Function_call_interrupts
    704.75 ± 98%     -99.1%       6.50 ±105%  interrupts.CPU77.TLB:TLB_shootdowns
      4135 ± 17%     -28.3%       2964 ±  3%  interrupts.CPU78.CAL:Function_call_interrupts
    438.75 ±143%     -98.2%       8.00 ±145%  interrupts.CPU78.TLB:TLB_shootdowns
      4428 ± 24%     -33.0%       2966 ±  3%  interrupts.CPU79.CAL:Function_call_interrupts
      3755 ±  9%     -22.7%       2902 ±  4%  interrupts.CPU8.CAL:Function_call_interrupts
      3812 ± 10%     -22.3%       2961 ±  3%  interrupts.CPU80.CAL:Function_call_interrupts
      3763 ± 11%     -21.5%       2952 ±  3%  interrupts.CPU81.CAL:Function_call_interrupts
      4803 ± 21%     -48.8%       2457 ± 35%  interrupts.CPU82.CAL:Function_call_interrupts
      4178 ± 19%     -29.1%       2963 ±  3%  interrupts.CPU83.CAL:Function_call_interrupts
      4212 ± 18%     -29.6%       2963 ±  3%  interrupts.CPU84.CAL:Function_call_interrupts
    393.75 ±165%     -98.2%       7.25 ±150%  interrupts.CPU84.TLB:TLB_shootdowns
      5055 ± 21%     -41.3%       2966 ±  3%  interrupts.CPU85.CAL:Function_call_interrupts
      4504 ± 24%     -34.1%       2966 ±  3%  interrupts.CPU86.CAL:Function_call_interrupts
    688.25 ±168%     -98.9%       7.75 ±121%  interrupts.CPU86.TLB:TLB_shootdowns
      4514 ± 23%     -34.4%       2963 ±  3%  interrupts.CPU87.CAL:Function_call_interrupts
      4135 ± 22%     -28.3%       2965 ±  3%  interrupts.CPU88.CAL:Function_call_interrupts
      4491 ± 24%     -34.1%       2960 ±  3%  interrupts.CPU89.CAL:Function_call_interrupts
      4359 ± 21%     -33.2%       2910 ±  4%  interrupts.CPU9.CAL:Function_call_interrupts
      4127 ± 23%     -28.3%       2960 ±  3%  interrupts.CPU90.CAL:Function_call_interrupts
      4720 ± 16%     +21.4%       5732        interrupts.CPU90.NMI:Non-maskable_interrupts
      4720 ± 16%     +21.4%       5732        interrupts.CPU90.PMI:Performance_monitoring_interrupts
      3823 ± 11%     -22.7%       2953 ±  3%  interrupts.CPU91.CAL:Function_call_interrupts
      4088 ± 35%     +40.2%       5731        interrupts.CPU91.NMI:Non-maskable_interrupts
      4088 ± 35%     +40.2%       5731        interrupts.CPU91.PMI:Performance_monitoring_interrupts
      3823 ± 11%     -22.8%       2953 ±  3%  interrupts.CPU92.CAL:Function_call_interrupts
      4879 ± 22%     -39.4%       2955 ±  3%  interrupts.CPU93.CAL:Function_call_interrupts
      4103 ± 20%     -28.0%       2954 ±  3%  interrupts.CPU94.CAL:Function_call_interrupts
      4236 ± 30%     +35.3%       5731        interrupts.CPU94.NMI:Non-maskable_interrupts
      4236 ± 30%     +35.3%       5731        interrupts.CPU94.PMI:Performance_monitoring_interrupts
      3850 ± 13%     -22.7%       2976 ±  4%  interrupts.CPU95.CAL:Function_call_interrupts
      4123 ± 35%     +39.3%       5742        interrupts.CPU95.NMI:Non-maskable_interrupts
      4123 ± 35%     +39.3%       5742        interrupts.CPU95.PMI:Performance_monitoring_interrupts
    601869           -66.9%     198998 ± 15%  interrupts.CPU96.LOC:Local_timer_interrupts
      3323 ± 89%    +117.9%       7240 ± 28%  interrupts.CPU96.TLB:TLB_shootdowns
    602062           -66.0%     204835 ± 10%  interrupts.CPU97.LOC:Local_timer_interrupts
    601868           -67.1%     197900 ± 15%  interrupts.CPU98.LOC:Local_timer_interrupts
      3624 ± 75%    +100.1%       7251 ± 28%  interrupts.CPU98.TLB:TLB_shootdowns
    601847           -67.2%     197325 ± 15%  interrupts.CPU99.LOC:Local_timer_interrupts
      3245 ± 93%    +123.4%       7250 ± 28%  interrupts.CPU99.TLB:TLB_shootdowns
 1.153e+08           -36.6%   73117854 ±  8%  interrupts.LOC:Local_timer_interrupts
    350781 ± 75%    +100.1%     701830 ± 28%  interrupts.TLB:TLB_shootdowns





Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Oliver Sang


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="config-5.4.0-rc6-00240-gad3836e30e6f5"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.4.0-rc6 Kernel Configuration
#

#
# Compiler: gcc-7 (Debian 7.4.0-14) 7.4.0
#
CONFIG_CC_IS_GCC=y
CONFIG_GCC_VERSION=70400
CONFIG_CLANG_VERSION=0
CONFIG_CC_CAN_LINK=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_WARN_MAYBE_UNINITIALIZED=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_HEADER_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
CONFIG_POSIX_MQUEUE=y
CONFIG_POSIX_MQUEUE_SYSCTL=y
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_USELIB=y
CONFIG_AUDIT=y
CONFIG_HAVE_ARCH_AUDITSYSCALL=y
CONFIG_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_GENERIC_IRQ_MIGRATION=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_SIM=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_MSI_IRQ=y
CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_DATA=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=y
CONFIG_CONTEXT_TRACKING=y
# CONFIG_CONTEXT_TRACKING_FORCE is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

#
# CPU/Task time and stats accounting
#
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CONFIG_HAVE_SCHED_AVG_IRQ=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_TASKSTATS=y
CONFIG_TASK_DELAY_ACCT=y
CONFIG_TASK_XACCT=y
CONFIG_TASK_IO_ACCOUNTING=y
# CONFIG_PSI is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=y

#
# RCU Subsystem
#
CONFIG_TREE_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
CONFIG_TREE_SRCU=y
CONFIG_TASKS_RCU=y
CONFIG_RCU_STALL_COMMON=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_RCU_NOCB_CPU=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_NUMA_BALANCING=y
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=y
CONFIG_CGROUPS=y
CONFIG_PAGE_COUNTER=y
CONFIG_MEMCG=y
CONFIG_MEMCG_SWAP=y
CONFIG_MEMCG_SWAP_ENABLED=y
CONFIG_MEMCG_KMEM=y
CONFIG_BLK_CGROUP=y
CONFIG_CGROUP_WRITEBACK=y
CONFIG_CGROUP_SCHED=y
CONFIG_FAIR_GROUP_SCHED=y
CONFIG_CFS_BANDWIDTH=y
CONFIG_RT_GROUP_SCHED=y
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
CONFIG_CGROUP_HUGETLB=y
CONFIG_CPUSETS=y
CONFIG_PROC_PID_CPUSET=y
CONFIG_CGROUP_DEVICE=y
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_BPF=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=y
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
CONFIG_USER_NS=y
CONFIG_PID_NS=y
CONFIG_NET_NS=y
CONFIG_CHECKPOINT_RESTORE=y
CONFIG_SCHED_AUTOGROUP=y
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_HAVE_UID16=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_BPF=y
CONFIG_EXPERT=y
CONFIG_UID16=y
CONFIG_MULTIUSER=y
CONFIG_SGETMASK_SYSCALL=y
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_PRINTK_NMI=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_PCSPKR_PLATFORM=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_MEMBARRIER=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_USERFAULTFD=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
CONFIG_RSEQ=y
# CONFIG_DEBUG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
# CONFIG_SLAB_FREELIST_RANDOM is not set
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SYSTEM_DATA_VERIFICATION=y
CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_ARCH_DEFCONFIG="arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_FILTER_PGPROT=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ZONE_DMA32=y
CONFIG_AUDIT_ARCH=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_HAVE_INTEL_TXT=y
CONFIG_X86_64_SMP=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_DYNAMIC_PHYSICAL_MASK=y
CONFIG_PGTABLE_LEVELS=5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
CONFIG_ZONE_DMA=y
CONFIG_SMP=y
CONFIG_X86_FEATURE_NAMES=y
CONFIG_X86_X2APIC=y
CONFIG_X86_MPPARSE=y
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=y
CONFIG_X86_CPU_RESCTRL=y
CONFIG_X86_EXTENDED_PLATFORM=y
# CONFIG_X86_NUMACHIP is not set
# CONFIG_X86_VSMP is not set
CONFIG_X86_UV=y
# CONFIG_X86_GOLDFISH is not set
# CONFIG_X86_INTEL_MID is not set
CONFIG_X86_INTEL_LPSS=y
CONFIG_X86_AMD_PLATFORM_DEVICE=y
CONFIG_IOSF_MBI=y
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
CONFIG_PARAVIRT_XXL=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=y
CONFIG_X86_HV_CALLBACK_VECTOR=y
CONFIG_XEN=y
CONFIG_XEN_PV=y
CONFIG_XEN_PV_SMP=y
# CONFIG_XEN_DOM0 is not set
CONFIG_XEN_PVHVM=y
CONFIG_XEN_PVHVM_SMP=y
CONFIG_XEN_512GB=y
CONFIG_XEN_SAVE_RESTORE=y
# CONFIG_XEN_DEBUG_FS is not set
# CONFIG_XEN_PVH is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=y
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
# CONFIG_ACRN_GUEST is not set
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
CONFIG_GART_IOMMU=y
# CONFIG_CALGARY_IOMMU is not set
CONFIG_MAXSMP=y
CONFIG_NR_CPUS_RANGE_BEGIN=8192
CONFIG_NR_CPUS_RANGE_END=8192
CONFIG_NR_CPUS_DEFAULT=8192
CONFIG_NR_CPUS=8192
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_SCHED_MC_PRIO=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
CONFIG_X86_MCE=y
CONFIG_X86_MCELOG_LEGACY=y
CONFIG_X86_MCE_INTEL=y
CONFIG_X86_MCE_AMD=y
CONFIG_X86_MCE_THRESHOLD=y
CONFIG_X86_MCE_INJECT=m
CONFIG_X86_THERMAL_VECTOR=y

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# end of Performance monitoring

CONFIG_X86_16BIT=y
CONFIG_X86_ESPFIX64=y
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_I8K=m
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
CONFIG_MICROCODE_AMD=y
CONFIG_MICROCODE_OLD_INTERFACE=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_5LEVEL=y
CONFIG_X86_DIRECT_GBPAGES=y
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=y
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=y
CONFIG_NUMA_AWARE_SPINLOCKS=y
CONFIG_AMD_NUMA=y
CONFIG_X86_64_ACPI_NUMA=y
CONFIG_NODES_SPAN_OTHER_NODES=y
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=10
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_ARCH_MEMORY_PROBE=y
CONFIG_ARCH_PROC_KCORE_TEXT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=y
CONFIG_X86_PMEM_LEGACY=m
CONFIG_X86_CHECK_BIOS_CORRUPTION=y
# CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
CONFIG_X86_RESERVE_LOW=64
CONFIG_MTRR=y
CONFIG_MTRR_SANITIZER=y
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
CONFIG_X86_PAT=y
CONFIG_ARCH_USES_PG_UNCACHED=y
CONFIG_ARCH_RANDOM=y
CONFIG_X86_SMAP=y
CONFIG_X86_INTEL_UMIP=y
CONFIG_X86_INTEL_MPX=y
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
CONFIG_EFI=y
CONFIG_EFI_STUB=y
CONFIG_EFI_MIXED=y
CONFIG_SECCOMP=y
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
# CONFIG_HZ_300 is not set
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_SCHED_HRTICK=y
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=y
CONFIG_KEXEC_JUMP=y
CONFIG_PHYSICAL_START=0x1000000
CONFIG_RELOCATABLE=y
CONFIG_RANDOMIZE_BASE=y
CONFIG_X86_NEED_RELOCS=y
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=y
CONFIG_RANDOMIZE_MEMORY=y
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0xa
CONFIG_HOTPLUG_CPU=y
CONFIG_BOOTPARAM_HOTPLUG_CPU0=y
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
CONFIG_LEGACY_VSYSCALL_EMULATE=y
# CONFIG_LEGACY_VSYSCALL_XONLY is not set
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_HAVE_LIVEPATCH=y
CONFIG_LIVEPATCH=y
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
CONFIG_USE_PERCPU_NUMA_NODE_ID=y
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=y
CONFIG_PM_TRACE_RTC=y
CONFIG_PM_CLK=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
# CONFIG_ENERGY_MODEL is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_SLEEP=y
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_EC_DEBUGFS=m
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_TAD is not set
CONFIG_ACPI_DOCK=y
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_IPMI=m
CONFIG_ACPI_HOTPLUG_CPU=y
CONFIG_ACPI_PROCESSOR_AGGREGATOR=m
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_NUMA=y
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_PCI_SLOT=y
CONFIG_ACPI_CONTAINER=y
CONFIG_ACPI_HOTPLUG_MEMORY=y
CONFIG_ACPI_HOTPLUG_IOAPIC=y
CONFIG_ACPI_SBS=m
CONFIG_ACPI_HED=y
CONFIG_ACPI_CUSTOM_METHOD=m
CONFIG_ACPI_BGRT=y
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=m
# CONFIG_NFIT_SECURITY_DEBUG is not set
# CONFIG_ACPI_HMAT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
CONFIG_ACPI_APEI=y
CONFIG_ACPI_APEI_GHES=y
CONFIG_ACPI_APEI_PCIEAER=y
CONFIG_ACPI_APEI_MEMORY_FAILURE=y
CONFIG_ACPI_APEI_EINJ=m
CONFIG_ACPI_APEI_ERST_DEBUG=y
# CONFIG_DPTF_POWER is not set
CONFIG_ACPI_WATCHDOG=y
CONFIG_ACPI_EXTLOG=m
CONFIG_ACPI_ADXL=y
# CONFIG_PMIC_OPREGION is not set
# CONFIG_ACPI_CONFIGFS is not set
CONFIG_X86_PM_TIMER=y
CONFIG_SFI=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
# CONFIG_CPU_FREQ_STAT is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
# CONFIG_CPU_FREQ_GOV_SCHEDUTIL is not set

#
# CPU frequency scaling drivers
#
CONFIG_X86_INTEL_PSTATE=y
CONFIG_X86_PCC_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ=m
CONFIG_X86_ACPI_CPUFREQ_CPB=y
CONFIG_X86_POWERNOW_K8=m
CONFIG_X86_AMD_FREQ_SENSITIVITY=m
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
# CONFIG_CPU_IDLE_GOV_LADDER is not set
CONFIG_CPU_IDLE_GOV_MENU=y
# CONFIG_CPU_IDLE_GOV_TEO is not set
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_XEN=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=y
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=y
CONFIG_COMPAT=y
CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
CONFIG_SYSVIPC_COMPAT=y
# end of Binary Emulations

CONFIG_X86_DEV_DMA_OPS=y

#
# Firmware Drivers
#
CONFIG_EDD=m
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
CONFIG_DMI_SYSFS=y
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
CONFIG_FW_CFG_SYSFS=y
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
# CONFIG_GOOGLE_FIRMWARE is not set

#
# EFI (Extensible Firmware Interface) Support
#
CONFIG_EFI_VARS=y
CONFIG_EFI_ESRT=y
CONFIG_EFI_VARS_PSTORE=y
CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=y
CONFIG_EFI_RUNTIME_MAP=y
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_RUNTIME_WRAPPERS=y
# CONFIG_EFI_BOOTLOADER_CONTROL is not set
# CONFIG_EFI_CAPSULE_LOADER is not set
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=y
# CONFIG_RESET_ATTACK_MITIGATION is not set
# CONFIG_EFI_RCI2_TABLE is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=y
CONFIG_UEFI_CPER_X86=y
CONFIG_EFI_DEV_PATH_PARSER=y
CONFIG_EFI_EARLYCON=y

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_IRQFD=y
CONFIG_HAVE_KVM_IRQ_ROUTING=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM_MMIO=y
CONFIG_KVM_ASYNC_PF=y
CONFIG_HAVE_KVM_MSI=y
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=y
CONFIG_KVM_VFIO=y
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=y
CONFIG_KVM_COMPAT=y
CONFIG_HAVE_KVM_IRQ_BYPASS=y
CONFIG_HAVE_KVM_NO_POLL=y
CONFIG_VIRTUALIZATION=y
CONFIG_KVM=m
CONFIG_KVM_INTEL=m
CONFIG_KVM_AMD=m
CONFIG_KVM_AMD_SEV=y
CONFIG_KVM_MMU_AUDIT=y
CONFIG_VHOST_NET=m
# CONFIG_VHOST_SCSI is not set
CONFIG_VHOST_VSOCK=m
CONFIG_VHOST=m
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_HOTPLUG_SMT=y
CONFIG_OPROFILE=m
CONFIG_OPROFILE_EVENT_MULTIPLEX=y
CONFIG_HAVE_OPROFILE=y
CONFIG_OPROFILE_NMI_TIMER=y
CONFIG_KPROBES=y
CONFIG_JUMP_LABEL=y
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_UPROBES=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_HAVE_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP_FILTER=y
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
CONFIG_STACKPROTECTOR=y
CONFIG_STACKPROTECTOR_STRONG=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
CONFIG_HAVE_COPY_THREAD_TLS=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_COMPAT_OLD_SIGACTION=y
CONFIG_64BIT_TIME=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_ARCH_HAS_REFCOUNT=y
# CONFIG_REFCOUNT_FULL is not set
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
CONFIG_ARCH_USE_MEMREMAP_PROT=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC="g++"
CONFIG_HAVE_GCC_PLUGINS=y
CONFIG_GCC_PLUGINS=y

#
# GCC plugins
#
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of GCC plugins
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULE_SIG_FORMAT=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_LOAD=y
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
CONFIG_MODULE_SIG=y
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=y
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
CONFIG_MODULE_SIG_SHA256=y
# CONFIG_MODULE_SIG_SHA384 is not set
# CONFIG_MODULE_SIG_SHA512 is not set
CONFIG_MODULE_SIG_HASH="sha256"
# CONFIG_MODULE_COMPRESS is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_TRIM_UNUSED_KSYMS is not set
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLK_SCSI_REQUEST=y
CONFIG_BLK_DEV_BSG=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_ZONED=y
CONFIG_BLK_DEV_THROTTLING=y
# CONFIG_BLK_DEV_THROTTLING_LOW is not set
# CONFIG_BLK_CMDLINE_PARSER is not set
# CONFIG_BLK_WBT is not set
# CONFIG_BLK_CGROUP_IOLATENCY is not set
# CONFIG_BLK_CGROUP_IOCOST is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
CONFIG_OSF_PARTITION=y
CONFIG_AMIGA_PARTITION=y
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
CONFIG_SUN_PARTITION=y
CONFIG_KARMA_PARTITION=y
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=y
CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLK_PM=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
CONFIG_MQ_IOSCHED_KYBER=y
# CONFIG_IOSCHED_BFQ is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=y
CONFIG_PADATA=y
CONFIG_ASN1=y
CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
CONFIG_INLINE_READ_UNLOCK=y
CONFIG_INLINE_READ_UNLOCK_IRQ=y
CONFIG_INLINE_WRITE_UNLOCK=y
CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_MUTEX_SPIN_ON_OWNER=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_COMPAT_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
CONFIG_BINFMT_MISC=m
CONFIG_COREDUMP=y
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SPARSEMEM_MANUAL=y
CONFIG_SPARSEMEM=y
CONFIG_NEED_MULTIPLE_NODES=y
CONFIG_HAVE_MEMORY_PRESENT=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_MEMORY_ISOLATION=y
CONFIG_HAVE_BOOTMEM_INFO_NODE=y
CONFIG_MEMORY_HOTPLUG=y
CONFIG_MEMORY_HOTPLUG_SPARSE=y
# CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
CONFIG_MEMORY_HOTREMOVE=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MEMORY_BALLOON=y
CONFIG_BALLOON_COMPACTION=y
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
CONFIG_CONTIG_ALLOC=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_BOUNCE=y
CONFIG_VIRT_TO_BUS=y
CONFIG_MMU_NOTIFIER=y
CONFIG_KSM=y
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
CONFIG_MEMORY_FAILURE=y
CONFIG_HWPOISON_INJECT=m
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_THP_SWAP=y
CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
CONFIG_CLEANCACHE=y
CONFIG_FRONTSWAP=y
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
CONFIG_MEM_SOFT_DIRTY=y
CONFIG_ZSWAP=y
CONFIG_ZPOOL=y
CONFIG_ZBUD=y
# CONFIG_Z3FOLD is not set
CONFIG_ZSMALLOC=y
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
CONFIG_IDLE_PAGE_TRACKING=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ZONE_DEVICE=y
CONFIG_DEV_PAGEMAP_OPS=y
# CONFIG_DEVICE_PRIVATE is not set
CONFIG_FRAME_VECTOR=y
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
CONFIG_ARCH_HAS_PKEYS=y
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
# CONFIG_READ_ONLY_THP_FOR_FS is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# end of Memory Management options

CONFIG_NET=y
CONFIG_COMPAT_NETLINK_MESSAGES=y
CONFIG_NET_INGRESS=y
CONFIG_NET_EGRESS=y
CONFIG_SKB_EXTENSIONS=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_DIAG=m
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_UNIX_DIAG=m
# CONFIG_TLS is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
CONFIG_XFRM_USER=y
# CONFIG_XFRM_INTERFACE is not set
CONFIG_XFRM_SUB_POLICY=y
CONFIG_XFRM_MIGRATE=y
CONFIG_XFRM_STATISTICS=y
CONFIG_XFRM_IPCOMP=m
CONFIG_NET_KEY=m
CONFIG_NET_KEY_MIGRATE=y
# CONFIG_XDP_SOCKETS is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_TRIE_STATS=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_ROUTE_CLASSID=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE_DEMUX=m
CONFIG_NET_IP_TUNNEL=m
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_IP_MROUTE_COMMON=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MROUTE_MULTIPLE_TABLES=y
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_SYN_COOKIES=y
CONFIG_NET_IPVTI=m
CONFIG_NET_UDP_TUNNEL=m
CONFIG_NET_FOU=m
CONFIG_NET_FOU_IP_TUNNELS=y
CONFIG_INET_AH=m
CONFIG_INET_ESP=m
# CONFIG_INET_ESP_OFFLOAD is not set
CONFIG_INET_IPCOMP=m
CONFIG_INET_XFRM_TUNNEL=m
CONFIG_INET_TUNNEL=m
CONFIG_INET_DIAG=m
CONFIG_INET_TCP_DIAG=m
CONFIG_INET_UDP_DIAG=m
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_CUBIC=y
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_VEGAS=m
# CONFIG_TCP_CONG_NV is not set
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_LP=m
CONFIG_TCP_CONG_VENO=m
CONFIG_TCP_CONG_YEAH=m
CONFIG_TCP_CONG_ILLINOIS=m
CONFIG_TCP_CONG_DCTCP=m
# CONFIG_TCP_CONG_CDG is not set
# CONFIG_TCP_CONG_BBR is not set
CONFIG_DEFAULT_CUBIC=y
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG="cubic"
CONFIG_TCP_MD5SIG=y
CONFIG_IPV6=y
CONFIG_IPV6_ROUTER_PREF=y
CONFIG_IPV6_ROUTE_INFO=y
CONFIG_IPV6_OPTIMISTIC_DAD=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
# CONFIG_INET6_ESP_OFFLOAD is not set
CONFIG_INET6_IPCOMP=m
CONFIG_IPV6_MIP6=m
# CONFIG_IPV6_ILA is not set
CONFIG_INET6_XFRM_TUNNEL=m
CONFIG_INET6_TUNNEL=m
CONFIG_IPV6_VTI=m
CONFIG_IPV6_SIT=m
CONFIG_IPV6_SIT_6RD=y
CONFIG_IPV6_NDISC_NODETYPE=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IPV6_GRE=m
CONFIG_IPV6_FOU=m
CONFIG_IPV6_FOU_TUNNEL=m
CONFIG_IPV6_MULTIPLE_TABLES=y
# CONFIG_IPV6_SUBTREES is not set
CONFIG_IPV6_MROUTE=y
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=y
CONFIG_IPV6_PIMSM_V2=y
CONFIG_IPV6_SEG6_LWTUNNEL=y
# CONFIG_IPV6_SEG6_HMAC is not set
CONFIG_IPV6_SEG6_BPF=y
CONFIG_NETLABEL=y
CONFIG_NETWORK_SECMARK=y
CONFIG_NET_PTP_CLASSIFY=y
CONFIG_NETWORK_PHY_TIMESTAMPING=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_ADVANCED=y
CONFIG_BRIDGE_NETFILTER=m

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_FAMILY_BRIDGE=y
CONFIG_NETFILTER_FAMILY_ARP=y
CONFIG_NETFILTER_NETLINK_ACCT=m
CONFIG_NETFILTER_NETLINK_QUEUE=m
CONFIG_NETFILTER_NETLINK_LOG=m
CONFIG_NETFILTER_NETLINK_OSF=m
CONFIG_NF_CONNTRACK=m
CONFIG_NF_LOG_COMMON=m
# CONFIG_NF_LOG_NETDEV is not set
CONFIG_NETFILTER_CONNCOUNT=m
CONFIG_NF_CONNTRACK_MARK=y
CONFIG_NF_CONNTRACK_SECMARK=y
CONFIG_NF_CONNTRACK_ZONES=y
CONFIG_NF_CONNTRACK_PROCFS=y
CONFIG_NF_CONNTRACK_EVENTS=y
CONFIG_NF_CONNTRACK_TIMEOUT=y
CONFIG_NF_CONNTRACK_TIMESTAMP=y
CONFIG_NF_CONNTRACK_LABELS=y
CONFIG_NF_CT_PROTO_DCCP=y
CONFIG_NF_CT_PROTO_GRE=y
CONFIG_NF_CT_PROTO_SCTP=y
CONFIG_NF_CT_PROTO_UDPLITE=y
CONFIG_NF_CONNTRACK_AMANDA=m
CONFIG_NF_CONNTRACK_FTP=m
CONFIG_NF_CONNTRACK_H323=m
CONFIG_NF_CONNTRACK_IRC=m
CONFIG_NF_CONNTRACK_BROADCAST=m
CONFIG_NF_CONNTRACK_NETBIOS_NS=m
CONFIG_NF_CONNTRACK_SNMP=m
CONFIG_NF_CONNTRACK_PPTP=m
CONFIG_NF_CONNTRACK_SANE=m
CONFIG_NF_CONNTRACK_SIP=m
CONFIG_NF_CONNTRACK_TFTP=m
CONFIG_NF_CT_NETLINK=m
CONFIG_NF_CT_NETLINK_TIMEOUT=m
# CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
CONFIG_NF_NAT=m
CONFIG_NF_NAT_AMANDA=m
CONFIG_NF_NAT_FTP=m
CONFIG_NF_NAT_IRC=m
CONFIG_NF_NAT_SIP=m
CONFIG_NF_NAT_TFTP=m
CONFIG_NF_NAT_REDIRECT=y
CONFIG_NF_NAT_MASQUERADE=y
CONFIG_NETFILTER_SYNPROXY=m
CONFIG_NF_TABLES=m
# CONFIG_NF_TABLES_SET is not set
# CONFIG_NF_TABLES_INET is not set
# CONFIG_NF_TABLES_NETDEV is not set
# CONFIG_NFT_NUMGEN is not set
CONFIG_NFT_CT=m
CONFIG_NFT_COUNTER=m
# CONFIG_NFT_CONNLIMIT is not set
CONFIG_NFT_LOG=m
CONFIG_NFT_LIMIT=m
CONFIG_NFT_MASQ=m
CONFIG_NFT_REDIR=m
# CONFIG_NFT_TUNNEL is not set
# CONFIG_NFT_OBJREF is not set
CONFIG_NFT_QUEUE=m
# CONFIG_NFT_QUOTA is not set
CONFIG_NFT_REJECT=m
CONFIG_NFT_COMPAT=m
CONFIG_NFT_HASH=m
# CONFIG_NFT_XFRM is not set
# CONFIG_NFT_SOCKET is not set
# CONFIG_NFT_OSF is not set
# CONFIG_NFT_TPROXY is not set
# CONFIG_NFT_SYNPROXY is not set
# CONFIG_NF_FLOW_TABLE is not set
CONFIG_NETFILTER_XTABLES=y

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=m
CONFIG_NETFILTER_XT_CONNMARK=m
CONFIG_NETFILTER_XT_SET=m

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=m
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
CONFIG_NETFILTER_XT_TARGET_CT=m
CONFIG_NETFILTER_XT_TARGET_DSCP=m
CONFIG_NETFILTER_XT_TARGET_HL=m
CONFIG_NETFILTER_XT_TARGET_HMARK=m
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=m
CONFIG_NETFILTER_XT_TARGET_LED=m
CONFIG_NETFILTER_XT_TARGET_LOG=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_NAT=m
CONFIG_NETFILTER_XT_TARGET_NETMAP=m
CONFIG_NETFILTER_XT_TARGET_NFLOG=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_TARGET_RATEEST=m
CONFIG_NETFILTER_XT_TARGET_REDIRECT=m
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=m
CONFIG_NETFILTER_XT_TARGET_TEE=m
CONFIG_NETFILTER_XT_TARGET_TPROXY=m
CONFIG_NETFILTER_XT_TARGET_TRACE=m
CONFIG_NETFILTER_XT_TARGET_SECMARK=m
CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=m

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=m
CONFIG_NETFILTER_XT_MATCH_BPF=m
CONFIG_NETFILTER_XT_MATCH_CGROUP=m
CONFIG_NETFILTER_XT_MATCH_CLUSTER=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=m
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_CPU=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=m
CONFIG_NETFILTER_XT_MATCH_DSCP=m
CONFIG_NETFILTER_XT_MATCH_ECN=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_HL=m
# CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
CONFIG_NETFILTER_XT_MATCH_IPRANGE=m
CONFIG_NETFILTER_XT_MATCH_IPVS=m
CONFIG_NETFILTER_XT_MATCH_L2TP=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_NFACCT=m
CONFIG_NETFILTER_XT_MATCH_OSF=m
CONFIG_NETFILTER_XT_MATCH_OWNER=m
CONFIG_NETFILTER_XT_MATCH_POLICY=m
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_QUOTA=m
CONFIG_NETFILTER_XT_MATCH_RATEEST=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_RECENT=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_SOCKET=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_NETFILTER_XT_MATCH_TIME=m
CONFIG_NETFILTER_XT_MATCH_U32=m
# end of Core Netfilter Configuration

CONFIG_IP_SET=m
CONFIG_IP_SET_MAX=256
CONFIG_IP_SET_BITMAP_IP=m
CONFIG_IP_SET_BITMAP_IPMAC=m
CONFIG_IP_SET_BITMAP_PORT=m
CONFIG_IP_SET_HASH_IP=m
CONFIG_IP_SET_HASH_IPMARK=m
CONFIG_IP_SET_HASH_IPPORT=m
CONFIG_IP_SET_HASH_IPPORTIP=m
CONFIG_IP_SET_HASH_IPPORTNET=m
CONFIG_IP_SET_HASH_IPMAC=m
CONFIG_IP_SET_HASH_MAC=m
CONFIG_IP_SET_HASH_NETPORTNET=m
CONFIG_IP_SET_HASH_NET=m
CONFIG_IP_SET_HASH_NETNET=m
CONFIG_IP_SET_HASH_NETPORT=m
CONFIG_IP_SET_HASH_NETIFACE=m
CONFIG_IP_SET_LIST_SET=m
CONFIG_IP_VS=m
CONFIG_IP_VS_IPV6=y
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=12

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_PROTO_AH_ESP=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_SCTP=y

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_WRR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_WLC=m
# CONFIG_IP_VS_FO is not set
# CONFIG_IP_VS_OVF is not set
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_SH=m
# CONFIG_IP_VS_MH is not set
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_NQ=m

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_NFCT=y
CONFIG_IP_VS_PE_SIP=m

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=m
CONFIG_NF_SOCKET_IPV4=m
CONFIG_NF_TPROXY_IPV4=m
# CONFIG_NF_TABLES_IPV4 is not set
# CONFIG_NF_TABLES_ARP is not set
CONFIG_NF_DUP_IPV4=m
# CONFIG_NF_LOG_ARP is not set
CONFIG_NF_LOG_IPV4=m
CONFIG_NF_REJECT_IPV4=m
CONFIG_NF_NAT_SNMP_BASIC=m
CONFIG_NF_NAT_PPTP=m
CONFIG_NF_NAT_H323=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_RPFILTER=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SYNPROXY=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_SECURITY=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=m
CONFIG_NF_TPROXY_IPV6=m
# CONFIG_NF_TABLES_IPV6 is not set
CONFIG_NF_DUP_IPV6=m
CONFIG_NF_REJECT_IPV6=m
CONFIG_NF_LOG_IPV6=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MATCH_AH=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_MH=m
CONFIG_IP6_NF_MATCH_RPFILTER=m
CONFIG_IP6_NF_MATCH_RT=m
# CONFIG_IP6_NF_MATCH_SRH is not set
CONFIG_IP6_NF_TARGET_HL=m
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IP6_NF_TARGET_SYNPROXY=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_SECURITY=m
CONFIG_IP6_NF_NAT=m
CONFIG_IP6_NF_TARGET_MASQUERADE=m
CONFIG_IP6_NF_TARGET_NPT=m
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=m
# CONFIG_NF_TABLES_BRIDGE is not set
# CONFIG_NF_CONNTRACK_BRIDGE is not set
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_IP6=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_NFLOG=m
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=m
CONFIG_INET_DCCP_DIAG=m

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=y
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=y
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=m
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=y
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=y
CONFIG_SCTP_COOKIE_HMAC_SHA1=y
CONFIG_INET_SCTP_DIAG=m
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
CONFIG_ATM=m
CONFIG_ATM_CLIP=m
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=m
# CONFIG_ATM_MPOA is not set
CONFIG_ATM_BR2684=m
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=m
CONFIG_L2TP_DEBUGFS=m
CONFIG_L2TP_V3=y
CONFIG_L2TP_IP=m
CONFIG_L2TP_ETH=m
CONFIG_STP=m
CONFIG_GARP=m
CONFIG_MRP=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_IGMP_SNOOPING=y
CONFIG_BRIDGE_VLAN_FILTERING=y
CONFIG_HAVE_NET_DSA=y
# CONFIG_NET_DSA is not set
CONFIG_VLAN_8021Q=m
CONFIG_VLAN_8021Q_GVRP=y
CONFIG_VLAN_8021Q_MVRP=y
# CONFIG_DECNET is not set
CONFIG_LLC=m
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
CONFIG_6LOWPAN=m
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=m
CONFIG_6LOWPAN_NHC_DEST=m
CONFIG_6LOWPAN_NHC_FRAGMENT=m
CONFIG_6LOWPAN_NHC_HOP=m
CONFIG_6LOWPAN_NHC_IPV6=m
CONFIG_6LOWPAN_NHC_MOBILITY=m
CONFIG_6LOWPAN_NHC_ROUTING=m
CONFIG_6LOWPAN_NHC_UDP=m
# CONFIG_6LOWPAN_GHC_EXT_HDR_HOP is not set
# CONFIG_6LOWPAN_GHC_UDP is not set
# CONFIG_6LOWPAN_GHC_ICMPV6 is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_DEST is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG is not set
# CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE is not set
CONFIG_IEEE802154=m
# CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
CONFIG_IEEE802154_SOCKET=m
CONFIG_IEEE802154_6LOWPAN=m
CONFIG_MAC802154=m
CONFIG_NET_SCHED=y

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_ATM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_MULTIQ=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFB=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_SCH_TBF=m
# CONFIG_NET_SCH_CBS is not set
# CONFIG_NET_SCH_ETF is not set
# CONFIG_NET_SCH_TAPRIO is not set
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_DRR=m
CONFIG_NET_SCH_MQPRIO=m
# CONFIG_NET_SCH_SKBPRIO is not set
CONFIG_NET_SCH_CHOKE=m
CONFIG_NET_SCH_QFQ=m
CONFIG_NET_SCH_CODEL=m
CONFIG_NET_SCH_FQ_CODEL=m
# CONFIG_NET_SCH_CAKE is not set
CONFIG_NET_SCH_FQ=m
# CONFIG_NET_SCH_HHF is not set
# CONFIG_NET_SCH_PIE is not set
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_PLUG=m
# CONFIG_NET_SCH_DEFAULT is not set

#
# Classification
#
CONFIG_NET_CLS=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_U32=m
CONFIG_CLS_U32_PERF=y
CONFIG_CLS_U32_MARK=y
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_FLOW=m
CONFIG_NET_CLS_CGROUP=y
CONFIG_NET_CLS_BPF=m
CONFIG_NET_CLS_FLOWER=m
CONFIG_NET_CLS_MATCHALL=m
CONFIG_NET_EMATCH=y
CONFIG_NET_EMATCH_STACK=32
CONFIG_NET_EMATCH_CMP=m
CONFIG_NET_EMATCH_NBYTE=m
CONFIG_NET_EMATCH_U32=m
CONFIG_NET_EMATCH_META=m
CONFIG_NET_EMATCH_TEXT=m
# CONFIG_NET_EMATCH_CANID is not set
CONFIG_NET_EMATCH_IPSET=m
# CONFIG_NET_EMATCH_IPT is not set
CONFIG_NET_CLS_ACT=y
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_GACT=m
CONFIG_GACT_PROB=y
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_SAMPLE=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_NAT=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_ACT_SKBEDIT=m
CONFIG_NET_ACT_CSUM=m
# CONFIG_NET_ACT_MPLS is not set
CONFIG_NET_ACT_VLAN=m
# CONFIG_NET_ACT_BPF is not set
CONFIG_NET_ACT_CONNMARK=m
# CONFIG_NET_ACT_CTINFO is not set
CONFIG_NET_ACT_SKBMOD=m
# CONFIG_NET_ACT_IFE is not set
CONFIG_NET_ACT_TUNNEL_KEY=m
# CONFIG_NET_ACT_CT is not set
# CONFIG_NET_TC_SKB_EXT is not set
CONFIG_NET_SCH_FIFO=y
CONFIG_DCB=y
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
CONFIG_OPENVSWITCH=m
CONFIG_OPENVSWITCH_GRE=m
CONFIG_OPENVSWITCH_VXLAN=m
CONFIG_OPENVSWITCH_GENEVE=m
CONFIG_VSOCKETS=m
CONFIG_VSOCKETS_DIAG=m
CONFIG_VMWARE_VMCI_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS=m
CONFIG_VIRTIO_VSOCKETS_COMMON=m
CONFIG_HYPERV_VSOCKETS=m
CONFIG_NETLINK_DIAG=m
CONFIG_MPLS=y
CONFIG_NET_MPLS_GSO=y
CONFIG_MPLS_ROUTING=m
CONFIG_MPLS_IPTUNNEL=m
CONFIG_NET_NSH=m
# CONFIG_HSR is not set
CONFIG_NET_SWITCHDEV=y
CONFIG_NET_L3_MASTER_DEV=y
# CONFIG_NET_NCSI is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
CONFIG_CGROUP_NET_CLASSID=y
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
CONFIG_BPF_JIT=y
CONFIG_BPF_STREAM_PARSER=y
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
CONFIG_NET_PKTGEN=m
CONFIG_NET_DROP_MONITOR=y
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
CONFIG_CAN=m
CONFIG_CAN_RAW=m
CONFIG_CAN_BCM=m
CONFIG_CAN_GW=m
# CONFIG_CAN_J1939 is not set

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=m
# CONFIG_CAN_VXCAN is not set
CONFIG_CAN_SLCAN=m
CONFIG_CAN_DEV=m
CONFIG_CAN_CALC_BITTIMING=y
# CONFIG_CAN_KVASER_PCIEFD is not set
CONFIG_CAN_C_CAN=m
CONFIG_CAN_C_CAN_PLATFORM=m
CONFIG_CAN_C_CAN_PCI=m
CONFIG_CAN_CC770=m
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=m
# CONFIG_CAN_IFI_CANFD is not set
# CONFIG_CAN_M_CAN is not set
# CONFIG_CAN_PEAK_PCIEFD is not set
CONFIG_CAN_SJA1000=m
CONFIG_CAN_EMS_PCI=m
# CONFIG_CAN_F81601 is not set
CONFIG_CAN_KVASER_PCI=m
CONFIG_CAN_PEAK_PCI=m
CONFIG_CAN_PEAK_PCIEC=y
CONFIG_CAN_PLX_PCI=m
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=m
CONFIG_CAN_SOFTING=m

#
# CAN SPI interfaces
#
# CONFIG_CAN_HI311X is not set
# CONFIG_CAN_MCP251X is not set
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=m
CONFIG_CAN_EMS_USB=m
CONFIG_CAN_ESD_USB2=m
# CONFIG_CAN_GS_USB is not set
CONFIG_CAN_KVASER_USB=m
# CONFIG_CAN_MCBA_USB is not set
CONFIG_CAN_PEAK_USB=m
# CONFIG_CAN_UCAN is not set
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=m
CONFIG_BT_BREDR=y
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_CMTP=m
CONFIG_BT_HIDP=m
CONFIG_BT_HS=y
CONFIG_BT_LE=y
# CONFIG_BT_6LOWPAN is not set
# CONFIG_BT_LEDS is not set
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=y

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=m
CONFIG_BT_BCM=m
CONFIG_BT_RTL=m
CONFIG_BT_HCIBTUSB=m
# CONFIG_BT_HCIBTUSB_AUTOSUSPEND is not set
CONFIG_BT_HCIBTUSB_BCM=y
# CONFIG_BT_HCIBTUSB_MTK is not set
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_ATH3K=y
# CONFIG_BT_HCIUART_INTEL is not set
# CONFIG_BT_HCIUART_AG6XX is not set
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIVHCI=m
CONFIG_BT_MRVL=m
CONFIG_BT_MRVL_SDIO=m
CONFIG_BT_ATH3K=m
# CONFIG_BT_MTKSDIO is not set
# end of Bluetooth device drivers

# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
CONFIG_STREAM_PARSER=y
CONFIG_FIB_RULES=y
CONFIG_WIRELESS=y
CONFIG_WIRELESS_EXT=y
CONFIG_WEXT_CORE=y
CONFIG_WEXT_PROC=y
CONFIG_WEXT_PRIV=y
CONFIG_CFG80211=m
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=y
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=y
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
CONFIG_CFG80211_CRDA_SUPPORT=y
CONFIG_CFG80211_WEXT=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=m
CONFIG_MAC80211_HAS_RC=y
CONFIG_MAC80211_RC_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=y
CONFIG_MAC80211_RC_DEFAULT="minstrel_ht"
CONFIG_MAC80211_MESH=y
CONFIG_MAC80211_LEDS=y
CONFIG_MAC80211_DEBUGFS=y
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
CONFIG_RFKILL=m
CONFIG_RFKILL_LEDS=y
CONFIG_RFKILL_INPUT=y
# CONFIG_RFKILL_GPIO is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_XEN is not set
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_NFC is not set
CONFIG_PSAMPLE=m
# CONFIG_NET_IFE is not set
CONFIG_LWTUNNEL=y
CONFIG_LWTUNNEL_BPF=y
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_NET_SOCK_MSG=y
CONFIG_NET_DEVLINK=y
CONFIG_PAGE_POOL=y
CONFIG_FAILOVER=m
CONFIG_HAVE_EBPF_JIT=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=y
CONFIG_PCIEAER=y
CONFIG_PCIEAER_INJECT=m
CONFIG_PCIE_ECRC=y
CONFIG_PCIEASPM=y
# CONFIG_PCIEASPM_DEBUG is not set
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=y
# CONFIG_PCIE_DPC is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=y
CONFIG_PCI_MSI_IRQ_DOMAIN=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
CONFIG_PCI_STUB=y
# CONFIG_PCI_PF_STUB is not set
# CONFIG_XEN_PCIDEV_FRONTEND is not set
CONFIG_PCI_ATS=y
CONFIG_PCI_LOCKLESS_CONFIG=y
CONFIG_PCI_IOV=y
CONFIG_PCI_PRI=y
CONFIG_PCI_PASID=y
# CONFIG_PCI_P2PDMA is not set
CONFIG_PCI_LABEL=y
CONFIG_PCI_HYPERV=m
CONFIG_HOTPLUG_PCI=y
CONFIG_HOTPLUG_PCI_ACPI=y
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
CONFIG_HOTPLUG_PCI_SHPC=y

#
# PCI controller drivers
#

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support

CONFIG_VMD=y
CONFIG_PCI_HYPERV_INTERFACE=m

#
# DesignWare PCI Core Support
#
# CONFIG_PCIE_DW_PLAT_HOST is not set
# CONFIG_PCI_MESON is not set
# end of DesignWare PCI Core Support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

CONFIG_PCCARD=y
# CONFIG_PCMCIA is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
CONFIG_YENTA=m
CONFIG_YENTA_O2=y
CONFIG_YENTA_RICOH=y
CONFIG_YENTA_TI=y
CONFIG_YENTA_ENE_TUNE=y
CONFIG_YENTA_TOSHIBA=y
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH=""
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y

#
# Firmware loader
#
CONFIG_FW_LOADER=y
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
# CONFIG_FW_LOADER_COMPRESS is not set
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=y
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
# end of Bus devices

CONFIG_CONNECTOR=y
CONFIG_PROC_EVENTS=y
# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
# CONFIG_MTD_AR7_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
CONFIG_MTD_BLOCK=m
# CONFIG_MTD_BLOCK_RO is not set
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
# CONFIG_SM_FTL is not set
# CONFIG_MTD_OOPS is not set
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
# CONFIG_MTD_CFI is not set
# CONFIG_MTD_JEDECPROBE is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_RAM is not set
# CONFIG_MTD_ROM is not set
# CONFIG_MTD_ABSENT is not set
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
# CONFIG_MTD_COMPLEX_MAPPINGS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
# CONFIG_MTD_DATAFLASH is not set
# CONFIG_MTD_MCHP23K256 is not set
# CONFIG_MTD_SST25L is not set
# CONFIG_MTD_SLRAM is not set
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
# CONFIG_MTD_BLOCK2MTD is not set

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

# CONFIG_MTD_ONENAND is not set
# CONFIG_MTD_RAW_NAND is not set
# CONFIG_MTD_SPI_NAND is not set

#
# LPDDR & LPDDR2 PCM memory drivers
#
# CONFIG_MTD_LPDDR is not set
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_SPI_NOR is not set
CONFIG_MTD_UBI=m
CONFIG_MTD_UBI_WL_THRESHOLD=4096
CONFIG_MTD_UBI_BEB_LIMIT=20
# CONFIG_MTD_UBI_FASTMAP is not set
# CONFIG_MTD_UBI_GLUEBI is not set
# CONFIG_MTD_UBI_BLOCK is not set
# CONFIG_MTD_HYPERBUS is not set
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_SERIAL=m
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_AX88796 is not set
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
# CONFIG_PNP_DEBUG_MESSAGES is not set

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=m
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
CONFIG_BLK_DEV_FD=m
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=m
# CONFIG_ZRAM is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_LOOP_MIN_COUNT=0
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
CONFIG_BLK_DEV_NBD=m
# CONFIG_BLK_DEV_SKD is not set
CONFIG_BLK_DEV_SX8=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=m
CONFIG_XEN_BLKDEV_FRONTEND=m
CONFIG_VIRTIO_BLK=y
# CONFIG_VIRTIO_BLK_SCSI is not set
CONFIG_BLK_DEV_RBD=m
# CONFIG_BLK_DEV_RSXX is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_MULTIPATH=y
CONFIG_NVME_FABRICS=m
CONFIG_NVME_FC=m
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
CONFIG_TIFM_CORE=m
CONFIG_TIFM_7XX1=m
# CONFIG_ICS932S401 is not set
CONFIG_ENCLOSURE_SERVICES=m
CONFIG_SGI_XP=m
CONFIG_HP_ILO=m
CONFIG_SGI_GRU=m
# CONFIG_SGI_GRU_DEBUG is not set
CONFIG_APDS9802ALS=m
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
CONFIG_SENSORS_APDS990X=m
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
CONFIG_VMWARE_BALLOON=m
# CONFIG_LATTICE_ECP3_CONFIG is not set
# CONFIG_SRAM is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
# CONFIG_XILINX_SDFEC is not set
CONFIG_PVPANIC=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
CONFIG_EEPROM_93CX6=m
# CONFIG_EEPROM_93XX46 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

CONFIG_CB710_CORE=m
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=y

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m
CONFIG_ALTERA_STAPL=m
CONFIG_INTEL_MEI=m
CONFIG_INTEL_MEI_ME=m
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_INTEL_MEI_HDCP is not set
CONFIG_VMWARE_VMCI=m

#
# Intel MIC & related support
#

#
# Intel MIC Bus Driver
#
# CONFIG_INTEL_MIC_BUS is not set

#
# SCIF Bus Driver
#
# CONFIG_SCIF_BUS is not set

#
# VOP Bus Driver
#
# CONFIG_VOP_BUS is not set

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#

#
# Intel MIC Coprocessor State Management (COSM) Drivers
#

#
# VOP Driver
#
# end of Intel MIC & related support

# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_MISC_RTSX_USB is not set
# CONFIG_HABANA_AI is not set
# end of Misc devices

CONFIG_HAVE_IDE=y
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
CONFIG_RAID_ATTRS=m
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
CONFIG_SCSI_NETLINK=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_SCH=m
CONFIG_SCSI_ENCLOSURE=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_SAS_ATTRS=m
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_SCSI_SAS_ATA=y
CONFIG_SCSI_SAS_HOST_SMP=y
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=y
CONFIG_ISCSI_TCP=m
CONFIG_ISCSI_BOOT_SYSFS=m
CONFIG_SCSI_CXGB3_ISCSI=m
CONFIG_SCSI_CXGB4_ISCSI=m
CONFIG_SCSI_BNX2_ISCSI=m
CONFIG_SCSI_BNX2X_FCOE=m
CONFIG_BE2ISCSI=m
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
CONFIG_SCSI_HPSA=m
CONFIG_SCSI_3W_9XXX=m
CONFIG_SCSI_3W_SAS=m
# CONFIG_SCSI_ACARD is not set
CONFIG_SCSI_AACRAID=m
# CONFIG_SCSI_AIC7XXX is not set
CONFIG_SCSI_AIC79XX=m
CONFIG_AIC79XX_CMDS_PER_DEVICE=4
CONFIG_AIC79XX_RESET_DELAY_MS=15000
# CONFIG_AIC79XX_DEBUG_ENABLE is not set
CONFIG_AIC79XX_DEBUG_MASK=0
# CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
# CONFIG_SCSI_AIC94XX is not set
CONFIG_SCSI_MVSAS=m
# CONFIG_SCSI_MVSAS_DEBUG is not set
CONFIG_SCSI_MVSAS_TASKLET=y
CONFIG_SCSI_MVUMI=m
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
CONFIG_SCSI_ARCMSR=m
# CONFIG_SCSI_ESAS2R is not set
# CONFIG_MEGARAID_NEWGEN is not set
# CONFIG_MEGARAID_LEGACY is not set
CONFIG_MEGARAID_SAS=m
CONFIG_SCSI_MPT3SAS=m
CONFIG_SCSI_MPT2SAS_MAX_SGE=128
CONFIG_SCSI_MPT3SAS_MAX_SGE=128
CONFIG_SCSI_MPT2SAS=m
# CONFIG_SCSI_SMARTPQI is not set
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFSHCD_PCI=m
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_SCSI_UFS_BSG is not set
CONFIG_SCSI_HPTIOP=m
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_MYRB is not set
# CONFIG_SCSI_MYRS is not set
CONFIG_VMWARE_PVSCSI=m
# CONFIG_XEN_SCSI_FRONTEND is not set
CONFIG_HYPERV_STORAGE=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_FCOE=m
CONFIG_FCOE_FNIC=m
# CONFIG_SCSI_SNIC is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_FDOMAIN_PCI is not set
# CONFIG_SCSI_GDTH is not set
CONFIG_SCSI_ISCI=m
# CONFIG_SCSI_IPS is not set
CONFIG_SCSI_INITIO=m
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_STEX=m
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_IPR is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
CONFIG_SCSI_QLA_FC=m
CONFIG_TCM_QLA2XXX=m
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=m
# CONFIG_QEDI is not set
# CONFIG_QEDF is not set
# CONFIG_SCSI_LPFC is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_WD719X is not set
CONFIG_SCSI_DEBUG=m
CONFIG_SCSI_PMCRAID=m
CONFIG_SCSI_PM8001=m
# CONFIG_SCSI_BFA_FC is not set
CONFIG_SCSI_VIRTIO=m
# CONFIG_SCSI_CHELSIO_FCOE is not set
CONFIG_SCSI_DH=y
CONFIG_SCSI_DH_RDAC=y
CONFIG_SCSI_DH_HP_SW=y
CONFIG_SCSI_DH_EMC=y
CONFIG_SCSI_DH_ALUA=y
# end of SCSI device support

CONFIG_ATA=m
CONFIG_ATA_VERBOSE_ERROR=y
CONFIG_ATA_ACPI=y
# CONFIG_SATA_ZPODD is not set
CONFIG_SATA_PMP=y

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=m
CONFIG_SATA_MOBILE_LPM_POLICY=0
CONFIG_SATA_AHCI_PLATFORM=m
# CONFIG_SATA_INIC162X is not set
CONFIG_SATA_ACARD_AHCI=m
CONFIG_SATA_SIL24=m
CONFIG_ATA_SFF=y

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=m
CONFIG_SATA_QSTOR=m
CONFIG_SATA_SX4=m
CONFIG_ATA_BMDMA=y

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=m
# CONFIG_SATA_DWC is not set
CONFIG_SATA_MV=m
CONFIG_SATA_NV=m
CONFIG_SATA_PROMISE=m
CONFIG_SATA_SIL=m
CONFIG_SATA_SIS=m
CONFIG_SATA_SVW=m
CONFIG_SATA_ULI=m
CONFIG_SATA_VIA=m
CONFIG_SATA_VITESSE=m

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=m
CONFIG_PATA_AMD=m
CONFIG_PATA_ARTOP=m
CONFIG_PATA_ATIIXP=m
CONFIG_PATA_ATP867X=m
CONFIG_PATA_CMD64X=m
# CONFIG_PATA_CYPRESS is not set
# CONFIG_PATA_EFAR is not set
CONFIG_PATA_HPT366=m
CONFIG_PATA_HPT37X=m
CONFIG_PATA_HPT3X2N=m
CONFIG_PATA_HPT3X3=m
# CONFIG_PATA_HPT3X3_DMA is not set
CONFIG_PATA_IT8213=m
CONFIG_PATA_IT821X=m
CONFIG_PATA_JMICRON=m
CONFIG_PATA_MARVELL=m
CONFIG_PATA_NETCELL=m
CONFIG_PATA_NINJA32=m
# CONFIG_PATA_NS87415 is not set
CONFIG_PATA_OLDPIIX=m
# CONFIG_PATA_OPTIDMA is not set
CONFIG_PATA_PDC2027X=m
CONFIG_PATA_PDC_OLD=m
# CONFIG_PATA_RADISYS is not set
CONFIG_PATA_RDC=m
CONFIG_PATA_SCH=m
CONFIG_PATA_SERVERWORKS=m
CONFIG_PATA_SIL680=m
CONFIG_PATA_SIS=m
CONFIG_PATA_TOSHIBA=m
# CONFIG_PATA_TRIFLEX is not set
CONFIG_PATA_VIA=m
# CONFIG_PATA_WINBOND is not set

#
# PIO-only SFF controllers
#
# CONFIG_PATA_CMD640_PCI is not set
# CONFIG_PATA_MPIIX is not set
# CONFIG_PATA_NS87410 is not set
# CONFIG_PATA_OPTI is not set
# CONFIG_PATA_PLATFORM is not set
# CONFIG_PATA_RZ1000 is not set

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=m
CONFIG_ATA_GENERIC=m
# CONFIG_PATA_LEGACY is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_AUTODETECT=y
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
CONFIG_MD_FAULTY=m
# CONFIG_MD_CLUSTER is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
CONFIG_DM_DEBUG=y
CONFIG_DM_BUFIO=m
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
CONFIG_DM_CACHE_SMQ=m
# CONFIG_DM_WRITECACHE is not set
CONFIG_DM_ERA=m
# CONFIG_DM_CLONE is not set
CONFIG_DM_MIRROR=m
CONFIG_DM_LOG_USERSPACE=m
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
CONFIG_DM_MULTIPATH_QL=m
CONFIG_DM_MULTIPATH_ST=m
CONFIG_DM_DELAY=m
# CONFIG_DM_DUST is not set
CONFIG_DM_UEVENT=y
CONFIG_DM_FLAKEY=m
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
CONFIG_DM_SWITCH=m
CONFIG_DM_LOG_WRITES=m
# CONFIG_DM_INTEGRITY is not set
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=m
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=m
CONFIG_TCM_PSCSI=m
CONFIG_TCM_USER2=m
CONFIG_LOOPBACK_TARGET=m
CONFIG_TCM_FC=m
CONFIG_ISCSI_TARGET=m
CONFIG_ISCSI_TARGET_CXGB4=m
# CONFIG_SBP_TARGET is not set
CONFIG_FUSION=y
CONFIG_FUSION_SPI=m
# CONFIG_FUSION_FC is not set
CONFIG_FUSION_SAS=m
CONFIG_FUSION_MAX_SGE=128
CONFIG_FUSION_CTL=m
CONFIG_FUSION_LOGGING=y

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=m
CONFIG_FIREWIRE_OHCI=m
CONFIG_FIREWIRE_SBP2=m
CONFIG_FIREWIRE_NET=m
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=y
CONFIG_MAC_EMUMOUSEBTN=y
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
CONFIG_BONDING=m
CONFIG_DUMMY=m
# CONFIG_EQUALIZER is not set
CONFIG_NET_FC=y
CONFIG_IFB=m
CONFIG_NET_TEAM=m
CONFIG_NET_TEAM_MODE_BROADCAST=m
CONFIG_NET_TEAM_MODE_ROUNDROBIN=m
CONFIG_NET_TEAM_MODE_RANDOM=m
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=m
CONFIG_NET_TEAM_MODE_LOADBALANCE=m
CONFIG_MACVLAN=m
CONFIG_MACVTAP=m
# CONFIG_IPVLAN is not set
CONFIG_VXLAN=m
CONFIG_GENEVE=m
# CONFIG_GTP is not set
CONFIG_MACSEC=y
CONFIG_NETCONSOLE=m
CONFIG_NETCONSOLE_DYNAMIC=y
CONFIG_NETPOLL=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NTB_NETDEV=m
CONFIG_TUN=m
CONFIG_TAP=m
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=m
CONFIG_VIRTIO_NET=m
CONFIG_NLMON=m
CONFIG_NET_VRF=y
CONFIG_VSOCKMON=m
# CONFIG_ARCNET is not set
# CONFIG_ATM_DRIVERS is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=y
CONFIG_MDIO=y
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_NET_VENDOR_ADAPTEC is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
# CONFIG_NET_VENDOR_ALTEON is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
CONFIG_ENA_ETHERNET=m
CONFIG_NET_VENDOR_AMD=y
CONFIG_AMD8111_ETH=m
CONFIG_PCNET32=m
CONFIG_AMD_XGBE=m
# CONFIG_AMD_XGBE_DCB is not set
CONFIG_AMD_XGBE_HAVE_ECC=y
CONFIG_NET_VENDOR_AQUANTIA=y
CONFIG_AQTION=m
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ATHEROS=y
CONFIG_ATL2=m
CONFIG_ATL1=m
CONFIG_ATL1E=m
CONFIG_ATL1C=m
CONFIG_ALX=m
CONFIG_NET_VENDOR_AURORA=y
# CONFIG_AURORA_NB8800 is not set
CONFIG_NET_VENDOR_BROADCOM=y
CONFIG_B44=m
CONFIG_B44_PCI_AUTOSELECT=y
CONFIG_B44_PCICORE_AUTOSELECT=y
CONFIG_B44_PCI=y
# CONFIG_BCMGENET is not set
CONFIG_BNX2=m
CONFIG_CNIC=m
CONFIG_TIGON3=y
CONFIG_TIGON3_HWMON=y
CONFIG_BNX2X=m
CONFIG_BNX2X_SRIOV=y
# CONFIG_SYSTEMPORT is not set
CONFIG_BNXT=m
CONFIG_BNXT_SRIOV=y
CONFIG_BNXT_FLOWER_OFFLOAD=y
CONFIG_BNXT_DCB=y
CONFIG_BNXT_HWMON=y
CONFIG_NET_VENDOR_BROCADE=y
CONFIG_BNA=m
CONFIG_NET_VENDOR_CADENCE=y
CONFIG_MACB=m
CONFIG_MACB_USE_HWSTAMP=y
# CONFIG_MACB_PCI is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
CONFIG_CAVIUM_PTP=y
CONFIG_LIQUIDIO=m
CONFIG_LIQUIDIO_VF=m
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
CONFIG_CHELSIO_T3=m
CONFIG_CHELSIO_T4=m
# CONFIG_CHELSIO_T4_DCB is not set
CONFIG_CHELSIO_T4VF=m
CONFIG_CHELSIO_LIB=m
CONFIG_NET_VENDOR_CISCO=y
CONFIG_ENIC=m
CONFIG_NET_VENDOR_CORTINA=y
# CONFIG_CX_ECAT is not set
CONFIG_DNET=m
CONFIG_NET_VENDOR_DEC=y
CONFIG_NET_TULIP=y
CONFIG_DE2104X=m
CONFIG_DE2104X_DSL=0
CONFIG_TULIP=y
# CONFIG_TULIP_MWI is not set
CONFIG_TULIP_MMIO=y
# CONFIG_TULIP_NAPI is not set
CONFIG_DE4X5=m
CONFIG_WINBOND_840=m
CONFIG_DM9102=m
CONFIG_ULI526X=m
CONFIG_PCMCIA_XIRCOM=m
# CONFIG_NET_VENDOR_DLINK is not set
CONFIG_NET_VENDOR_EMULEX=y
CONFIG_BE2NET=m
CONFIG_BE2NET_HWMON=y
CONFIG_BE2NET_BE2=y
CONFIG_BE2NET_BE3=y
CONFIG_BE2NET_LANCER=y
CONFIG_BE2NET_SKYHAWK=y
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_GOOGLE=y
# CONFIG_GVE is not set
# CONFIG_NET_VENDOR_HP is not set
CONFIG_NET_VENDOR_HUAWEI=y
# CONFIG_HINIC is not set
# CONFIG_NET_VENDOR_I825XX is not set
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
CONFIG_E1000E=y
CONFIG_E1000E_HWTS=y
CONFIG_IGB=y
CONFIG_IGB_HWMON=y
CONFIG_IGBVF=m
# CONFIG_IXGB is not set
CONFIG_IXGBE=y
CONFIG_IXGBE_HWMON=y
CONFIG_IXGBE_DCB=y
CONFIG_IXGBEVF=m
CONFIG_I40E=y
CONFIG_I40E_DCB=y
CONFIG_IAVF=m
CONFIG_I40EVF=m
# CONFIG_ICE is not set
CONFIG_FM10K=m
# CONFIG_IGC is not set
CONFIG_JME=m
CONFIG_NET_VENDOR_MARVELL=y
CONFIG_MVMDIO=m
CONFIG_SKGE=y
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=y
CONFIG_SKY2=m
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=y
CONFIG_MLX4_EN=m
CONFIG_MLX4_EN_DCB=y
CONFIG_MLX4_CORE=m
CONFIG_MLX4_DEBUG=y
CONFIG_MLX4_CORE_GEN2=y
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
# CONFIG_NET_VENDOR_MICREL is not set
# CONFIG_NET_VENDOR_MICROCHIP is not set
CONFIG_NET_VENDOR_MICROSEMI=y
# CONFIG_MSCC_OCELOT_SWITCH is not set
CONFIG_NET_VENDOR_MYRI=y
CONFIG_MYRI10GE=m
CONFIG_MYRI10GE_DCA=y
# CONFIG_FEALNX is not set
# CONFIG_NET_VENDOR_NATSEMI is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NFP=m
CONFIG_NFP_APP_FLOWER=y
CONFIG_NFP_APP_ABM_NIC=y
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
# CONFIG_NET_VENDOR_NVIDIA is not set
CONFIG_NET_VENDOR_OKI=y
CONFIG_ETHOC=m
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
CONFIG_YELLOWFIN=m
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
CONFIG_QLA3XXX=m
CONFIG_QLCNIC=m
CONFIG_QLCNIC_SRIOV=y
CONFIG_QLCNIC_DCB=y
CONFIG_QLCNIC_HWMON=y
CONFIG_NETXEN_NIC=m
CONFIG_QED=m
CONFIG_QED_SRIOV=y
CONFIG_QEDE=m
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
# CONFIG_NET_VENDOR_RDC is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
CONFIG_8139CP=y
CONFIG_8139TOO=y
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
CONFIG_8139TOO_8129=y
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=y
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_ROCKER=m
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
# CONFIG_NET_VENDOR_SEEQ is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
CONFIG_SFC=m
CONFIG_SFC_MTD=y
CONFIG_SFC_MCDI_MON=y
CONFIG_SFC_SRIOV=y
CONFIG_SFC_MCDI_LOGGING=y
CONFIG_SFC_FALCON=m
CONFIG_SFC_FALCON_MTD=y
# CONFIG_NET_VENDOR_SILAN is not set
# CONFIG_NET_VENDOR_SIS is not set
CONFIG_NET_VENDOR_SMSC=y
CONFIG_EPIC100=m
# CONFIG_SMSC911X is not set
CONFIG_SMSC9420=m
CONFIG_NET_VENDOR_SOCIONEXT=y
# CONFIG_NET_VENDOR_STMICRO is not set
# CONFIG_NET_VENDOR_SUN is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
# CONFIG_NET_VENDOR_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=m
# CONFIG_NET_VENDOR_VIA is not set
# CONFIG_NET_VENDOR_WIZNET is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
CONFIG_MDIO_DEVICE=y
CONFIG_MDIO_BUS=y
# CONFIG_MDIO_BCM_UNIMAC is not set
CONFIG_MDIO_BITBANG=m
# CONFIG_MDIO_GPIO is not set
# CONFIG_MDIO_MSCC_MIIM is not set
# CONFIG_MDIO_THUNDER is not set
CONFIG_PHYLIB=y
CONFIG_SWPHY=y
# CONFIG_LED_TRIGGER_PHY is not set

#
# MII PHY device drivers
#
# CONFIG_ADIN_PHY is not set
CONFIG_AMD_PHY=m
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AX88796B_PHY is not set
CONFIG_AT803X_PHY=m
# CONFIG_BCM7XXX_PHY is not set
CONFIG_BCM87XX_PHY=m
CONFIG_BCM_NET_PHYLIB=m
CONFIG_BROADCOM_PHY=m
CONFIG_CICADA_PHY=m
# CONFIG_CORTINA_PHY is not set
CONFIG_DAVICOM_PHY=m
# CONFIG_DP83822_PHY is not set
# CONFIG_DP83TC811_PHY is not set
# CONFIG_DP83848_PHY is not set
# CONFIG_DP83867_PHY is not set
CONFIG_FIXED_PHY=y
CONFIG_ICPLUS_PHY=m
# CONFIG_INTEL_XWAY_PHY is not set
CONFIG_LSI_ET1011C_PHY=m
CONFIG_LXT_PHY=m
CONFIG_MARVELL_PHY=m
# CONFIG_MARVELL_10G_PHY is not set
CONFIG_MICREL_PHY=m
# CONFIG_MICROCHIP_PHY is not set
# CONFIG_MICROCHIP_T1_PHY is not set
# CONFIG_MICROSEMI_PHY is not set
CONFIG_NATIONAL_PHY=m
# CONFIG_NXP_TJA11XX_PHY is not set
CONFIG_QSEMI_PHY=m
CONFIG_REALTEK_PHY=y
# CONFIG_RENESAS_PHY is not set
# CONFIG_ROCKCHIP_PHY is not set
CONFIG_SMSC_PHY=m
CONFIG_STE10XP=m
# CONFIG_TERANETICS_PHY is not set
CONFIG_VITESSE_PHY=m
# CONFIG_XILINX_GMII2RGMII is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PLIP is not set
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPPOATM=m
CONFIG_PPPOE=m
CONFIG_PPTP=m
CONFIG_PPPOL2TP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_SLIP=m
CONFIG_SLHC=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
# CONFIG_SLIP_MODE_SLIP6 is not set
CONFIG_USB_NET_DRIVERS=y
CONFIG_USB_CATC=y
CONFIG_USB_KAWETH=y
CONFIG_USB_PEGASUS=y
CONFIG_USB_RTL8150=y
CONFIG_USB_RTL8152=m
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=m
CONFIG_USB_NET_CDCETHER=y
CONFIG_USB_NET_CDC_EEM=y
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_CDC_MBIM=m
CONFIG_USB_NET_DM9601=y
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
CONFIG_USB_NET_GL620A=y
CONFIG_USB_NET_NET1080=y
CONFIG_USB_NET_PLUSB=y
CONFIG_USB_NET_MCS7830=y
CONFIG_USB_NET_RNDIS_HOST=y
CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
CONFIG_USB_NET_CDC_SUBSET=y
CONFIG_USB_ALI_M5632=y
CONFIG_USB_AN2720=y
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
CONFIG_USB_EPSON2888=y
CONFIG_USB_KC2190=y
CONFIG_USB_NET_ZAURUS=y
CONFIG_USB_NET_CX82310_ETH=m
CONFIG_USB_NET_KALMIA=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_HSO=m
CONFIG_USB_NET_INT51X1=y
CONFIG_USB_IPHETH=y
CONFIG_USB_SIERRA_NET=y
CONFIG_USB_VL600=m
# CONFIG_USB_NET_CH9200 is not set
# CONFIG_USB_NET_AQC111 is not set
CONFIG_WLAN=y
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=y
# CONFIG_ADM8211 is not set
CONFIG_ATH_COMMON=m
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_ATH9K_HW=m
CONFIG_ATH9K_COMMON=m
CONFIG_ATH9K_BTCOEX_SUPPORT=y
# CONFIG_ATH9K is not set
CONFIG_ATH9K_HTC=m
# CONFIG_ATH9K_HTC_DEBUGFS is not set
# CONFIG_CARL9170 is not set
# CONFIG_ATH6KL is not set
# CONFIG_AR5523 is not set
# CONFIG_WIL6210 is not set
# CONFIG_ATH10K is not set
# CONFIG_WCN36XX is not set
CONFIG_WLAN_VENDOR_ATMEL=y
# CONFIG_ATMEL is not set
# CONFIG_AT76C50X_USB is not set
CONFIG_WLAN_VENDOR_BROADCOM=y
# CONFIG_B43 is not set
# CONFIG_B43LEGACY is not set
# CONFIG_BRCMSMAC is not set
# CONFIG_BRCMFMAC is not set
CONFIG_WLAN_VENDOR_CISCO=y
# CONFIG_AIRO is not set
CONFIG_WLAN_VENDOR_INTEL=y
# CONFIG_IPW2100 is not set
# CONFIG_IPW2200 is not set
CONFIG_IWLEGACY=m
CONFIG_IWL4965=m
CONFIG_IWL3945=m

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=y
CONFIG_IWLEGACY_DEBUGFS=y
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=m
CONFIG_IWLWIFI_LEDS=y
CONFIG_IWLDVM=m
CONFIG_IWLMVM=m
CONFIG_IWLWIFI_OPMODE_MODULAR=y
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
# CONFIG_IWLWIFI_DEBUG is not set
CONFIG_IWLWIFI_DEBUGFS=y
# CONFIG_IWLWIFI_DEVICE_TRACING is not set
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
# CONFIG_HERMES is not set
# CONFIG_P54_COMMON is not set
# CONFIG_PRISM54 is not set
CONFIG_WLAN_VENDOR_MARVELL=y
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
# CONFIG_MWIFIEX is not set
# CONFIG_MWL8K is not set
CONFIG_WLAN_VENDOR_MEDIATEK=y
# CONFIG_MT7601U is not set
# CONFIG_MT76x0U is not set
# CONFIG_MT76x0E is not set
# CONFIG_MT76x2E is not set
# CONFIG_MT76x2U is not set
# CONFIG_MT7603E is not set
# CONFIG_MT7615E is not set
CONFIG_WLAN_VENDOR_RALINK=y
# CONFIG_RT2X00 is not set
CONFIG_WLAN_VENDOR_REALTEK=y
# CONFIG_RTL8180 is not set
# CONFIG_RTL8187 is not set
# CONFIG_RTL_CARDS is not set
# CONFIG_RTL8XXXU is not set
# CONFIG_RTW88 is not set
CONFIG_WLAN_VENDOR_RSI=y
# CONFIG_RSI_91X is not set
CONFIG_WLAN_VENDOR_ST=y
# CONFIG_CW1200 is not set
CONFIG_WLAN_VENDOR_TI=y
# CONFIG_WL1251 is not set
# CONFIG_WL12XX is not set
# CONFIG_WL18XX is not set
# CONFIG_WLCORE is not set
CONFIG_WLAN_VENDOR_ZYDAS=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_ZD1211RW is not set
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_QTNFMAC_PCIE is not set
CONFIG_MAC80211_HWSIM=m
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_VIRT_WIFI is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
CONFIG_WAN=y
# CONFIG_LANMEDIA is not set
CONFIG_HDLC=m
CONFIG_HDLC_RAW=m
# CONFIG_HDLC_RAW_ETH is not set
CONFIG_HDLC_CISCO=m
CONFIG_HDLC_FR=m
CONFIG_HDLC_PPP=m

#
# X.25/LAPB support is disabled
#
# CONFIG_PCI200SYN is not set
# CONFIG_WANXL is not set
# CONFIG_PC300TOO is not set
# CONFIG_FARSYNC is not set
CONFIG_DLCI=m
CONFIG_DLCI_MAX=8
# CONFIG_SBNI is not set
CONFIG_IEEE802154_DRIVERS=m
CONFIG_IEEE802154_FAKELB=m
# CONFIG_IEEE802154_AT86RF230 is not set
# CONFIG_IEEE802154_MRF24J40 is not set
# CONFIG_IEEE802154_CC2520 is not set
# CONFIG_IEEE802154_ATUSB is not set
# CONFIG_IEEE802154_ADF7242 is not set
# CONFIG_IEEE802154_CA8210 is not set
# CONFIG_IEEE802154_MCR20A is not set
# CONFIG_IEEE802154_HWSIM is not set
CONFIG_XEN_NETDEV_FRONTEND=m
CONFIG_VMXNET3=m
CONFIG_FUJITSU_ES=m
CONFIG_THUNDERBOLT_NET=m
CONFIG_HYPERV_NET=m
CONFIG_NETDEVSIM=m
CONFIG_NET_FAILOVER=m
CONFIG_ISDN=y
CONFIG_ISDN_CAPI=m
# CONFIG_CAPI_TRACE is not set
CONFIG_ISDN_CAPI_CAPI20=m
CONFIG_ISDN_CAPI_MIDDLEWARE=y
CONFIG_MISDN=m
CONFIG_MISDN_DSP=m
CONFIG_MISDN_L1OIP=m

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=m
CONFIG_MISDN_HFCMULTI=m
CONFIG_MISDN_HFCUSB=m
CONFIG_MISDN_AVMFRITZ=m
CONFIG_MISDN_SPEEDFAX=m
CONFIG_MISDN_INFINEON=m
CONFIG_MISDN_W6692=m
CONFIG_MISDN_NETJET=m
CONFIG_MISDN_HDLC=m
CONFIG_MISDN_IPAC=m
CONFIG_MISDN_ISAR=m
CONFIG_NVM=y
# CONFIG_NVM_PBLK is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
CONFIG_INPUT_FF_MEMLESS=y
CONFIG_INPUT_POLLDEV=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADC is not set
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
# CONFIG_KEYBOARD_APPLESPI is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_PS2_ALPS=y
CONFIG_MOUSE_PS2_BYD=y
CONFIG_MOUSE_PS2_LOGIPS2PP=y
CONFIG_MOUSE_PS2_SYNAPTICS=y
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
CONFIG_MOUSE_PS2_CYPRESS=y
CONFIG_MOUSE_PS2_LIFEBOOK=y
CONFIG_MOUSE_PS2_TRACKPOINT=y
CONFIG_MOUSE_PS2_ELANTECH=y
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=y
CONFIG_MOUSE_PS2_SENTELIC=y
# CONFIG_MOUSE_PS2_TOUCHKIT is not set
CONFIG_MOUSE_PS2_FOCALTECH=y
CONFIG_MOUSE_PS2_VMMOUSE=y
CONFIG_MOUSE_PS2_SMBUS=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MOUSE_APPLETOUCH=m
CONFIG_MOUSE_BCM5974=m
CONFIG_MOUSE_CYAPA=m
# CONFIG_MOUSE_ELAN_I2C is not set
CONFIG_MOUSE_VSXXXAA=m
# CONFIG_MOUSE_GPIO is not set
CONFIG_MOUSE_SYNAPTICS_I2C=m
CONFIG_MOUSE_SYNAPTICS_USB=m
# CONFIG_INPUT_JOYSTICK is not set
CONFIG_INPUT_TABLET=y
CONFIG_TABLET_USB_ACECAD=m
CONFIG_TABLET_USB_AIPTEK=m
CONFIG_TABLET_USB_GTCO=m
# CONFIG_TABLET_USB_HANWANG is not set
CONFIG_TABLET_USB_KBTAB=m
# CONFIG_TABLET_USB_PEGASUS is not set
# CONFIG_TABLET_SERIAL_WACOM4 is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_ADC is not set
# CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_BU21029 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
# CONFIG_TOUCHSCREEN_EXC3000 is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_HIDEEP is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_EKTF2127 is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2004 is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_RM_TS is not set
# CONFIG_TOUCHSCREEN_SILEAD is not set
# CONFIG_TOUCHSCREEN_SIS_I2C is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_STMFTS is not set
# CONFIG_TOUCHSCREEN_SUR40 is not set
# CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZET6223 is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
# CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
# CONFIG_TOUCHSCREEN_IQS5XX is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MSM_VIBRATOR is not set
CONFIG_INPUT_PCSPKR=m
# CONFIG_INPUT_MMA8450 is not set
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GP2A=m
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_DECODER is not set
# CONFIG_INPUT_GPIO_VIBRA is not set
CONFIG_INPUT_ATLAS_BTNS=m
CONFIG_INPUT_ATI_REMOTE2=m
CONFIG_INPUT_KEYSPAN_REMOTE=m
# CONFIG_INPUT_KXTJ9 is not set
CONFIG_INPUT_POWERMATE=m
CONFIG_INPUT_YEALINK=m
CONFIG_INPUT_CM109=m
CONFIG_INPUT_UINPUT=m
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_PWM_VIBRA is not set
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=m
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set
CONFIG_RMI4_CORE=m
# CONFIG_RMI4_I2C is not set
# CONFIG_RMI4_SPI is not set
CONFIG_RMI4_SMB=m
CONFIG_RMI4_F03=y
CONFIG_RMI4_F03_SERIO=m
CONFIG_RMI4_2D_SENSOR=y
CONFIG_RMI4_F11=y
CONFIG_RMI4_F12=y
CONFIG_RMI4_F30=y
# CONFIG_RMI4_F34 is not set
# CONFIG_RMI4_F54 is not set
# CONFIG_RMI4_F55 is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=m
CONFIG_SERIO_ALTERA_PS2=m
# CONFIG_SERIO_PS2MULT is not set
CONFIG_SERIO_ARC_PS2=m
CONFIG_HYPERV_KEYBOARD=m
# CONFIG_SERIO_GPIO_PS2 is not set
# CONFIG_USERIO is not set
# CONFIG_GAMEPORT is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_ROCKETPORT is not set
CONFIG_CYCLADES=m
# CONFIG_CYZ_INTR is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
CONFIG_SYNCLINK=m
CONFIG_SYNCLINKMP=m
CONFIG_SYNCLINK_GT=m
CONFIG_NOZOMI=m
# CONFIG_ISI is not set
CONFIG_N_HDLC=m
CONFIG_N_GSM=m
# CONFIG_TRACE_SINK is not set
# CONFIG_NULL_TTY is not set
CONFIG_LDISC_AUTOLOAD=y
CONFIG_DEVMEM=y
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_NR_UARTS=32
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=y
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_JSM=m
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
# CONFIG_SERIAL_DEV_BUS is not set
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_HVC_DRIVER=y
CONFIG_HVC_IRQ=y
CONFIG_HVC_XEN=y
CONFIG_HVC_XEN_FRONTEND=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=m
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=m
CONFIG_IPMI_SI=m
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_WATCHDOG=m
CONFIG_IPMI_POWEROFF=m
CONFIG_HW_RANDOM=y
CONFIG_HW_RANDOM_TIMERIOMEM=m
CONFIG_HW_RANDOM_INTEL=m
CONFIG_HW_RANDOM_AMD=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_NVRAM=y
# CONFIG_APPLICOM is not set
# CONFIG_MWAVE is not set
CONFIG_RAW_DRIVER=y
CONFIG_MAX_RAW_DEVS=8192
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
# CONFIG_HPET_MMAP_DEFAULT is not set
CONFIG_HANGCHECK_TIMER=m
CONFIG_UV_MMTIMER=m
CONFIG_TCG_TPM=y
CONFIG_HW_RANDOM_TPM=y
CONFIG_TCG_TIS_CORE=y
CONFIG_TCG_TIS=y
# CONFIG_TCG_TIS_SPI is not set
CONFIG_TCG_TIS_I2C_ATMEL=m
CONFIG_TCG_TIS_I2C_INFINEON=m
CONFIG_TCG_TIS_I2C_NUVOTON=m
CONFIG_TCG_NSC=m
CONFIG_TCG_ATMEL=m
CONFIG_TCG_INFINEON=m
# CONFIG_TCG_XEN is not set
CONFIG_TCG_CRB=y
# CONFIG_TCG_VTPM_PROXY is not set
CONFIG_TCG_TIS_ST33ZP24=m
CONFIG_TCG_TIS_ST33ZP24_I2C=m
# CONFIG_TCG_TIS_ST33ZP24_SPI is not set
CONFIG_TELCLOCK=m
CONFIG_DEVPORT=y
# CONFIG_XILLYBUS is not set
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_ACPI_I2C_OPREGION=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_LTC4306 is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_REG is not set
# CONFIG_I2C_MUX_MLXCPLD is not set
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
CONFIG_I2C_AMD756=m
CONFIG_I2C_AMD756_S4882=m
CONFIG_I2C_AMD8111=m
# CONFIG_I2C_AMD_MP2 is not set
CONFIG_I2C_I801=m
CONFIG_I2C_ISCH=m
CONFIG_I2C_ISMT=m
CONFIG_I2C_PIIX4=m
CONFIG_I2C_NFORCE2=m
CONFIG_I2C_NFORCE2_S4985=m
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
CONFIG_I2C_SIS96X=m
CONFIG_I2C_VIA=m
CONFIG_I2C_VIAPRO=m

#
# ACPI drivers
#
CONFIG_I2C_SCMI=m

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
CONFIG_I2C_DESIGNWARE_CORE=m
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
# CONFIG_I2C_EMEV2 is not set
# CONFIG_I2C_GPIO is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
CONFIG_I2C_SIMTEC=m
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=m
CONFIG_I2C_PARPORT=m
CONFIG_I2C_PARPORT_LIGHT=m
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
CONFIG_I2C_TINY_USB=m
CONFIG_I2C_VIPERBOARD=m

#
# Other I2C/SMBus bus drivers
#
# CONFIG_I2C_MLXCPLD is not set
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=m
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

# CONFIG_I3C is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y
# CONFIG_SPI_MEM is not set

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_AXI_SPI_ENGINE is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_BUTTERFLY is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_DESIGNWARE is not set
# CONFIG_SPI_NXP_FLEXSPI is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_LM70_LLP is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PXA2XX is not set
# CONFIG_SPI_ROCKCHIP is not set
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_SIFIVE is not set
# CONFIG_SPI_MXIC is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_LOOPBACK_TEST is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPI_SLAVE is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_DP83640_PHY=m
CONFIG_PTP_1588_CLOCK_KVM=m
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AMD=m
# CONFIG_PINCTRL_MCP23S08 is not set
# CONFIG_PINCTRL_SX150X is not set
CONFIG_PINCTRL_BAYTRAIL=y
# CONFIG_PINCTRL_CHERRYVIEW is not set
CONFIG_PINCTRL_INTEL=m
# CONFIG_PINCTRL_BROXTON is not set
CONFIG_PINCTRL_CANNONLAKE=m
# CONFIG_PINCTRL_CEDARFORK is not set
CONFIG_PINCTRL_DENVERTON=m
CONFIG_PINCTRL_GEMINILAKE=m
# CONFIG_PINCTRL_ICELAKE is not set
CONFIG_PINCTRL_LEWISBURG=m
CONFIG_PINCTRL_SUNRISEPOINT=m
CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_GENERIC=m

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_AMDPT=m
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_ICH=m
# CONFIG_GPIO_LYNXPOINT is not set
# CONFIG_GPIO_MB86S7X is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_XILINX is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
# CONFIG_GPIO_F7188X is not set
# CONFIG_GPIO_IT87 is not set
# CONFIG_GPIO_SCH is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_WINBOND is not set
# CONFIG_GPIO_WS16C48 is not set
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
# CONFIG_GPIO_MAX3191X is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_PISOSR is not set
# CONFIG_GPIO_XRA1403 is not set
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=m
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=y
# CONFIG_W1 is not set
# CONFIG_POWER_AVS is not set
CONFIG_POWER_RESET=y
# CONFIG_POWER_RESET_RESTART is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=y
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_CHARGER_ADP5061 is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
# CONFIG_BATTERY_SBS is not set
# CONFIG_CHARGER_SBS is not set
# CONFIG_MANAGER_SBS is not set
# CONFIG_BATTERY_BQ27XXX is not set
# CONFIG_BATTERY_MAX17040 is not set
# CONFIG_BATTERY_MAX17042 is not set
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
CONFIG_CHARGER_SMB347=m
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
CONFIG_HWMON=y
CONFIG_HWMON_VID=m
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=m
CONFIG_SENSORS_ABITUGURU3=m
# CONFIG_SENSORS_AD7314 is not set
CONFIG_SENSORS_AD7414=m
CONFIG_SENSORS_AD7418=m
CONFIG_SENSORS_ADM1021=m
CONFIG_SENSORS_ADM1025=m
CONFIG_SENSORS_ADM1026=m
CONFIG_SENSORS_ADM1029=m
CONFIG_SENSORS_ADM1031=m
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
# CONFIG_SENSORS_ADT7310 is not set
CONFIG_SENSORS_ADT7410=m
CONFIG_SENSORS_ADT7411=m
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
CONFIG_SENSORS_ADT7475=m
# CONFIG_SENSORS_AS370 is not set
CONFIG_SENSORS_ASC7621=m
CONFIG_SENSORS_K8TEMP=m
CONFIG_SENSORS_K10TEMP=m
CONFIG_SENSORS_FAM15H_POWER=m
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
# CONFIG_SENSORS_ASPEED is not set
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_DS620=m
CONFIG_SENSORS_DS1621=m
CONFIG_SENSORS_DELL_SMM=m
CONFIG_SENSORS_I5K_AMB=m
CONFIG_SENSORS_F71805F=m
CONFIG_SENSORS_F71882FG=m
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_FSCHMD=m
# CONFIG_SENSORS_FTSTEUTATES is not set
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_HIH6130 is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=m
CONFIG_SENSORS_IT87=m
CONFIG_SENSORS_JC42=m
# CONFIG_SENSORS_POWR1220 is not set
CONFIG_SENSORS_LINEAGE=m
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC2990 is not set
CONFIG_SENSORS_LTC4151=m
CONFIG_SENSORS_LTC4215=m
# CONFIG_SENSORS_LTC4222 is not set
CONFIG_SENSORS_LTC4245=m
# CONFIG_SENSORS_LTC4260 is not set
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX1111 is not set
CONFIG_SENSORS_MAX16065=m
CONFIG_SENSORS_MAX1619=m
CONFIG_SENSORS_MAX1668=m
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31722 is not set
# CONFIG_SENSORS_MAX6621 is not set
CONFIG_SENSORS_MAX6639=m
CONFIG_SENSORS_MAX6642=m
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
# CONFIG_SENSORS_MAX31790 is not set
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
# CONFIG_SENSORS_ADCXX is not set
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM70 is not set
CONFIG_SENSORS_LM73=m
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
CONFIG_SENSORS_LM78=m
CONFIG_SENSORS_LM80=m
CONFIG_SENSORS_LM83=m
CONFIG_SENSORS_LM85=m
CONFIG_SENSORS_LM87=m
CONFIG_SENSORS_LM90=m
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
CONFIG_SENSORS_PC87360=m
CONFIG_SENSORS_PC87427=m
CONFIG_SENSORS_NTC_THERMISTOR=m
# CONFIG_SENSORS_NCT6683 is not set
CONFIG_SENSORS_NCT6775=m
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_NPCM7XX is not set
CONFIG_SENSORS_PCF8591=m
CONFIG_PMBUS=m
CONFIG_SENSORS_PMBUS=m
CONFIG_SENSORS_ADM1275=m
# CONFIG_SENSORS_IBM_CFFPS is not set
# CONFIG_SENSORS_INSPUR_IPSPS is not set
# CONFIG_SENSORS_IR35221 is not set
# CONFIG_SENSORS_IR38064 is not set
# CONFIG_SENSORS_IRPS5401 is not set
# CONFIG_SENSORS_ISL68137 is not set
CONFIG_SENSORS_LM25066=m
CONFIG_SENSORS_LTC2978=m
# CONFIG_SENSORS_LTC3815 is not set
CONFIG_SENSORS_MAX16064=m
# CONFIG_SENSORS_MAX20751 is not set
# CONFIG_SENSORS_MAX31785 is not set
CONFIG_SENSORS_MAX34440=m
CONFIG_SENSORS_MAX8688=m
# CONFIG_SENSORS_PXE1610 is not set
# CONFIG_SENSORS_TPS40422 is not set
# CONFIG_SENSORS_TPS53679 is not set
CONFIG_SENSORS_UCD9000=m
CONFIG_SENSORS_UCD9200=m
CONFIG_SENSORS_ZL6100=m
CONFIG_SENSORS_SHT15=m
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHTC1 is not set
CONFIG_SENSORS_SIS5595=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
# CONFIG_SENSORS_EMC2103 is not set
CONFIG_SENSORS_EMC6W201=m
CONFIG_SENSORS_SMSC47M1=m
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=m
CONFIG_SENSORS_SCH56XX_COMMON=m
CONFIG_SENSORS_SCH5627=m
CONFIG_SENSORS_SCH5636=m
# CONFIG_SENSORS_STTS751 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_ADS7871 is not set
CONFIG_SENSORS_AMC6821=m
CONFIG_SENSORS_INA209=m
CONFIG_SENSORS_INA2XX=m
# CONFIG_SENSORS_INA3221 is not set
# CONFIG_SENSORS_TC74 is not set
CONFIG_SENSORS_THMC50=m
CONFIG_SENSORS_TMP102=m
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP108 is not set
CONFIG_SENSORS_TMP401=m
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_VIA_CPUTEMP=m
CONFIG_SENSORS_VIA686A=m
CONFIG_SENSORS_VT1211=m
CONFIG_SENSORS_VT8231=m
# CONFIG_SENSORS_W83773G is not set
CONFIG_SENSORS_W83781D=m
CONFIG_SENSORS_W83791D=m
CONFIG_SENSORS_W83792D=m
CONFIG_SENSORS_W83793=m
CONFIG_SENSORS_W83795=m
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=m
CONFIG_SENSORS_W83L786NG=m
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=m
# CONFIG_SENSORS_XGENE is not set

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=m
CONFIG_SENSORS_ATK0110=m
CONFIG_THERMAL=y
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=y
CONFIG_THERMAL_GOV_STEP_WISE=y
CONFIG_THERMAL_GOV_BANG_BANG=y
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
# CONFIG_CLOCK_THERMAL is not set
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=m
CONFIG_X86_PKG_TEMP_THERMAL=m
CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=m
CONFIG_ACPI_THERMAL_REL=m
# CONFIG_INT3406_THERMAL is not set
CONFIG_PROC_THERMAL_MMIO_RAPL=y
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# end of Intel thermal drivers

# CONFIG_GENERIC_ADC_THERMAL is not set
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=y
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_WDAT_WDT=m
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ZIIRAVE_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
CONFIG_ALIM1535_WDT=m
CONFIG_ALIM7101_WDT=m
# CONFIG_EBC_C384_WDT is not set
CONFIG_F71808E_WDT=m
CONFIG_SP5100_TCO=m
CONFIG_SBC_FITPC2_WATCHDOG=m
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
# CONFIG_WAFER_WDT is not set
CONFIG_I6300ESB_WDT=y
CONFIG_IE6XX_WDT=m
CONFIG_ITCO_WDT=y
CONFIG_ITCO_VENDOR_SUPPORT=y
CONFIG_IT8712F_WDT=m
CONFIG_IT87_WDT=m
CONFIG_HP_WATCHDOG=m
CONFIG_HPWDT_NMI_DECODING=y
# CONFIG_SC1200_WDT is not set
# CONFIG_PC87413_WDT is not set
CONFIG_NV_TCO=m
# CONFIG_60XX_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_SMSC_SCH311X_WDT=m
# CONFIG_SMSC37B787_WDT is not set
# CONFIG_TQMX86_WDT is not set
CONFIG_VIA_WDT=m
CONFIG_W83627HF_WDT=m
CONFIG_W83877F_WDT=m
CONFIG_W83977F_WDT=m
CONFIG_MACHZ_WDT=m
# CONFIG_SBC_EPX_C3_WATCHDOG is not set
CONFIG_INTEL_MEI_WDT=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set
CONFIG_XEN_WDT=m

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=m
CONFIG_WDTPCI=m

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE=y
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=m
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_DRIVER_GMAC_CMN=y
CONFIG_BCMA_DRIVER_GPIO=y
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
# CONFIG_MFD_MADERA is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
CONFIG_LPC_ICH=m
CONFIG_LPC_SCH=m
# CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
CONFIG_MFD_INTEL_LPSS=y
CONFIG_MFD_INTEL_LPSS_ACPI=y
CONFIG_MFD_INTEL_LPSS_PCI=y
# CONFIG_MFD_JANZ_CMODIO is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
# CONFIG_MFD_MAX14577 is not set
# CONFIG_MFD_MAX77693 is not set
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
# CONFIG_MFD_MAX8997 is not set
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
CONFIG_MFD_VIPERBOARD=m
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_SEC_CORE is not set
# CONFIG_MFD_SI476X_CORE is not set
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_SYSCON is not set
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_TI_LMU is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
# CONFIG_MFD_TPS65086 is not set
# CONFIG_MFD_TPS65090 is not set
# CONFIG_MFD_TI_LP873X is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TQMX86 is not set
CONFIG_MFD_VX855=m
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
# end of Multifunction device drivers

# CONFIG_REGULATOR is not set
CONFIG_RC_CORE=m
CONFIG_RC_MAP=m
CONFIG_LIRC=y
CONFIG_RC_DECODERS=y
CONFIG_IR_NEC_DECODER=m
CONFIG_IR_RC5_DECODER=m
CONFIG_IR_RC6_DECODER=m
CONFIG_IR_JVC_DECODER=m
CONFIG_IR_SONY_DECODER=m
CONFIG_IR_SANYO_DECODER=m
CONFIG_IR_SHARP_DECODER=m
CONFIG_IR_MCE_KBD_DECODER=m
# CONFIG_IR_XMP_DECODER is not set
CONFIG_IR_IMON_DECODER=m
# CONFIG_IR_RCMM_DECODER is not set
CONFIG_RC_DEVICES=y
CONFIG_RC_ATI_REMOTE=m
CONFIG_IR_ENE=m
CONFIG_IR_IMON=m
# CONFIG_IR_IMON_RAW is not set
CONFIG_IR_MCEUSB=m
CONFIG_IR_ITE_CIR=m
CONFIG_IR_FINTEK=m
CONFIG_IR_NUVOTON=m
CONFIG_IR_REDRAT3=m
CONFIG_IR_STREAMZAP=m
CONFIG_IR_WINBOND_CIR=m
# CONFIG_IR_IGORPLUGUSB is not set
CONFIG_IR_IGUANA=m
CONFIG_IR_TTUSBIR=m
CONFIG_RC_LOOPBACK=m
# CONFIG_IR_SERIAL is not set
# CONFIG_IR_SIR is not set
# CONFIG_RC_XBOX_DVD is not set
CONFIG_MEDIA_SUPPORT=m

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_MEDIA_ANALOG_TV_SUPPORT=y
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
CONFIG_MEDIA_CONTROLLER=y
CONFIG_MEDIA_CONTROLLER_DVB=y
CONFIG_VIDEO_DEV=m
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set
CONFIG_VIDEO_V4L2=m
CONFIG_VIDEO_V4L2_I2C=y
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEOBUF_GEN=m
CONFIG_VIDEOBUF_DMA_SG=m
CONFIG_VIDEOBUF_VMALLOC=m
CONFIG_DVB_CORE=m
# CONFIG_DVB_MMAP is not set
CONFIG_DVB_NET=y
CONFIG_TTPCI_EEPROM=m
CONFIG_DVB_MAX_ADAPTERS=8
CONFIG_DVB_DYNAMIC_MINORS=y
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=y

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=m
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=y
CONFIG_USB_GSPCA=m
CONFIG_USB_M5602=m
CONFIG_USB_STV06XX=m
CONFIG_USB_GL860=m
CONFIG_USB_GSPCA_BENQ=m
CONFIG_USB_GSPCA_CONEX=m
CONFIG_USB_GSPCA_CPIA1=m
# CONFIG_USB_GSPCA_DTCS033 is not set
CONFIG_USB_GSPCA_ETOMS=m
CONFIG_USB_GSPCA_FINEPIX=m
CONFIG_USB_GSPCA_JEILINJ=m
CONFIG_USB_GSPCA_JL2005BCD=m
# CONFIG_USB_GSPCA_KINECT is not set
CONFIG_USB_GSPCA_KONICA=m
CONFIG_USB_GSPCA_MARS=m
CONFIG_USB_GSPCA_MR97310A=m
CONFIG_USB_GSPCA_NW80X=m
CONFIG_USB_GSPCA_OV519=m
CONFIG_USB_GSPCA_OV534=m
CONFIG_USB_GSPCA_OV534_9=m
CONFIG_USB_GSPCA_PAC207=m
CONFIG_USB_GSPCA_PAC7302=m
CONFIG_USB_GSPCA_PAC7311=m
CONFIG_USB_GSPCA_SE401=m
CONFIG_USB_GSPCA_SN9C2028=m
CONFIG_USB_GSPCA_SN9C20X=m
CONFIG_USB_GSPCA_SONIXB=m
CONFIG_USB_GSPCA_SONIXJ=m
CONFIG_USB_GSPCA_SPCA500=m
CONFIG_USB_GSPCA_SPCA501=m
CONFIG_USB_GSPCA_SPCA505=m
CONFIG_USB_GSPCA_SPCA506=m
CONFIG_USB_GSPCA_SPCA508=m
CONFIG_USB_GSPCA_SPCA561=m
CONFIG_USB_GSPCA_SPCA1528=m
CONFIG_USB_GSPCA_SQ905=m
CONFIG_USB_GSPCA_SQ905C=m
CONFIG_USB_GSPCA_SQ930X=m
CONFIG_USB_GSPCA_STK014=m
# CONFIG_USB_GSPCA_STK1135 is not set
CONFIG_USB_GSPCA_STV0680=m
CONFIG_USB_GSPCA_SUNPLUS=m
CONFIG_USB_GSPCA_T613=m
CONFIG_USB_GSPCA_TOPRO=m
# CONFIG_USB_GSPCA_TOUPTEK is not set
CONFIG_USB_GSPCA_TV8532=m
CONFIG_USB_GSPCA_VC032X=m
CONFIG_USB_GSPCA_VICAM=m
CONFIG_USB_GSPCA_XIRLINK_CIT=m
CONFIG_USB_GSPCA_ZC3XX=m
CONFIG_USB_PWC=m
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=y
# CONFIG_VIDEO_CPIA2 is not set
CONFIG_USB_ZR364XX=m
CONFIG_USB_STKWEBCAM=m
CONFIG_USB_S2255=m
# CONFIG_VIDEO_USBTV is not set

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=m
CONFIG_VIDEO_PVRUSB2_SYSFS=y
CONFIG_VIDEO_PVRUSB2_DVB=y
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=m
CONFIG_VIDEO_USBVISION=m
# CONFIG_VIDEO_STK1160_COMMON is not set
# CONFIG_VIDEO_GO7007 is not set

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=m
CONFIG_VIDEO_AU0828_V4L2=y
# CONFIG_VIDEO_AU0828_RC is not set
CONFIG_VIDEO_CX231XX=m
CONFIG_VIDEO_CX231XX_RC=y
CONFIG_VIDEO_CX231XX_ALSA=m
CONFIG_VIDEO_CX231XX_DVB=m
CONFIG_VIDEO_TM6000=m
CONFIG_VIDEO_TM6000_ALSA=m
CONFIG_VIDEO_TM6000_DVB=m

#
# Digital TV USB devices
#
CONFIG_DVB_USB=m
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_A800=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_USB_UMT_010=m
CONFIG_DVB_USB_CXUSB=m
# CONFIG_DVB_USB_CXUSB_ANALOG is not set
CONFIG_DVB_USB_M920X=m
CONFIG_DVB_USB_DIGITV=m
CONFIG_DVB_USB_VP7045=m
CONFIG_DVB_USB_VP702X=m
CONFIG_DVB_USB_GP8PSK=m
CONFIG_DVB_USB_NOVA_T_USB2=m
CONFIG_DVB_USB_TTUSB2=m
CONFIG_DVB_USB_DTT200U=m
CONFIG_DVB_USB_OPERA1=m
CONFIG_DVB_USB_AF9005=m
CONFIG_DVB_USB_AF9005_REMOTE=m
CONFIG_DVB_USB_PCTV452E=m
CONFIG_DVB_USB_DW2102=m
CONFIG_DVB_USB_CINERGY_T2=m
CONFIG_DVB_USB_DTV5100=m
CONFIG_DVB_USB_AZ6027=m
CONFIG_DVB_USB_TECHNISAT_USB2=m
CONFIG_DVB_USB_V2=m
CONFIG_DVB_USB_AF9015=m
CONFIG_DVB_USB_AF9035=m
CONFIG_DVB_USB_ANYSEE=m
CONFIG_DVB_USB_AU6610=m
CONFIG_DVB_USB_AZ6007=m
CONFIG_DVB_USB_CE6230=m
CONFIG_DVB_USB_EC168=m
CONFIG_DVB_USB_GL861=m
CONFIG_DVB_USB_LME2510=m
CONFIG_DVB_USB_MXL111SF=m
CONFIG_DVB_USB_RTL28XXU=m
# CONFIG_DVB_USB_DVBSKY is not set
# CONFIG_DVB_USB_ZD1301 is not set
CONFIG_DVB_TTUSB_BUDGET=m
CONFIG_DVB_TTUSB_DEC=m
CONFIG_SMS_USB_DRV=m
CONFIG_DVB_B2C2_FLEXCOP_USB=m
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
# CONFIG_DVB_AS102 is not set

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=m
# CONFIG_VIDEO_EM28XX_V4L2 is not set
CONFIG_VIDEO_EM28XX_ALSA=m
CONFIG_VIDEO_EM28XX_DVB=m
CONFIG_VIDEO_EM28XX_RC=m
CONFIG_MEDIA_PCI_SUPPORT=y

#
# Media capture support
#
# CONFIG_VIDEO_MEYE is not set
# CONFIG_VIDEO_SOLO6X10 is not set
# CONFIG_VIDEO_TW5864 is not set
# CONFIG_VIDEO_TW68 is not set
# CONFIG_VIDEO_TW686X is not set

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=m
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
# CONFIG_VIDEO_IVTV_ALSA is not set
CONFIG_VIDEO_FB_IVTV=m
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
# CONFIG_VIDEO_HEXIUM_GEMINI is not set
# CONFIG_VIDEO_HEXIUM_ORION is not set
# CONFIG_VIDEO_MXB is not set
# CONFIG_VIDEO_DT3155 is not set

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=m
CONFIG_VIDEO_CX18_ALSA=m
CONFIG_VIDEO_CX23885=m
CONFIG_MEDIA_ALTERA_CI=m
# CONFIG_VIDEO_CX25821 is not set
CONFIG_VIDEO_CX88=m
CONFIG_VIDEO_CX88_ALSA=m
CONFIG_VIDEO_CX88_BLACKBIRD=m
CONFIG_VIDEO_CX88_DVB=m
CONFIG_VIDEO_CX88_ENABLE_VP3054=y
CONFIG_VIDEO_CX88_VP3054=m
CONFIG_VIDEO_CX88_MPEG=m
CONFIG_VIDEO_BT848=m
CONFIG_DVB_BT8XX=m
CONFIG_VIDEO_SAA7134=m
CONFIG_VIDEO_SAA7134_ALSA=m
CONFIG_VIDEO_SAA7134_RC=y
CONFIG_VIDEO_SAA7134_DVB=m
CONFIG_VIDEO_SAA7164=m

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=y
CONFIG_DVB_AV7110=m
CONFIG_DVB_AV7110_OSD=y
CONFIG_DVB_BUDGET_CORE=m
CONFIG_DVB_BUDGET=m
CONFIG_DVB_BUDGET_CI=m
CONFIG_DVB_BUDGET_AV=m
CONFIG_DVB_BUDGET_PATCH=m
CONFIG_DVB_B2C2_FLEXCOP_PCI=m
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=m
CONFIG_DVB_DM1105=m
CONFIG_DVB_PT1=m
# CONFIG_DVB_PT3 is not set
CONFIG_MANTIS_CORE=m
CONFIG_DVB_MANTIS=m
CONFIG_DVB_HOPPER=m
CONFIG_DVB_NGENE=m
CONFIG_DVB_DDBRIDGE=m
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
# CONFIG_DVB_SMIPCIE is not set
# CONFIG_DVB_NETUP_UNIDVB is not set
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set
# CONFIG_V4L_TEST_DRIVERS is not set
# CONFIG_DVB_PLATFORM_DRIVERS is not set

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=m
CONFIG_RADIO_ADAPTERS=y
CONFIG_RADIO_TEA575X=m
# CONFIG_RADIO_SI470X is not set
# CONFIG_RADIO_SI4713 is not set
# CONFIG_USB_MR800 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_SHARK is not set
# CONFIG_RADIO_SHARK2 is not set
# CONFIG_USB_KEENE is not set
# CONFIG_USB_RAREMONO is not set
# CONFIG_USB_MA901 is not set
# CONFIG_RADIO_TEA5764 is not set
# CONFIG_RADIO_SAA7706H is not set
# CONFIG_RADIO_TEF6862 is not set
# CONFIG_RADIO_WL1273 is not set

#
# Texas Instruments WL128x FM driver (ST based)
#
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=m
CONFIG_DVB_FIREDTV_INPUT=y
CONFIG_MEDIA_COMMON_OPTIONS=y

#
# common driver options
#
CONFIG_VIDEO_CX2341X=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_CYPRESS_FIRMWARE=m
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
CONFIG_VIDEOBUF2_DMA_SG=m
CONFIG_VIDEOBUF2_DVB=m
CONFIG_DVB_B2C2_FLEXCOP=m
CONFIG_VIDEO_SAA7146=m
CONFIG_VIDEO_SAA7146_VV=m
CONFIG_SMS_SIANO_MDTV=m
CONFIG_SMS_SIANO_RC=y
# CONFIG_SMS_SIANO_DEBUGFS is not set

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=y
CONFIG_MEDIA_ATTACH=y
CONFIG_VIDEO_IR_I2C=m

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=m
CONFIG_VIDEO_TDA7432=m
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_CS3308=m
CONFIG_VIDEO_CS5345=m
CONFIG_VIDEO_CS53L32A=m
# CONFIG_VIDEO_TLV320AIC23B is not set
# CONFIG_VIDEO_UDA1342 is not set
CONFIG_VIDEO_WM8775=m
CONFIG_VIDEO_WM8739=m
CONFIG_VIDEO_VP27SMPX=m
# CONFIG_VIDEO_SONY_BTF_MPX is not set

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=m

#
# Video decoders
#
# CONFIG_VIDEO_ADV7183 is not set
# CONFIG_VIDEO_BT819 is not set
# CONFIG_VIDEO_BT856 is not set
# CONFIG_VIDEO_BT866 is not set
# CONFIG_VIDEO_KS0127 is not set
# CONFIG_VIDEO_ML86V7667 is not set
# CONFIG_VIDEO_SAA7110 is not set
CONFIG_VIDEO_SAA711X=m
# CONFIG_VIDEO_TVP514X is not set
# CONFIG_VIDEO_TVP5150 is not set
# CONFIG_VIDEO_TVP7002 is not set
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
# CONFIG_VIDEO_TW9906 is not set
# CONFIG_VIDEO_TW9910 is not set
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
CONFIG_VIDEO_CX25840=m

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
# CONFIG_VIDEO_ADV7170 is not set
# CONFIG_VIDEO_ADV7175 is not set
# CONFIG_VIDEO_ADV7343 is not set
# CONFIG_VIDEO_ADV7393 is not set
# CONFIG_VIDEO_AK881X is not set
# CONFIG_VIDEO_THS8200 is not set

#
# Camera sensor devices
#
# CONFIG_VIDEO_OV2640 is not set
# CONFIG_VIDEO_OV2659 is not set
# CONFIG_VIDEO_OV2680 is not set
# CONFIG_VIDEO_OV2685 is not set
# CONFIG_VIDEO_OV6650 is not set
# CONFIG_VIDEO_OV5695 is not set
# CONFIG_VIDEO_OV772X is not set
# CONFIG_VIDEO_OV7640 is not set
# CONFIG_VIDEO_OV7670 is not set
# CONFIG_VIDEO_OV7740 is not set
# CONFIG_VIDEO_OV9640 is not set
# CONFIG_VIDEO_VS6624 is not set
# CONFIG_VIDEO_MT9M111 is not set
# CONFIG_VIDEO_MT9T112 is not set
# CONFIG_VIDEO_MT9V011 is not set
# CONFIG_VIDEO_MT9V111 is not set
# CONFIG_VIDEO_SR030PC30 is not set
# CONFIG_VIDEO_RJ54N1 is not set

#
# Lens drivers
#
# CONFIG_VIDEO_AD5820 is not set

#
# Flash devices
#
# CONFIG_VIDEO_ADP1653 is not set
# CONFIG_VIDEO_LM3560 is not set
# CONFIG_VIDEO_LM3646 is not set

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
CONFIG_VIDEO_UPD64083=m

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=m

#
# SDR tuner chips
#

#
# Miscellaneous helper chips
#
# CONFIG_VIDEO_THS7303 is not set
CONFIG_VIDEO_M52790=m
# CONFIG_VIDEO_I2C is not set
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
# end of SPI helper chips

#
# Media SPI Adapters
#
# CONFIG_CXD2880_SPI_DRV is not set
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA9887=m
CONFIG_MEDIA_TUNER_TEA5761=m
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_MSI001 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2060=m
CONFIG_MEDIA_TUNER_MT2063=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_QT1010=m
CONFIG_MEDIA_TUNER_XC2028=m
CONFIG_MEDIA_TUNER_XC5000=m
CONFIG_MEDIA_TUNER_XC4000=m
CONFIG_MEDIA_TUNER_MXL5005S=m
CONFIG_MEDIA_TUNER_MXL5007T=m
CONFIG_MEDIA_TUNER_MC44S803=m
CONFIG_MEDIA_TUNER_MAX2165=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_FC0011=m
CONFIG_MEDIA_TUNER_FC0012=m
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_E4000=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
CONFIG_MEDIA_TUNER_TUA9001=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_R820T=m
# CONFIG_MEDIA_TUNER_MXL301RF is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
CONFIG_MEDIA_TUNER_QM1D1B0004=m
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=m
CONFIG_DVB_STB6100=m
CONFIG_DVB_STV090x=m
CONFIG_DVB_STV0910=m
CONFIG_DVB_STV6110x=m
CONFIG_DVB_STV6111=m
CONFIG_DVB_MXL5XX=m
CONFIG_DVB_M88DS3103=m

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=m
CONFIG_DVB_TDA18271C2DD=m
CONFIG_DVB_SI2165=m
CONFIG_DVB_MN88472=m
CONFIG_DVB_MN88473=m

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=m
CONFIG_DVB_CX24123=m
CONFIG_DVB_MT312=m
CONFIG_DVB_ZL10036=m
CONFIG_DVB_ZL10039=m
CONFIG_DVB_S5H1420=m
CONFIG_DVB_STV0288=m
CONFIG_DVB_STB6000=m
CONFIG_DVB_STV0299=m
CONFIG_DVB_STV6110=m
CONFIG_DVB_STV0900=m
CONFIG_DVB_TDA8083=m
CONFIG_DVB_TDA10086=m
CONFIG_DVB_TDA8261=m
CONFIG_DVB_VES1X93=m
CONFIG_DVB_TUNER_ITD1000=m
CONFIG_DVB_TUNER_CX24113=m
CONFIG_DVB_TDA826X=m
CONFIG_DVB_TUA6100=m
CONFIG_DVB_CX24116=m
CONFIG_DVB_CX24117=m
CONFIG_DVB_CX24120=m
CONFIG_DVB_SI21XX=m
CONFIG_DVB_TS2020=m
CONFIG_DVB_DS3000=m
CONFIG_DVB_MB86A16=m
CONFIG_DVB_TDA10071=m

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_CX22700=m
CONFIG_DVB_CX22702=m
# CONFIG_DVB_S5H1432 is not set
CONFIG_DVB_DRXD=m
CONFIG_DVB_L64781=m
CONFIG_DVB_TDA1004X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
# CONFIG_DVB_DIB9000 is not set
CONFIG_DVB_TDA10048=m
CONFIG_DVB_AF9013=m
CONFIG_DVB_EC100=m
CONFIG_DVB_STV0367=m
CONFIG_DVB_CXD2820R=m
CONFIG_DVB_CXD2841ER=m
CONFIG_DVB_RTL2830=m
CONFIG_DVB_RTL2832=m
CONFIG_DVB_SI2168=m
# CONFIG_DVB_ZD1301_DEMOD is not set
CONFIG_DVB_GP8PSK_FE=m
# CONFIG_DVB_CXD2880 is not set

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=m
CONFIG_DVB_TDA10021=m
CONFIG_DVB_TDA10023=m
CONFIG_DVB_STV0297=m

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_OR51132=m
CONFIG_DVB_BCM3510=m
CONFIG_DVB_LGDT330X=m
CONFIG_DVB_LGDT3305=m
CONFIG_DVB_LGDT3306A=m
CONFIG_DVB_LG2160=m
CONFIG_DVB_S5H1409=m
CONFIG_DVB_AU8522=m
CONFIG_DVB_AU8522_DTV=m
CONFIG_DVB_AU8522_V4L=m
CONFIG_DVB_S5H1411=m

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_MB86A20S=m

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=m
# CONFIG_DVB_MN88443X is not set

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=m
CONFIG_DVB_LNBH25=m
# CONFIG_DVB_LNBH29 is not set
CONFIG_DVB_LNBP21=m
CONFIG_DVB_LNBP22=m
CONFIG_DVB_ISL6405=m
CONFIG_DVB_ISL6421=m
CONFIG_DVB_ISL6423=m
CONFIG_DVB_A8293=m
# CONFIG_DVB_LGS8GL5 is not set
CONFIG_DVB_LGS8GXX=m
CONFIG_DVB_ATBM8830=m
CONFIG_DVB_TDA665x=m
CONFIG_DVB_IX2505V=m
CONFIG_DVB_M88RS2000=m
CONFIG_DVB_AF9033=m
# CONFIG_DVB_HORUS3A is not set
# CONFIG_DVB_ASCOT2E is not set
# CONFIG_DVB_HELENE is not set

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=m
# CONFIG_DVB_SP2 is not set

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=m
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_SIS=y
CONFIG_AGP_VIA=y
CONFIG_INTEL_GTT=y
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=64
CONFIG_VGA_SWITCHEROO=y
CONFIG_DRM=m
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_DP_AUX_CHARDEV=y
CONFIG_DRM_DEBUG_SELFTEST=m
CONFIG_DRM_KMS_HELPER=m
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
CONFIG_DRM_FBDEV_OVERALLOC=100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=y
# CONFIG_DRM_DP_CEC is not set
CONFIG_DRM_TTM=m
CONFIG_DRM_VRAM_HELPER=m
CONFIG_DRM_GEM_SHMEM_HELPER=y

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=m
CONFIG_DRM_I2C_SIL164=m
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_I2C_NXP_TDA9950 is not set
# end of I2C encoder or helper chips

#
# ARM devices
#
# end of ARM devices

# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_AMDGPU is not set

#
# ACP (Audio CoProcessor) Configuration
#
# end of ACP (Audio CoProcessor) Configuration

# CONFIG_DRM_NOUVEAU is not set
CONFIG_DRM_I915=m
# CONFIG_DRM_I915_ALPHA_SUPPORT is not set
CONFIG_DRM_I915_FORCE_PROBE=""
CONFIG_DRM_I915_CAPTURE_ERROR=y
CONFIG_DRM_I915_COMPRESS_ERROR=y
CONFIG_DRM_I915_USERPTR=y
CONFIG_DRM_I915_GVT=y
CONFIG_DRM_I915_GVT_KVMGT=m

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
CONFIG_DRM_I915_SPIN_REQUEST=5
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=m
# CONFIG_DRM_VKMS is not set
CONFIG_DRM_VMWGFX=m
CONFIG_DRM_VMWGFX_FBCON=y
CONFIG_DRM_GMA500=m
CONFIG_DRM_GMA600=y
CONFIG_DRM_GMA3600=y
CONFIG_DRM_UDL=m
CONFIG_DRM_AST=m
CONFIG_DRM_MGAG200=m
CONFIG_DRM_CIRRUS_QEMU=m
CONFIG_DRM_QXL=m
CONFIG_DRM_BOCHS=m
CONFIG_DRM_VIRTIO_GPU=m
CONFIG_DRM_PANEL=y

#
# Display Panels
#
# CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
# end of Display Panels

CONFIG_DRM_BRIDGE=y
CONFIG_DRM_PANEL_BRIDGE=y

#
# Display Interface Bridges
#
# CONFIG_DRM_ANALOGIX_ANX78XX is not set
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
# CONFIG_DRM_GM12U320 is not set
# CONFIG_TINYDRM_HX8357D is not set
# CONFIG_TINYDRM_ILI9225 is not set
# CONFIG_TINYDRM_ILI9341 is not set
# CONFIG_TINYDRM_MI0283QT is not set
# CONFIG_TINYDRM_REPAPER is not set
# CONFIG_TINYDRM_ST7586 is not set
# CONFIG_TINYDRM_ST7735R is not set
# CONFIG_DRM_XEN is not set
# CONFIG_DRM_VBOXVIDEO is not set
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
CONFIG_DRM_LIB_RANDOM=y

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_BOOT_VESA_SUPPORT=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=m
CONFIG_FB_SYS_COPYAREA=m
CONFIG_FB_SYS_IMAGEBLIT=m
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=m
CONFIG_FB_DEFERRED_IO=y
# CONFIG_FB_MODE_HELPERS is not set
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=y
CONFIG_FB_EFI=y
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_XEN_FBDEV_FRONTEND is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=m
# CONFIG_FB_SIMPLE is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=m
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=m
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
# CONFIG_LCD_OTM3225A is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
# CONFIG_BACKLIGHT_GENERIC is not set
# CONFIG_BACKLIGHT_PWM is not set
CONFIG_BACKLIGHT_APPLE=m
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
CONFIG_BACKLIGHT_LP855X=m
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_BACKLIGHT_ARCXCNN is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=y
CONFIG_DUMMY_CONSOLE_COLUMNS=80
CONFIG_DUMMY_CONSOLE_ROWS=25
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
# CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
# end of Console display driver support

CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SOUND_OSS_CORE=y
CONFIG_SOUND_OSS_CORE_PRECLAIM=y
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_PCM_ELD=y
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
CONFIG_SND_OSSEMUL=y
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
CONFIG_SND_PCM_TIMER=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQUENCER_OSS=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
CONFIG_SND_SEQ_MIDI_EVENT=m
CONFIG_SND_SEQ_MIDI=m
CONFIG_SND_SEQ_MIDI_EMUL=m
CONFIG_SND_SEQ_VIRMIDI=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_DRIVERS=y
CONFIG_SND_PCSP=m
CONFIG_SND_DUMMY=m
CONFIG_SND_ALOOP=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
# CONFIG_SND_MTS64 is not set
# CONFIG_SND_SERIAL_U16550 is not set
CONFIG_SND_MPU401=m
# CONFIG_SND_PORTMAN2X4 is not set
CONFIG_SND_AC97_POWER_SAVE=y
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=5
CONFIG_SND_PCI=y
CONFIG_SND_AD1889=m
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
CONFIG_SND_ALI5451=m
CONFIG_SND_ASIHPI=m
CONFIG_SND_ATIIXP=m
CONFIG_SND_ATIIXP_MODEM=m
CONFIG_SND_AU8810=m
CONFIG_SND_AU8820=m
CONFIG_SND_AU8830=m
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
CONFIG_SND_BT87X=m
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=m
CONFIG_SND_CMIPCI=m
CONFIG_SND_OXYGEN_LIB=m
CONFIG_SND_OXYGEN=m
# CONFIG_SND_CS4281 is not set
CONFIG_SND_CS46XX=m
CONFIG_SND_CS46XX_NEW_DSP=y
CONFIG_SND_CTXFI=m
CONFIG_SND_DARLA20=m
CONFIG_SND_GINA20=m
CONFIG_SND_LAYLA20=m
CONFIG_SND_DARLA24=m
CONFIG_SND_GINA24=m
CONFIG_SND_LAYLA24=m
CONFIG_SND_MONA=m
CONFIG_SND_MIA=m
CONFIG_SND_ECHO3G=m
CONFIG_SND_INDIGO=m
CONFIG_SND_INDIGOIO=m
CONFIG_SND_INDIGODJ=m
CONFIG_SND_INDIGOIOX=m
CONFIG_SND_INDIGODJX=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_EMU10K1_SEQ=m
CONFIG_SND_EMU10K1X=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
# CONFIG_SND_ES1938 is not set
CONFIG_SND_ES1968=m
CONFIG_SND_ES1968_INPUT=y
CONFIG_SND_ES1968_RADIO=y
# CONFIG_SND_FM801 is not set
CONFIG_SND_HDSP=m
CONFIG_SND_HDSPM=m
CONFIG_SND_ICE1712=m
CONFIG_SND_ICE1724=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_INTEL8X0M=m
CONFIG_SND_KORG1212=m
CONFIG_SND_LOLA=m
CONFIG_SND_LX6464ES=m
CONFIG_SND_MAESTRO3=m
CONFIG_SND_MAESTRO3_INPUT=y
CONFIG_SND_MIXART=m
# CONFIG_SND_NM256 is not set
CONFIG_SND_PCXHR=m
# CONFIG_SND_RIPTIDE is not set
CONFIG_SND_RME32=m
CONFIG_SND_RME96=m
CONFIG_SND_RME9652=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_TRIDENT=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRTUOSO=m
CONFIG_SND_VX222=m
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
CONFIG_SND_HDA=m
CONFIG_SND_HDA_INTEL=m
# CONFIG_SND_HDA_INTEL_DETECT_DMIC is not set
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=0
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=m
CONFIG_SND_HDA_CODEC_ANALOG=m
CONFIG_SND_HDA_CODEC_SIGMATEL=m
CONFIG_SND_HDA_CODEC_VIA=m
CONFIG_SND_HDA_CODEC_HDMI=m
CONFIG_SND_HDA_CODEC_CIRRUS=m
CONFIG_SND_HDA_CODEC_CONEXANT=m
CONFIG_SND_HDA_CODEC_CA0110=m
CONFIG_SND_HDA_CODEC_CA0132=m
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=m
CONFIG_SND_HDA_CODEC_SI3054=m
CONFIG_SND_HDA_GENERIC=m
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
# end of HD-Audio

CONFIG_SND_HDA_CORE=m
CONFIG_SND_HDA_DSP_LOADER=y
CONFIG_SND_HDA_COMPONENT=y
CONFIG_SND_HDA_I915=y
CONFIG_SND_HDA_EXT_CORE=m
CONFIG_SND_HDA_PREALLOC_SIZE=512
CONFIG_SND_INTEL_NHLT=m
# CONFIG_SND_SPI is not set
CONFIG_SND_USB=y
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=y
CONFIG_SND_USB_UA101=m
CONFIG_SND_USB_USX2Y=m
CONFIG_SND_USB_CAIAQ=m
CONFIG_SND_USB_CAIAQ_INPUT=y
CONFIG_SND_USB_US122L=m
CONFIG_SND_USB_6FIRE=m
CONFIG_SND_USB_HIFACE=m
CONFIG_SND_BCD2000=m
CONFIG_SND_USB_LINE6=m
CONFIG_SND_USB_POD=m
CONFIG_SND_USB_PODHD=m
CONFIG_SND_USB_TONEPORT=m
CONFIG_SND_USB_VARIAX=m
CONFIG_SND_FIREWIRE=y
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_SND_DICE is not set
# CONFIG_SND_OXFW is not set
CONFIG_SND_ISIGHT=m
# CONFIG_SND_FIREWORKS is not set
# CONFIG_SND_BEBOB is not set
# CONFIG_SND_FIREWIRE_DIGI00X is not set
# CONFIG_SND_FIREWIRE_TASCAM is not set
# CONFIG_SND_FIREWIRE_MOTU is not set
# CONFIG_SND_FIREFACE is not set
CONFIG_SND_SOC=m
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_TOPOLOGY=y
CONFIG_SND_SOC_ACPI=m
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

# CONFIG_SND_I2S_HI6210_I2S is not set
# CONFIG_SND_SOC_IMG is not set
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=y
CONFIG_SND_SST_IPC=m
CONFIG_SND_SST_IPC_ACPI=m
CONFIG_SND_SOC_INTEL_SST_ACPI=m
CONFIG_SND_SOC_INTEL_SST=m
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=m
CONFIG_SND_SOC_INTEL_HASWELL=m
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=m
# CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI is not set
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=m
CONFIG_SND_SOC_INTEL_SKYLAKE=m
CONFIG_SND_SOC_INTEL_SKL=m
CONFIG_SND_SOC_INTEL_APL=m
CONFIG_SND_SOC_INTEL_KBL=m
CONFIG_SND_SOC_INTEL_GLK=m
CONFIG_SND_SOC_INTEL_CNL=m
CONFIG_SND_SOC_INTEL_CFL=m
# CONFIG_SND_SOC_INTEL_CML_H is not set
# CONFIG_SND_SOC_INTEL_CML_LP is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=m
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=m
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=m
CONFIG_SND_SOC_ACPI_INTEL_MATCH=m
CONFIG_SND_SOC_INTEL_MACH=y
CONFIG_SND_SOC_INTEL_HASWELL_MACH=m
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=m
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=m
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=m
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=m
# CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH is not set
# CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH is not set
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=m
CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH=m
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=m
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=m
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=m
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=m
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=m
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH is not set
# CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH is not set
# CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH is not set
# CONFIG_SND_SOC_MTK_BTCVSD is not set
# CONFIG_SND_SOC_SOF_TOPLEVEL is not set

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

# CONFIG_SND_SOC_XILINX_I2S is not set
# CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
# CONFIG_ZX_TDM is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
# CONFIG_SND_SOC_ADAU1761_SPI is not set
# CONFIG_SND_SOC_ADAU7002 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4118 is not set
# CONFIG_SND_SOC_AK4458 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4613 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_AK5558 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_BD28623 is not set
# CONFIG_SND_SOC_BT_SCO is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS35L33 is not set
# CONFIG_SND_SOC_CS35L34 is not set
# CONFIG_SND_SOC_CS35L35 is not set
# CONFIG_SND_SOC_CS35L36 is not set
# CONFIG_SND_SOC_CS42L42 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS43130 is not set
# CONFIG_SND_SOC_CS4341 is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_CS53L30 is not set
# CONFIG_SND_SOC_CX2072X is not set
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DA7219=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
# CONFIG_SND_SOC_ES7241 is not set
CONFIG_SND_SOC_ES8316=m
# CONFIG_SND_SOC_ES8328_I2C is not set
# CONFIG_SND_SOC_ES8328_SPI is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_HDAC_HDMI=m
# CONFIG_SND_SOC_INNO_RK3036 is not set
# CONFIG_SND_SOC_MAX98088 is not set
CONFIG_SND_SOC_MAX98090=m
CONFIG_SND_SOC_MAX98357A=m
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98373 is not set
# CONFIG_SND_SOC_MAX9860 is not set
# CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM179X_SPI is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
# CONFIG_SND_SOC_PCM186X_SPI is not set
# CONFIG_SND_SOC_PCM3060_I2C is not set
# CONFIG_SND_SOC_PCM3060_SPI is not set
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM3168A_SPI is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RK3328 is not set
CONFIG_SND_SOC_RL6231=m
CONFIG_SND_SOC_RL6347A=m
CONFIG_SND_SOC_RT286=m
CONFIG_SND_SOC_RT298=m
CONFIG_SND_SOC_RT5514=m
CONFIG_SND_SOC_RT5514_SPI=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5645=m
CONFIG_SND_SOC_RT5651=m
CONFIG_SND_SOC_RT5663=m
CONFIG_SND_SOC_RT5670=m
CONFIG_SND_SOC_RT5677=m
CONFIG_SND_SOC_RT5677_SPI=m
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2305 is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TAS5720 is not set
# CONFIG_SND_SOC_TAS6424 is not set
# CONFIG_SND_SOC_TDA7419 is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
# CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
CONFIG_SND_SOC_TS3A227E=m
# CONFIG_SND_SOC_TSCS42XX is not set
# CONFIG_SND_SOC_TSCS454 is not set
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8524 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8782 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8960 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8974 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_WM8985 is not set
# CONFIG_SND_SOC_ZX_AUD96P22 is not set
# CONFIG_SND_SOC_MAX9759 is not set
# CONFIG_SND_SOC_MT6351 is not set
# CONFIG_SND_SOC_MT6358 is not set
# CONFIG_SND_SOC_NAU8540 is not set
# CONFIG_SND_SOC_NAU8810 is not set
# CONFIG_SND_SOC_NAU8822 is not set
CONFIG_SND_SOC_NAU8824=m
CONFIG_SND_SOC_NAU8825=m
# CONFIG_SND_SOC_TPA6130A2 is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
CONFIG_SND_X86=y
CONFIG_HDMI_LPE_AUDIO=m
CONFIG_SND_SYNTH_EMUX=m
# CONFIG_SND_XEN_FRONTEND is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=y
CONFIG_HID_BATTERY_STRENGTH=y
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACCUTOUCH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=y
CONFIG_HID_APPLEIR=m
# CONFIG_HID_ASUS is not set
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
# CONFIG_HID_BIGBEN_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_CORSAIR is not set
# CONFIG_HID_COUGAR is not set
# CONFIG_HID_MACALLY is not set
CONFIG_HID_PRODIKEYS=m
# CONFIG_HID_CMEDIA is not set
# CONFIG_HID_CP2112 is not set
# CONFIG_HID_CREATIVE_SB0540 is not set
CONFIG_HID_CYPRESS=y
CONFIG_HID_DRAGONRISE=m
# CONFIG_DRAGONRISE_FF is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELAN is not set
CONFIG_HID_ELECOM=m
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_GFRM is not set
CONFIG_HID_HOLTEK=m
# CONFIG_HOLTEK_FF is not set
# CONFIG_HID_GT683R is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_UCLOGIC=m
CONFIG_HID_WALTOP=m
# CONFIG_HID_VIEWSONIC is not set
CONFIG_HID_GYRATION=m
CONFIG_HID_ICADE=m
CONFIG_HID_ITE=y
# CONFIG_HID_JABRA is not set
CONFIG_HID_TWINHAN=m
CONFIG_HID_KENSINGTON=y
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
CONFIG_HID_LOGITECH_DJ=m
CONFIG_HID_LOGITECH_HIDPP=m
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
CONFIG_HID_MAGICMOUSE=y
# CONFIG_HID_MALTRON is not set
# CONFIG_HID_MAYFLASH is not set
CONFIG_HID_REDRAGON=y
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
CONFIG_HID_MULTITOUCH=m
# CONFIG_HID_NTI is not set
CONFIG_HID_NTRIG=y
CONFIG_HID_ORTEK=m
CONFIG_HID_PANTHERLORD=m
# CONFIG_PANTHERLORD_FF is not set
# CONFIG_HID_PENMOUNT is not set
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
CONFIG_HID_PICOLCD_FB=y
CONFIG_HID_PICOLCD_BACKLIGHT=y
CONFIG_HID_PICOLCD_LCD=y
CONFIG_HID_PICOLCD_LEDS=y
CONFIG_HID_PICOLCD_CIR=y
CONFIG_HID_PLANTRONICS=y
CONFIG_HID_PRIMAX=m
# CONFIG_HID_RETRODE is not set
CONFIG_HID_ROCCAT=m
CONFIG_HID_SAITEK=m
CONFIG_HID_SAMSUNG=m
CONFIG_HID_SONY=m
# CONFIG_SONY_FF is not set
CONFIG_HID_SPEEDLINK=m
# CONFIG_HID_STEAM is not set
CONFIG_HID_STEELSERIES=m
CONFIG_HID_SUNPLUS=m
CONFIG_HID_RMI=m
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_HYPERV_MOUSE=m
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
CONFIG_HID_TIVO=m
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_THRUSTMASTER=m
# CONFIG_THRUSTMASTER_FF is not set
# CONFIG_HID_UDRAW_PS3 is not set
# CONFIG_HID_U2FZERO is not set
CONFIG_HID_WACOM=m
CONFIG_HID_WIIMOTE=m
# CONFIG_HID_XINMO is not set
CONFIG_HID_ZEROPLUS=m
# CONFIG_ZEROPLUS_FF is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=y
CONFIG_HID_PID=y
CONFIG_USB_HIDDEV=y
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=m
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=y
# CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
# CONFIG_USB_LED_TRIG is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_PCI=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=m
CONFIG_USB_AUTOSUSPEND_DELAY=2
CONFIG_USB_MON=y

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=y
# CONFIG_USB_XHCI_PLATFORM is not set
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_PCI=y
# CONFIG_USB_EHCI_FSL is not set
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_HCD_PCI=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
CONFIG_USB_UHCI_HCD=y
# CONFIG_USB_U132_HCD is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_BCMA is not set
# CONFIG_USB_HCD_SSB is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_WDM=m
CONFIG_USB_TMC=m

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=m
CONFIG_REALTEK_AUTOPM=y
CONFIG_USB_STORAGE_DATAFAB=m
CONFIG_USB_STORAGE_FREECOM=m
CONFIG_USB_STORAGE_ISD200=m
CONFIG_USB_STORAGE_USBAT=m
CONFIG_USB_STORAGE_SDDR09=m
CONFIG_USB_STORAGE_SDDR55=m
CONFIG_USB_STORAGE_JUMPSHOT=m
CONFIG_USB_STORAGE_ALAUDA=m
CONFIG_USB_STORAGE_ONETOUCH=m
CONFIG_USB_STORAGE_KARMA=m
CONFIG_USB_STORAGE_CYPRESS_ATACB=m
CONFIG_USB_STORAGE_ENE_UB6250=m
CONFIG_USB_UAS=m

#
# USB Imaging devices
#
CONFIG_USB_MDC800=m
CONFIG_USB_MICROTEK=m
CONFIG_USBIP_CORE=m
# CONFIG_USBIP_VHCI_HCD is not set
# CONFIG_USBIP_HOST is not set
# CONFIG_USBIP_DEBUG is not set
# CONFIG_USB_CDNS3 is not set
# CONFIG_USB_MUSB_HDRC is not set
# CONFIG_USB_DWC3 is not set
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
CONFIG_USB_USS720=m
CONFIG_USB_SERIAL=y
CONFIG_USB_SERIAL_CONSOLE=y
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_SIMPLE is not set
CONFIG_USB_SERIAL_AIRCABLE=m
CONFIG_USB_SERIAL_ARK3116=m
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_CH341=m
CONFIG_USB_SERIAL_WHITEHEAT=m
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=m
CONFIG_USB_SERIAL_CP210X=m
CONFIG_USB_SERIAL_CYPRESS_M8=m
CONFIG_USB_SERIAL_EMPEG=m
CONFIG_USB_SERIAL_FTDI_SIO=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_USB_SERIAL_IR=m
CONFIG_USB_SERIAL_EDGEPORT=m
CONFIG_USB_SERIAL_EDGEPORT_TI=m
# CONFIG_USB_SERIAL_F81232 is not set
# CONFIG_USB_SERIAL_F8153X is not set
CONFIG_USB_SERIAL_GARMIN=m
CONFIG_USB_SERIAL_IPW=m
CONFIG_USB_SERIAL_IUU=m
CONFIG_USB_SERIAL_KEYSPAN_PDA=m
CONFIG_USB_SERIAL_KEYSPAN=m
CONFIG_USB_SERIAL_KLSI=m
CONFIG_USB_SERIAL_KOBIL_SCT=m
CONFIG_USB_SERIAL_MCT_U232=m
# CONFIG_USB_SERIAL_METRO is not set
CONFIG_USB_SERIAL_MOS7720=m
CONFIG_USB_SERIAL_MOS7715_PARPORT=y
CONFIG_USB_SERIAL_MOS7840=m
# CONFIG_USB_SERIAL_MXUPORT is not set
CONFIG_USB_SERIAL_NAVMAN=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_USB_SERIAL_OTI6858=m
CONFIG_USB_SERIAL_QCAUX=m
CONFIG_USB_SERIAL_QUALCOMM=m
CONFIG_USB_SERIAL_SPCP8X5=m
CONFIG_USB_SERIAL_SAFE=m
CONFIG_USB_SERIAL_SAFE_PADDED=y
CONFIG_USB_SERIAL_SIERRAWIRELESS=m
CONFIG_USB_SERIAL_SYMBOL=m
# CONFIG_USB_SERIAL_TI is not set
CONFIG_USB_SERIAL_CYBERJACK=m
CONFIG_USB_SERIAL_XIRCOM=m
CONFIG_USB_SERIAL_WWAN=m
CONFIG_USB_SERIAL_OPTION=m
CONFIG_USB_SERIAL_OMNINET=m
CONFIG_USB_SERIAL_OPTICON=m
CONFIG_USB_SERIAL_XSENS_MT=m
# CONFIG_USB_SERIAL_WISHBONE is not set
CONFIG_USB_SERIAL_SSU100=m
CONFIG_USB_SERIAL_QT2=m
# CONFIG_USB_SERIAL_UPD78F0730 is not set
CONFIG_USB_SERIAL_DEBUG=m

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=m
CONFIG_USB_EMI26=m
CONFIG_USB_ADUTUX=m
CONFIG_USB_SEVSEG=m
CONFIG_USB_LEGOTOWER=m
CONFIG_USB_LCD=m
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
CONFIG_USB_IDMOUSE=m
CONFIG_USB_FTDI_ELAN=m
CONFIG_USB_APPLEDISPLAY=m
CONFIG_USB_SISUSBVGA=m
CONFIG_USB_SISUSBVGA_CON=y
CONFIG_USB_LD=m
# CONFIG_USB_TRANCEVIBRATOR is not set
CONFIG_USB_IOWARRIOR=m
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
CONFIG_USB_ISIGHTFW=m
# CONFIG_USB_YUREX is not set
CONFIG_USB_EZUSB_FX2=m
# CONFIG_USB_HUB_USB251XB is not set
CONFIG_USB_HSIC_USB3503=m
# CONFIG_USB_HSIC_USB4604 is not set
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set
CONFIG_USB_ATM=m
CONFIG_USB_SPEEDTOUCH=m
CONFIG_USB_CXACRU=m
CONFIG_USB_UEAGLEATM=m
CONFIG_USB_XUSBATM=m

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
CONFIG_TYPEC=y
# CONFIG_TYPEC_TCPM is not set
CONFIG_TYPEC_UCSI=y
# CONFIG_UCSI_CCG is not set
CONFIG_UCSI_ACPI=y
# CONFIG_TYPEC_TPS6598X is not set

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
# CONFIG_TYPEC_MUX_PI3USB30532 is not set
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
# CONFIG_TYPEC_DP_ALTMODE is not set
# end of USB Type-C Alternate Mode drivers

# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=m
CONFIG_MMC_BLOCK=m
CONFIG_MMC_BLOCK_MINORS=8
CONFIG_SDIO_UART=m
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
CONFIG_MMC_SDHCI_IO_ACCESSORS=y
CONFIG_MMC_SDHCI_PCI=m
CONFIG_MMC_RICOH_MMC=y
CONFIG_MMC_SDHCI_ACPI=m
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
CONFIG_MMC_TIFM_SD=m
# CONFIG_MMC_SPI is not set
CONFIG_MMC_CB710=m
CONFIG_MMC_VIA_SDMMC=m
CONFIG_MMC_VUB300=m
CONFIG_MMC_USHC=m
# CONFIG_MMC_USDHI6ROL0 is not set
CONFIG_MMC_CQHCI=m
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MMC_SDHCI_XENON is not set
CONFIG_MEMSTICK=m
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=m
# CONFIG_MS_BLOCK is not set

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=m
CONFIG_MEMSTICK_JMICRON_38X=m
CONFIG_MEMSTICK_R592=m
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
# CONFIG_LEDS_CLASS_FLASH is not set
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
# CONFIG_LEDS_APU is not set
CONFIG_LEDS_LM3530=m
# CONFIG_LEDS_LM3532 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP55XX_COMMON=m
CONFIG_LEDS_LP5521=m
CONFIG_LEDS_LP5523=m
CONFIG_LEDS_LP5562=m
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_CLEVO_MAIL=m
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_BD2802 is not set
CONFIG_LEDS_INTEL_SS4200=m
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_LM355x is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
CONFIG_LEDS_BLINKM=m
# CONFIG_LEDS_MLXCPLD is not set
# CONFIG_LEDS_MLXREG is not set
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
# CONFIG_LEDS_TI_LMU_COMMON is not set

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=y
CONFIG_LEDS_TRIGGER_TIMER=m
CONFIG_LEDS_TRIGGER_ONESHOT=m
# CONFIG_LEDS_TRIGGER_DISK is not set
# CONFIG_LEDS_TRIGGER_MTD is not set
CONFIG_LEDS_TRIGGER_HEARTBEAT=m
CONFIG_LEDS_TRIGGER_BACKLIGHT=m
# CONFIG_LEDS_TRIGGER_CPU is not set
# CONFIG_LEDS_TRIGGER_ACTIVITY is not set
CONFIG_LEDS_TRIGGER_GPIO=m
CONFIG_LEDS_TRIGGER_DEFAULT_ON=m

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=m
CONFIG_LEDS_TRIGGER_CAMERA=m
# CONFIG_LEDS_TRIGGER_PANIC is not set
# CONFIG_LEDS_TRIGGER_NETDEV is not set
# CONFIG_LEDS_TRIGGER_PATTERN is not set
CONFIG_LEDS_TRIGGER_AUDIO=m
# CONFIG_ACCESSIBILITY is not set
# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_EDAC=y
CONFIG_EDAC_LEGACY_SYSFS=y
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=m
CONFIG_EDAC_GHES=y
CONFIG_EDAC_AMD64=m
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=m
CONFIG_EDAC_I82975X=m
CONFIG_EDAC_I3000=m
CONFIG_EDAC_I3200=m
CONFIG_EDAC_IE31200=m
CONFIG_EDAC_X38=m
CONFIG_EDAC_I5400=m
CONFIG_EDAC_I7CORE=m
CONFIG_EDAC_I5000=m
CONFIG_EDAC_I5100=m
CONFIG_EDAC_I7300=m
CONFIG_EDAC_SBRIDGE=m
CONFIG_EDAC_SKX=m
# CONFIG_EDAC_I10NM is not set
CONFIG_EDAC_PND2=m
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
# CONFIG_RTC_SYSTOHC is not set
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABEOZ9 is not set
# CONFIG_RTC_DRV_ABX80X is not set
CONFIG_RTC_DRV_DS1307=m
# CONFIG_RTC_DRV_DS1307_CENTURY is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
CONFIG_RTC_DRV_RS5C372=m
CONFIG_RTC_DRV_ISL1208=m
CONFIG_RTC_DRV_ISL12022=m
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
CONFIG_RTC_DRV_PCF8583=m
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
CONFIG_RTC_DRV_BQ32K=m
# CONFIG_RTC_DRV_S35390A is not set
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
# CONFIG_RTC_DRV_RV3028 is not set
# CONFIG_RTC_DRV_RV8803 is not set
# CONFIG_RTC_DRV_SD3078 is not set

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1302 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6916 is not set
# CONFIG_RTC_DRV_R9701 is not set
CONFIG_RTC_DRV_RX4581=m
# CONFIG_RTC_DRV_RX6110 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_MCP795 is not set
CONFIG_RTC_I2C_AND_SPI=y

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=m
CONFIG_RTC_DRV_DS3232_HWMON=y
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=m
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=m
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=m
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=m
CONFIG_RTC_DRV_M48T59=m
CONFIG_RTC_DRV_MSM6242=m
CONFIG_RTC_DRV_BQ4802=m
CONFIG_RTC_DRV_RP5C01=m
CONFIG_RTC_DRV_V3020=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_VIRTUAL_CHANNELS=y
CONFIG_DMA_ACPI=y
# CONFIG_ALTERA_MSGDMA is not set
# CONFIG_INTEL_IDMA64 is not set
CONFIG_INTEL_IOATDMA=m
# CONFIG_QCOM_HIDMA_MGMT is not set
# CONFIG_QCOM_HIDMA is not set
CONFIG_DW_DMAC_CORE=y
CONFIG_DW_DMAC=m
CONFIG_DW_DMAC_PCI=y
# CONFIG_DW_EDMA is not set
# CONFIG_DW_EDMA_PCIE is not set
CONFIG_HSU_DMA=y

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=y
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=y

#
# DMABUF options
#
CONFIG_SYNC_FILE=y
CONFIG_SW_SYNC=y
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_SELFTESTS is not set
# end of DMABUF options

CONFIG_DCA=m
CONFIG_AUXDISPLAY=y
# CONFIG_HD44780 is not set
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_PARPORT_PANEL is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=y
# CONFIG_PANEL is not set
CONFIG_UIO=m
CONFIG_UIO_CIF=m
CONFIG_UIO_PDRV_GENIRQ=m
# CONFIG_UIO_DMEM_GENIRQ is not set
CONFIG_UIO_AEC=m
CONFIG_UIO_SERCOS3=m
CONFIG_UIO_PCI_GENERIC=m
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_UIO_HV_GENERIC=m
CONFIG_VFIO_IOMMU_TYPE1=m
CONFIG_VFIO_VIRQFD=m
CONFIG_VFIO=m
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI=m
# CONFIG_VFIO_PCI_VGA is not set
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI_IGD is not set
CONFIG_VFIO_MDEV=m
CONFIG_VFIO_MDEV_DEVICE=m
CONFIG_IRQ_BYPASS_MANAGER=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_PCI_LEGACY=y
# CONFIG_VIRTIO_PMEM is not set
CONFIG_VIRTIO_BALLOON=y
CONFIG_VIRTIO_INPUT=m
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=m
CONFIG_HYPERV_TIMER=y
CONFIG_HYPERV_UTILS=m
CONFIG_HYPERV_BALLOON=m
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=y
# CONFIG_XEN_BALLOON_MEMORY_HOTPLUG is not set
CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
CONFIG_XEN_DEV_EVTCHN=m
# CONFIG_XEN_BACKEND is not set
CONFIG_XENFS=m
CONFIG_XEN_COMPAT_XENFS=y
CONFIG_XEN_SYS_HYPERVISOR=y
CONFIG_XEN_XENBUS_FRONTEND=y
# CONFIG_XEN_GNTDEV is not set
# CONFIG_XEN_GRANT_DEV_ALLOC is not set
# CONFIG_XEN_GRANT_DMA_ALLOC is not set
CONFIG_SWIOTLB_XEN=y
# CONFIG_XEN_PVCALLS_FRONTEND is not set
CONFIG_XEN_PRIVCMD=m
CONFIG_XEN_HAVE_PVMMU=y
CONFIG_XEN_EFI=y
CONFIG_XEN_AUTO_XLATE=y
CONFIG_XEN_ACPI=y
CONFIG_XEN_HAVE_VPMU=y
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=y
# CONFIG_PRISM2_USB is not set
# CONFIG_COMEDI is not set
# CONFIG_RTL8192U is not set
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_RTL8192E=m
# CONFIG_RTL8723BS is not set
CONFIG_R8712U=m
# CONFIG_R8188EU is not set
# CONFIG_RTS5208 is not set
# CONFIG_VT6655 is not set
# CONFIG_VT6656 is not set

#
# IIO staging drivers
#

#
# Accelerometers
#
# CONFIG_ADIS16203 is not set
# CONFIG_ADIS16240 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7816 is not set
# CONFIG_AD7192 is not set
# CONFIG_AD7280 is not set
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
# CONFIG_ADT7316 is not set
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
# CONFIG_AD7150 is not set
# CONFIG_AD7746 is not set
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
# CONFIG_AD9832 is not set
# CONFIG_AD9834 is not set
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
# CONFIG_AD5933 is not set
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
# CONFIG_ADE7854 is not set
# end of Active energy metering IC

#
# Resolver to digital converters
#
# CONFIG_AD2S1210 is not set
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
# CONFIG_SPEAKUP is not set
# end of Speakup console speech

# CONFIG_STAGING_MEDIA is not set

#
# Android
#
# CONFIG_ASHMEM is not set
# CONFIG_ANDROID_VSOC is not set
CONFIG_ION=y
CONFIG_ION_SYSTEM_HEAP=y
# CONFIG_ION_CMA_HEAP is not set
# end of Android

# CONFIG_LTE_GDM724X is not set
CONFIG_FIREWIRE_SERIAL=m
CONFIG_FWTTY_MAX_TOTAL_PORTS=64
CONFIG_FWTTY_MAX_CARD_PORTS=32
# CONFIG_GS_FPGABOOT is not set
# CONFIG_UNISYSSPAR is not set
# CONFIG_WILC1000_SDIO is not set
# CONFIG_WILC1000_SPI is not set
# CONFIG_MOST is not set
# CONFIG_KS7010 is not set
# CONFIG_PI433 is not set

#
# Gasket devices
#
# CONFIG_STAGING_GASKET_FRAMEWORK is not set
# end of Gasket devices

# CONFIG_FIELDBUS_DEV is not set
# CONFIG_KPC2000 is not set

#
# ISDN CAPI drivers
#
CONFIG_CAPI_AVM=y
CONFIG_ISDN_DRV_AVMB1_B1PCI=m
CONFIG_ISDN_DRV_AVMB1_B1PCIV4=y
CONFIG_ISDN_DRV_AVMB1_T1PCI=m
CONFIG_ISDN_DRV_AVMB1_C4=m
CONFIG_ISDN_DRV_GIGASET=m
CONFIG_GIGASET_CAPI=y
CONFIG_GIGASET_BASE=m
CONFIG_GIGASET_M105=m
CONFIG_GIGASET_M101=m
# CONFIG_GIGASET_DEBUG is not set
CONFIG_HYSDN=m
CONFIG_HYSDN_CAPI=y
# end of ISDN CAPI drivers

CONFIG_USB_WUSB=m
CONFIG_USB_WUSB_CBAF=m
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
# CONFIG_USB_WHCI_HCD is not set
CONFIG_USB_HWA_HCD=m
CONFIG_UWB=m
CONFIG_UWB_HWA=m
CONFIG_UWB_WHCI=m
CONFIG_UWB_I1480U=m
# CONFIG_EXFAT_FS is not set
CONFIG_QLGE=m
CONFIG_X86_PLATFORM_DEVICES=y
CONFIG_ACER_WMI=m
# CONFIG_ACER_WIRELESS is not set
CONFIG_ACERHDF=m
# CONFIG_ALIENWARE_WMI is not set
CONFIG_ASUS_LAPTOP=m
CONFIG_DCDBAS=m
CONFIG_DELL_SMBIOS=m
CONFIG_DELL_SMBIOS_WMI=y
CONFIG_DELL_SMBIOS_SMM=y
CONFIG_DELL_LAPTOP=m
CONFIG_DELL_WMI=m
CONFIG_DELL_WMI_DESCRIPTOR=m
CONFIG_DELL_WMI_AIO=m
# CONFIG_DELL_WMI_LED is not set
CONFIG_DELL_SMO8800=m
CONFIG_DELL_RBTN=m
CONFIG_DELL_RBU=m
CONFIG_FUJITSU_LAPTOP=m
CONFIG_FUJITSU_TABLET=m
CONFIG_AMILO_RFKILL=m
# CONFIG_GPD_POCKET_FAN is not set
CONFIG_HP_ACCEL=m
CONFIG_HP_WIRELESS=m
CONFIG_HP_WMI=m
# CONFIG_LG_LAPTOP is not set
CONFIG_MSI_LAPTOP=m
CONFIG_PANASONIC_LAPTOP=m
CONFIG_COMPAL_LAPTOP=m
CONFIG_SONY_LAPTOP=m
CONFIG_SONYPI_COMPAT=y
CONFIG_IDEAPAD_LAPTOP=m
# CONFIG_SURFACE3_WMI is not set
CONFIG_THINKPAD_ACPI=m
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=y
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=y
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=y
CONFIG_SENSORS_HDAPS=m
# CONFIG_INTEL_MENLOW is not set
CONFIG_EEEPC_LAPTOP=m
CONFIG_ASUS_WMI=m
CONFIG_ASUS_NB_WMI=m
CONFIG_EEEPC_WMI=m
# CONFIG_ASUS_WIRELESS is not set
CONFIG_ACPI_WMI=m
CONFIG_WMI_BMOF=m
CONFIG_INTEL_WMI_THUNDERBOLT=m
# CONFIG_XIAOMI_WMI is not set
CONFIG_MSI_WMI=m
# CONFIG_PEAQ_WMI is not set
CONFIG_TOPSTAR_LAPTOP=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
CONFIG_ACPI_CMPC=m
# CONFIG_INTEL_INT0002_VGPIO is not set
CONFIG_INTEL_HID_EVENT=m
CONFIG_INTEL_VBTN=m
CONFIG_INTEL_IPS=m
CONFIG_INTEL_PMC_CORE=m
# CONFIG_IBM_RTL is not set
CONFIG_SAMSUNG_LAPTOP=m
CONFIG_MXM_WMI=m
CONFIG_INTEL_OAKTRAIL=m
CONFIG_SAMSUNG_Q10=m
CONFIG_APPLE_GMUX=m
# CONFIG_INTEL_RST is not set
# CONFIG_INTEL_SMARTCONNECT is not set
# CONFIG_INTEL_PMC_IPC is not set
# CONFIG_SURFACE_PRO3_BUTTON is not set
# CONFIG_INTEL_PUNIT_IPC is not set
# CONFIG_MLX_PLATFORM is not set
# CONFIG_INTEL_TURBO_MAX_3 is not set
# CONFIG_I2C_MULTI_INSTANTIATE is not set
# CONFIG_INTEL_ATOMISP2_PM is not set
# CONFIG_HUAWEI_WMI is not set
# CONFIG_PCENGINES_APU2 is not set

#
# Intel Speed Select Technology interface support
#
# CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
# end of Intel Speed Select Technology interface support

CONFIG_PMC_ATOM=y
# CONFIG_MFD_CROS_EC is not set
# CONFIG_CHROME_PLATFORMS is not set
# CONFIG_MELLANOX_PLATFORM is not set
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# end of Common Clock Framework

# CONFIG_HWSPINLOCK is not set

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_I8253_LOCK=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
CONFIG_PCC=y
# CONFIG_ALTERA_MBOX is not set
CONFIG_IOMMU_IOVA=y
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_AMD_IOMMU=y
CONFIG_AMD_IOMMU_V2=m
CONFIG_DMAR_TABLE=y
CONFIG_INTEL_IOMMU=y
# CONFIG_INTEL_IOMMU_SVM is not set
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=y
CONFIG_IRQ_REMAP=y
CONFIG_HYPERV_IOMMU=y

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
# CONFIG_RPMSG_QCOM_GLINK_RPM is not set
# CONFIG_RPMSG_VIRTIO is not set
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

# CONFIG_SOC_TI is not set

#
# Xilinx SoC drivers
#
# CONFIG_XILINX_VCU is not set
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
# CONFIG_DEVFREQ_GOV_PERFORMANCE is not set
# CONFIG_DEVFREQ_GOV_POWERSAVE is not set
# CONFIG_DEVFREQ_GOV_USERSPACE is not set
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
# CONFIG_EXTCON is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
CONFIG_IIO_BUFFER=y
CONFIG_IIO_BUFFER_CB=y
# CONFIG_IIO_BUFFER_HW_CONSUMER is not set
CONFIG_IIO_KFIFO_BUF=y
CONFIG_IIO_TRIGGERED_BUFFER=m
# CONFIG_IIO_CONFIGFS is not set
CONFIG_IIO_TRIGGER=y
CONFIG_IIO_CONSUMERS_PER_TRIGGER=2
# CONFIG_IIO_SW_DEVICE is not set
# CONFIG_IIO_SW_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_ADIS16201 is not set
# CONFIG_ADIS16209 is not set
# CONFIG_ADXL345_I2C is not set
# CONFIG_ADXL345_SPI is not set
# CONFIG_ADXL372_SPI is not set
# CONFIG_ADXL372_I2C is not set
# CONFIG_BMA180 is not set
# CONFIG_BMA220 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_DA280 is not set
# CONFIG_DA311 is not set
# CONFIG_DMARD09 is not set
# CONFIG_DMARD10 is not set
CONFIG_HID_SENSOR_ACCEL_3D=m
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MC3230 is not set
# CONFIG_MMA7455_I2C is not set
# CONFIG_MMA7455_SPI is not set
# CONFIG_MMA7660 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_MXC4005 is not set
# CONFIG_MXC6255 is not set
# CONFIG_SCA3000 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set
# end of Accelerometers

#
# Analog to digital converters
#
# CONFIG_AD7124 is not set
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7606_IFACE_PARALLEL is not set
# CONFIG_AD7606_IFACE_SPI is not set
# CONFIG_AD7766 is not set
# CONFIG_AD7768_1 is not set
# CONFIG_AD7780 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD7949 is not set
# CONFIG_AD799X is not set
# CONFIG_HI8435 is not set
# CONFIG_HX711 is not set
# CONFIG_INA2XX_ADC is not set
# CONFIG_LTC2471 is not set
# CONFIG_LTC2485 is not set
# CONFIG_LTC2497 is not set
# CONFIG_MAX1027 is not set
# CONFIG_MAX11100 is not set
# CONFIG_MAX1118 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MAX9611 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_MCP3911 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC0832 is not set
# CONFIG_TI_ADC084S021 is not set
# CONFIG_TI_ADC12138 is not set
# CONFIG_TI_ADC108S102 is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_TI_ADC161S626 is not set
# CONFIG_TI_ADS1015 is not set
# CONFIG_TI_ADS7950 is not set
# CONFIG_TI_TLC4541 is not set
# CONFIG_VIPERBOARD_ADC is not set
# CONFIG_XILINX_XADC is not set
# end of Analog to digital converters

#
# Analog Front Ends
#
# end of Analog Front Ends

#
# Amplifiers
#
# CONFIG_AD8366 is not set
# end of Amplifiers

#
# Chemical Sensors
#
# CONFIG_ATLAS_PH_SENSOR is not set
# CONFIG_BME680 is not set
# CONFIG_CCS811 is not set
# CONFIG_IAQCORE is not set
# CONFIG_SENSIRION_SGP30 is not set
# CONFIG_SPS30 is not set
# CONFIG_VZ89X is not set
# end of Chemical Sensors

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=m
CONFIG_HID_SENSOR_IIO_TRIGGER=m
# end of Hid Sensor IIO Common

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set
# end of SSP Sensor Common

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5592R is not set
# CONFIG_AD5593R is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_LTC1660 is not set
# CONFIG_LTC2632 is not set
# CONFIG_AD5686_SPI is not set
# CONFIG_AD5696_I2C is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5758 is not set
# CONFIG_AD5761 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_AD8801 is not set
# CONFIG_DS4424 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set
# CONFIG_TI_DAC082S085 is not set
# CONFIG_TI_DAC5571 is not set
# CONFIG_TI_DAC7311 is not set
# CONFIG_TI_DAC7612 is not set
# end of Digital to analog converters

#
# IIO dummy driver
#
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set
# CONFIG_ADF4371 is not set
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_FXAS21002C is not set
CONFIG_HID_SENSOR_GYRO_3D=m
# CONFIG_MPU3050_I2C is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
# CONFIG_AFE4403 is not set
# CONFIG_AFE4404 is not set
# CONFIG_MAX30100 is not set
# CONFIG_MAX30102 is not set
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
# CONFIG_AM2315 is not set
# CONFIG_DHT11 is not set
# CONFIG_HDC100X is not set
# CONFIG_HID_SENSOR_HUMIDITY is not set
# CONFIG_HTS221 is not set
# CONFIG_HTU21 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set
# end of Humidity sensors

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16460 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_BMI160_I2C is not set
# CONFIG_BMI160_SPI is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_I2C is not set
# CONFIG_INV_MPU6050_SPI is not set
# CONFIG_IIO_ST_LSM6DSX is not set
# end of Inertial measurement units

#
# Light sensors
#
# CONFIG_ACPI_ALS is not set
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_APDS9960 is not set
# CONFIG_BH1750 is not set
# CONFIG_BH1780 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_SENSORS_ISL29018 is not set
# CONFIG_SENSORS_ISL29028 is not set
# CONFIG_ISL29125 is not set
CONFIG_HID_SENSOR_ALS=m
CONFIG_HID_SENSOR_PROX=m
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_LV0104CS is not set
# CONFIG_MAX44000 is not set
# CONFIG_MAX44009 is not set
# CONFIG_NOA1305 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_SI1133 is not set
# CONFIG_SI1145 is not set
# CONFIG_STK3310 is not set
# CONFIG_ST_UVIS25 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL2583 is not set
# CONFIG_TSL2772 is not set
# CONFIG_TSL4531 is not set
# CONFIG_US5182D is not set
# CONFIG_VCNL4000 is not set
# CONFIG_VCNL4035 is not set
# CONFIG_VEML6070 is not set
# CONFIG_VL6180 is not set
# CONFIG_ZOPT2201 is not set
# end of Light sensors

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_BMC150_MAGN_I2C is not set
# CONFIG_BMC150_MAGN_SPI is not set
# CONFIG_MAG3110 is not set
CONFIG_HID_SENSOR_MAGNETOMETER_3D=m
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_SENSORS_HMC5843_I2C is not set
# CONFIG_SENSORS_HMC5843_SPI is not set
# CONFIG_SENSORS_RM3100_I2C is not set
# CONFIG_SENSORS_RM3100_SPI is not set
# end of Magnetometer sensors

#
# Multiplexers
#
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=m
CONFIG_HID_SENSOR_DEVICE_ROTATION=m
# end of Inclinometer sensors

#
# Triggers - standalone
#
# CONFIG_IIO_INTERRUPT_TRIGGER is not set
# CONFIG_IIO_SYSFS_TRIGGER is not set
# end of Triggers - standalone

#
# Digital potentiometers
#
# CONFIG_AD5272 is not set
# CONFIG_DS1803 is not set
# CONFIG_MAX5432 is not set
# CONFIG_MAX5481 is not set
# CONFIG_MAX5487 is not set
# CONFIG_MCP4018 is not set
# CONFIG_MCP4131 is not set
# CONFIG_MCP4531 is not set
# CONFIG_MCP41010 is not set
# CONFIG_TPL0102 is not set
# end of Digital potentiometers

#
# Digital potentiostats
#
# CONFIG_LMP91000 is not set
# end of Digital potentiostats

#
# Pressure sensors
#
# CONFIG_ABP060MG is not set
# CONFIG_BMP280 is not set
# CONFIG_DPS310 is not set
CONFIG_HID_SENSOR_PRESS=m
# CONFIG_HP03 is not set
# CONFIG_MPL115_I2C is not set
# CONFIG_MPL115_SPI is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_MS5637 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set
# CONFIG_HP206C is not set
# CONFIG_ZPA2326 is not set
# end of Pressure sensors

#
# Lightning sensors
#
# CONFIG_AS3935 is not set
# end of Lightning sensors

#
# Proximity and distance sensors
#
# CONFIG_ISL29501 is not set
# CONFIG_LIDAR_LITE_V2 is not set
# CONFIG_MB1232 is not set
# CONFIG_RFD77402 is not set
# CONFIG_SRF04 is not set
# CONFIG_SX9500 is not set
# CONFIG_SRF08 is not set
# CONFIG_VL53L0X_I2C is not set
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
# CONFIG_AD2S90 is not set
# CONFIG_AD2S1200 is not set
# end of Resolver to digital converters

#
# Temperature sensors
#
# CONFIG_MAXIM_THERMOCOUPLE is not set
# CONFIG_HID_SENSOR_TEMP is not set
# CONFIG_MLX90614 is not set
# CONFIG_MLX90632 is not set
# CONFIG_TMP006 is not set
# CONFIG_TMP007 is not set
# CONFIG_TSYS01 is not set
# CONFIG_TSYS02D is not set
# CONFIG_MAX31856 is not set
# end of Temperature sensors

CONFIG_NTB=m
# CONFIG_NTB_MSI is not set
CONFIG_NTB_AMD=m
# CONFIG_NTB_IDT is not set
# CONFIG_NTB_INTEL is not set
# CONFIG_NTB_SWITCHTEC is not set
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
CONFIG_NTB_PERF=m
CONFIG_NTB_TRANSPORT=m
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
# CONFIG_PWM_PCA9685 is not set

#
# IRQ chip support
#
# end of IRQ chip support

# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_BCM_KONA_USB2_PHY is not set
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
# CONFIG_PHY_CPCAP_USB is not set
# end of PHY Subsystem

CONFIG_POWERCAP=y
CONFIG_INTEL_RAPL_CORE=m
CONFIG_INTEL_RAPL=m
# CONFIG_IDLE_INJECT is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=y
# CONFIG_RAS_CEC is not set
CONFIG_THUNDERBOLT=y

#
# Android
#
CONFIG_ANDROID=y
# CONFIG_ANDROID_BINDER_IPC is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_BLK=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_ND_PFN=m
CONFIG_NVDIMM_PFN=y
CONFIG_NVDIMM_DAX=y
CONFIG_NVDIMM_KEYS=y
CONFIG_DAX_DRIVER=y
CONFIG_DAX=y
CONFIG_DEV_DAX=m
CONFIG_DEV_DAX_PMEM=m
CONFIG_DEV_DAX_KMEM=m
CONFIG_DEV_DAX_PMEM_COMPAT=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y

#
# HW tracing support
#
# CONFIG_STM is not set
# CONFIG_INTEL_TH is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_PM_OPP=y
# CONFIG_UNISYS_VISORBUS is not set
# CONFIG_SIOX is not set
# CONFIG_SLIMBUS is not set
# CONFIG_INTERCONNECT is not set
# CONFIG_COUNTER is not set
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=m
CONFIG_EXT4_USE_FOR_EXT2=y
CONFIG_EXT4_FS_POSIX_ACL=y
CONFIG_EXT4_FS_SECURITY=y
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=m
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=m
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_XFS_FS=m
CONFIG_XFS_QUOTA=y
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_RT=y
CONFIG_XFS_ONLINE_SCRUB=y
CONFIG_XFS_ONLINE_REPAIR=y
CONFIG_XFS_DEBUG=y
CONFIG_XFS_ASSERT_FATAL=y
CONFIG_GFS2_FS=m
CONFIG_GFS2_FS_LOCKING_DLM=y
CONFIG_OCFS2_FS=m
CONFIG_OCFS2_FS_O2CB=m
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=m
CONFIG_OCFS2_FS_STATS=y
CONFIG_OCFS2_DEBUG_MASKLOG=y
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=m
CONFIG_BTRFS_FS_POSIX_ACL=y
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
# CONFIG_NILFS2_FS is not set
CONFIG_F2FS_FS=m
CONFIG_F2FS_STAT_FS=y
CONFIG_F2FS_FS_XATTR=y
CONFIG_F2FS_FS_POSIX_ACL=y
# CONFIG_F2FS_FS_SECURITY is not set
# CONFIG_F2FS_CHECK_FS is not set
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_FS_DAX=y
CONFIG_FS_DAX_PMD=y
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_EXPORTFS_BLOCK_OPS=y
CONFIG_FILE_LOCKING=y
CONFIG_MANDATORY_FILE_LOCKING=y
CONFIG_FS_ENCRYPTION=y
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_FANOTIFY=y
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
CONFIG_QUOTA=y
CONFIG_QUOTA_NETLINK_INTERFACE=y
CONFIG_PRINT_QUOTA_WARNING=y
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=y
# CONFIG_QFMT_V1 is not set
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_QUOTACTL_COMPAT=y
CONFIG_AUTOFS4_FS=y
CONFIG_AUTOFS_FS=y
CONFIG_FUSE_FS=m
CONFIG_CUSE=m
# CONFIG_VIRTIO_FS is not set
CONFIG_OVERLAY_FS=m
# CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
# CONFIG_OVERLAY_FS_INDEX is not set
# CONFIG_OVERLAY_FS_XINO_AUTO is not set
# CONFIG_OVERLAY_FS_METACOPY is not set

#
# Caches
#
CONFIG_FSCACHE=m
CONFIG_FSCACHE_STATS=y
# CONFIG_FSCACHE_HISTOGRAM is not set
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=m
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_UDF_FS=m
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_NTFS_FS is not set
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
CONFIG_EFIVAR_FS=y
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_ECRYPT_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_UBIFS_FS is not set
CONFIG_CRAMFS=m
CONFIG_CRAMFS_BLOCKDEV=y
# CONFIG_CRAMFS_MTD is not set
CONFIG_SQUASHFS=m
CONFIG_SQUASHFS_FILE_CACHE=y
# CONFIG_SQUASHFS_FILE_DIRECT is not set
CONFIG_SQUASHFS_DECOMP_SINGLE=y
# CONFIG_SQUASHFS_DECOMP_MULTI is not set
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=y
CONFIG_SQUASHFS_ZLIB=y
# CONFIG_SQUASHFS_LZ4 is not set
CONFIG_SQUASHFS_LZO=y
CONFIG_SQUASHFS_XZ=y
# CONFIG_SQUASHFS_ZSTD is not set
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=m
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# CONFIG_PSTORE_LZO_COMPRESS is not set
# CONFIG_PSTORE_LZ4_COMPRESS is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS is not set
# CONFIG_PSTORE_842_COMPRESS is not set
# CONFIG_PSTORE_ZSTD_COMPRESS is not set
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=y
CONFIG_PSTORE_COMPRESS_DEFAULT="deflate"
CONFIG_PSTORE_CONSOLE=y
CONFIG_PSTORE_PMSG=y
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=m
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EROFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
# CONFIG_NFS_V2 is not set
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
CONFIG_NFS_V4_1=y
CONFIG_NFS_V4_2=y
CONFIG_PNFS_FILE_LAYOUT=m
CONFIG_PNFS_BLOCK=m
CONFIG_PNFS_FLEXFILE_LAYOUT=m
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
# CONFIG_NFS_V4_1_MIGRATION is not set
CONFIG_NFS_V4_SECURITY_LABEL=y
CONFIG_ROOT_NFS=y
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DEBUG=y
CONFIG_NFSD=m
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_PNFS=y
# CONFIG_NFSD_BLOCKLAYOUT is not set
CONFIG_NFSD_SCSILAYOUT=y
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_SECURITY_LABEL=y
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_SUNRPC_BACKCHANNEL=y
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
CONFIG_SUNRPC_DEBUG=y
CONFIG_CEPH_FS=m
# CONFIG_CEPH_FSCACHE is not set
CONFIG_CEPH_FS_POSIX_ACL=y
# CONFIG_CEPH_FS_SECURITY_LABEL is not set
CONFIG_CIFS=m
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
CONFIG_CIFS_WEAK_PW_HASH=y
CONFIG_CIFS_UPCALL=y
CONFIG_CIFS_XATTR=y
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=y
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_9P_FS=y
CONFIG_9P_FS_POSIX_ACL=y
# CONFIG_9P_FS_SECURITY is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_MAC_ROMAN=m
CONFIG_NLS_MAC_CELTIC=m
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=m
CONFIG_NLS_MAC_GAELIC=m
CONFIG_NLS_MAC_GREEK=m
CONFIG_NLS_MAC_ICELAND=m
CONFIG_NLS_MAC_INUIT=m
CONFIG_NLS_MAC_ROMANIAN=m
CONFIG_NLS_MAC_TURKISH=m
CONFIG_NLS_UTF8=m
CONFIG_DLM=m
CONFIG_DLM_DEBUG=y
# CONFIG_UNICODE is not set
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_COMPAT=y
# CONFIG_KEYS_REQUEST_CACHE is not set
CONFIG_PERSISTENT_KEYRINGS=y
CONFIG_BIG_KEYS=y
CONFIG_TRUSTED_KEYS=y
CONFIG_ENCRYPTED_KEYS=y
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
CONFIG_SECURITY_WRITABLE_HOOKS=y
CONFIG_SECURITYFS=y
CONFIG_SECURITY_NETWORK=y
CONFIG_PAGE_TABLE_ISOLATION=y
CONFIG_SECURITY_NETWORK_XFRM=y
CONFIG_SECURITY_PATH=y
CONFIG_INTEL_TXT=y
CONFIG_LSM_MMAP_MIN_ADDR=65535
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
CONFIG_HARDENED_USERCOPY=y
CONFIG_HARDENED_USERCOPY_FALLBACK=y
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
# CONFIG_FORTIFY_SOURCE is not set
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=y
CONFIG_SECURITY_SELINUX_BOOTPARAM=y
CONFIG_SECURITY_SELINUX_DISABLE=y
CONFIG_SECURITY_SELINUX_DEVELOP=y
CONFIG_SECURITY_SELINUX_AVC_STATS=y
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=1
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
CONFIG_SECURITY_APPARMOR=y
CONFIG_SECURITY_APPARMOR_HASH=y
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=y
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
CONFIG_INTEGRITY=y
CONFIG_INTEGRITY_SIGNATURE=y
CONFIG_INTEGRITY_ASYMMETRIC_KEYS=y
CONFIG_INTEGRITY_TRUSTED_KEYRING=y
# CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
CONFIG_INTEGRITY_AUDIT=y
CONFIG_IMA=y
CONFIG_IMA_MEASURE_PCR_IDX=10
CONFIG_IMA_LSM_RULES=y
# CONFIG_IMA_TEMPLATE is not set
CONFIG_IMA_NG_TEMPLATE=y
# CONFIG_IMA_SIG_TEMPLATE is not set
CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
CONFIG_IMA_DEFAULT_HASH_SHA1=y
# CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
# CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
CONFIG_IMA_DEFAULT_HASH="sha1"
# CONFIG_IMA_WRITE_POLICY is not set
# CONFIG_IMA_READ_POLICY is not set
CONFIG_IMA_APPRAISE=y
# CONFIG_IMA_ARCH_POLICY is not set
# CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
CONFIG_IMA_APPRAISE_BOOTPARAM=y
# CONFIG_IMA_APPRAISE_MODSIG is not set
CONFIG_IMA_TRUSTED_KEYRING=y
# CONFIG_IMA_BLACKLIST_KEYRING is not set
# CONFIG_IMA_LOAD_X509 is not set
CONFIG_EVM=y
CONFIG_EVM_ATTR_FSUUID=y
# CONFIG_EVM_ADD_XATTRS is not set
# CONFIG_EVM_LOAD_X509 is not set
CONFIG_DEFAULT_SECURITY_SELINUX=y
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_INIT_STACK_NONE=y
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
# CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=m
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=y
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=m
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
CONFIG_CRYPTO_USER=m
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_PCRYPT=m
CONFIG_CRYPTO_CRYPTD=m
CONFIG_CRYPTO_AUTHENC=m
CONFIG_CRYPTO_TEST=m
CONFIG_CRYPTO_SIMD=m
CONFIG_CRYPTO_GLUE_HELPER_X86=m
CONFIG_CRYPTO_ENGINE=m

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
CONFIG_CRYPTO_DH=m
CONFIG_CRYPTO_ECC=m
CONFIG_CRYPTO_ECDH=m
# CONFIG_CRYPTO_ECRDSA is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=y
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_AEGIS128 is not set
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
CONFIG_CRYPTO_SEQIV=y
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CFB is not set
CONFIG_CRYPTO_CTR=y
CONFIG_CRYPTO_CTS=y
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
# CONFIG_CRYPTO_OFB is not set
CONFIG_CRYPTO_PCBC=m
CONFIG_CRYPTO_XTS=y
# CONFIG_CRYPTO_KEYWRAP is not set
# CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
# CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
# CONFIG_CRYPTO_ADIANTUM is not set
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_XCBC=m
CONFIG_CRYPTO_VMAC=m

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
CONFIG_CRYPTO_CRC32C_INTEL=m
CONFIG_CRYPTO_CRC32=m
CONFIG_CRYPTO_CRC32_PCLMUL=m
# CONFIG_CRYPTO_XXHASH is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_GHASH=y
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_POLY1305_X86_64 is not set
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=m
CONFIG_CRYPTO_RMD128=m
CONFIG_CRYPTO_RMD160=m
CONFIG_CRYPTO_RMD256=m
CONFIG_CRYPTO_RMD320=m
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=y
CONFIG_CRYPTO_SHA512_SSSE3=m
CONFIG_CRYPTO_LIB_SHA256=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
# CONFIG_CRYPTO_SHA3 is not set
# CONFIG_CRYPTO_SM3 is not set
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_TGR192=m
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
CONFIG_CRYPTO_AES_NI_INTEL=m
CONFIG_CRYPTO_ANUBIS=m
CONFIG_CRYPTO_LIB_ARC4=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_BLOWFISH_COMMON=m
CONFIG_CRYPTO_BLOWFISH_X86_64=m
CONFIG_CRYPTO_CAMELLIA=m
CONFIG_CRYPTO_CAMELLIA_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=m
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=m
CONFIG_CRYPTO_CAST_COMMON=m
CONFIG_CRYPTO_CAST5=m
CONFIG_CRYPTO_CAST5_AVX_X86_64=m
CONFIG_CRYPTO_CAST6=m
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_LIB_DES=m
CONFIG_CRYPTO_DES=m
# CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_KHAZAD=m
CONFIG_CRYPTO_SALSA20=m
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_CHACHA20_X86_64 is not set
CONFIG_CRYPTO_SEED=m
CONFIG_CRYPTO_SERPENT=m
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX_X86_64=m
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=m
# CONFIG_CRYPTO_SM4 is not set
CONFIG_CRYPTO_TEA=m
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=m
CONFIG_CRYPTO_TWOFISH_X86_64=m
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=y
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
# CONFIG_CRYPTO_ZSTD is not set

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=m
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
CONFIG_CRYPTO_DRBG_HASH=y
CONFIG_CRYPTO_DRBG_CTR=y
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
CONFIG_CRYPTO_USER_API=y
CONFIG_CRYPTO_USER_API_HASH=y
CONFIG_CRYPTO_USER_API_SKCIPHER=y
CONFIG_CRYPTO_USER_API_RNG=m
# CONFIG_CRYPTO_USER_API_AEAD is not set
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
CONFIG_CRYPTO_DEV_PADLOCK_AES=m
CONFIG_CRYPTO_DEV_PADLOCK_SHA=m
# CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
# CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
CONFIG_CRYPTO_DEV_CCP=y
CONFIG_CRYPTO_DEV_CCP_DD=m
CONFIG_CRYPTO_DEV_SP_CCP=y
CONFIG_CRYPTO_DEV_CCP_CRYPTO=m
CONFIG_CRYPTO_DEV_SP_PSP=y
# CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
CONFIG_CRYPTO_DEV_QAT=m
CONFIG_CRYPTO_DEV_QAT_DH895xCC=m
CONFIG_CRYPTO_DEV_QAT_C3XXX=m
CONFIG_CRYPTO_DEV_QAT_C62X=m
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=m
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=m
CONFIG_CRYPTO_DEV_QAT_C62XVF=m
# CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
CONFIG_CRYPTO_DEV_CHELSIO=m
CONFIG_CRYPTO_DEV_VIRTIO=m
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
# CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
CONFIG_X509_CERTIFICATE_PARSER=y
# CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
CONFIG_PKCS7_MESSAGE_PARSER=y
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=y

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY="certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=y
CONFIG_SYSTEM_TRUSTED_KEYS=""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
# CONFIG_SECONDARY_TRUSTED_KEYRING is not set
CONFIG_SYSTEM_BLACKLIST_KEYRING=y
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
CONFIG_RAID6_PQ_BENCHMARK=y
# CONFIG_PACKING is not set
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_FIND_FIRST_BIT=y
CONFIG_CORDIC=m
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC64 is not set
# CONFIG_CRC4 is not set
# CONFIG_CRC7 is not set
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=m
CONFIG_ZSTD_DECOMPRESS=m
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_ENC8=y
CONFIG_REED_SOLOMON_DEC8=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_BTREE=y
CONFIG_INTERVAL_TREE=y
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=y
CONFIG_SWIOTLB=y
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=200
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=y
CONFIG_IOMMU_HELPER=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_CPUMASK_OFFSTACK=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
CONFIG_IRQ_POLL=y
CONFIG_MPILIB=y
CONFIG_SIGNATURE=y
CONFIG_DIMLIB=y
CONFIG_OID_REGISTRY=y
CONFIG_UCS2_STRING=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_FONT_SUPPORT=y
# CONFIG_FONTS is not set
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
CONFIG_ARCH_STACKWALK=y
CONFIG_SBITMAP=y
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
CONFIG_BOOT_PRINTK_DELAY=y
CONFIG_DYNAMIC_DEBUG=y
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_BTF is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=2048
CONFIG_STRIP_ASM_SYMS=y
# CONFIG_READABLE_ASM is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=y
CONFIG_DEBUG_SECTION_MISMATCH=y
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_STACK_VALIDATION=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_MISC=y

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
CONFIG_DEBUG_RODATA_TEST=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_CC_HAS_KASAN_GENERIC=y
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=1
# end of Memory Debugging

CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_DEBUG_SHIRQ=y

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
CONFIG_HARDLOCKUP_DETECTOR=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=1
# CONFIG_DETECT_HUNG_TASK is not set
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Lockups and Hangs

CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# CONFIG_SCHED_STACK_END_CHECK is not set
# CONFIG_DEBUG_TIMEKEEPING is not set

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
CONFIG_WW_MUTEX_SELFTEST=m
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=y
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_TORTURE_TEST=m
CONFIG_RCU_PERF_TEST=m
CONFIG_RCU_TORTURE_TEST=m
CONFIG_RCU_CPU_STALL_TIMEOUT=60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_NOTIFIER_ERROR_INJECTION=m
CONFIG_PM_NOTIFIER_ERROR_INJECT=m
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
# CONFIG_FAILSLAB is not set
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAIL_MAKE_REQUEST=y
# CONFIG_FAIL_IO_TIMEOUT is not set
# CONFIG_FAIL_FUTEX is not set
CONFIG_FAULT_INJECTION_DEBUG_FS=y
# CONFIG_FAIL_FUNCTION is not set
# CONFIG_FAIL_MMC_REQUEST is not set
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
CONFIG_SCHED_TRACER=y
CONFIG_HWLAT_TRACER=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_TRACER_SNAPSHOT=y
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
CONFIG_STACK_TRACER=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_KPROBE_EVENTS=y
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=y
CONFIG_BPF_EVENTS=y
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_FUNCTION_PROFILER=y
# CONFIG_BPF_KPROBE_OVERRIDE is not set
CONFIG_FTRACE_MCOUNT_RECORD=y
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_MMIOTRACE is not set
CONFIG_TRACING_MAP=y
CONFIG_HIST_TRIGGERS=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=m
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
CONFIG_ATOMIC64_SELFTEST=y
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
CONFIG_TEST_STRSCPY=m
# CONFIG_TEST_KSTRTOX is not set
CONFIG_TEST_PRINTF=m
CONFIG_TEST_BITMAP=m
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
CONFIG_TEST_LKM=m
CONFIG_TEST_VMALLOC=m
CONFIG_TEST_USER_COPY=m
CONFIG_TEST_BPF=m
CONFIG_TEST_BLACKHOLE_DEV=m
# CONFIG_FIND_BIT_BENCHMARK is not set
CONFIG_TEST_FIRMWARE=m
CONFIG_TEST_SYSCTL=m
# CONFIG_TEST_UDELAY is not set
CONFIG_TEST_STATIC_KEYS=m
CONFIG_TEST_KMOD=m
# CONFIG_TEST_MEMCAT_P is not set
CONFIG_TEST_LIVEPATCH=m
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
CONFIG_STRICT_DEVMEM=y
# CONFIG_IO_STRICT_DEVMEM is not set
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_X86_PTDUMP is not set
# CONFIG_EFI_PGT_DUMP is not set
# CONFIG_DEBUG_WX is not set
CONFIG_DOUBLEFAULT=y
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
CONFIG_X86_DECODER_SELFTEST=y
CONFIG_IO_DELAY_0X80=y
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=y
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of Kernel hacking

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=job-script

#!/bin/sh

export_top_env()
{
	export suite='will-it-scale'
	export testcase='will-it-scale'
	export category='benchmark'
	export nr_task=96
	export job_origin='/lkp/lkp/.src-20191114-194134/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/will-it-scale-50.yaml'
	export queue_cmdline_keys='branch
commit
queue_at_least_once'
	export queue='validate'
	export testbox='lkp-csl-2ap3'
	export tbox_group='lkp-csl-2ap3'
	export submit_id='5dd360b4e2a89e2d6a05e1cf'
	export job_file='/lkp/jobs/scheduled/lkp-csl-2ap3/will-it-scale-performance-thread-50%-unlink2-ucode=0x500002b-deb-20191119-11626-1dkx125-3.yaml'
	export id='6a7b93e91e3162213345692ad9ecb9a630397e5e'
	export queuer_version='/lkp-src'
	export arch='x86_64'
	export model='Cascade Lake'
	export nr_node=4
	export nr_cpu=192
	export memory='192G'
	export ssd_partitions=
	export rootfs_partition='LABEL=LKP-ROOTFS'
	export kernel_cmdline_hw='acpi_rsdp=0x67f44014'
	export brand='Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz'
	export commit='ad3836e30e6f5f5e97867707b573f2fda5ce444a'
	export need_kconfig_hw='CONFIG_IGB=y
CONFIG_BLK_DEV_NVME'
	export ucode='0x500002b'
	export kconfig='x86_64-rhel-7.6'
	export compiler='gcc-7'
	export rootfs='debian-x86_64-2019-09-23.cgz'
	export enqueue_time='2019-11-19 11:25:43 +0800'
	export _id='5dd360b9e2a89e2d6a05e1d0'
	export _rt='/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a'
	export user='lkp'
	export head_commit='766ab49bc6f7fc3ee53aa55b18a315f1cd9c7296'
	export base_commit='af42d3466bdc8f39806b26f593604fdc54140bcb'
	export branch='linux-devel/devel-hourly-2019111807'
	export result_root='/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/3'
	export scheduler_version='/lkp/lkp/.src-20191118-220541'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/debian/debian-x86_64-2019-09-23.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/jobs/scheduled/lkp-csl-2ap3/will-it-scale-performance-thread-50%-unlink2-ucode=0x500002b-deb-20191119-11626-1dkx125-3.yaml
ARCH=x86_64
kconfig=x86_64-rhel-7.6
branch=linux-devel/devel-hourly-2019111807
commit=ad3836e30e6f5f5e97867707b573f2fda5ce444a
BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/vmlinuz-5.4.0-rc6-00240-gad3836e30e6f5
acpi_rsdp=0x67f44014
max_uptime=1500
RESULT_ROOT=/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/3
LKP_SERVER=inn
nokaslr
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/modules.cgz'
	export bm_initrd='/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/will-it-scale_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/will-it-scale-x86_64-1eef89e-1_2019-11-16.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-10-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-6c9594bdd474-1_2019-11
 -16.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-c582fe4-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-10-09.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export last_kernel='5.4.0-rc5-00140-gfc1adfe306b71'
	export repeat_to=4
	export bad_samples='11861
8482
8954'
	export schedule_notify_address=
	export queue_at_least_once=1
	export kernel='/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/vmlinuz-5.4.0-rc6-00240-gad3836e30e6f5'
	export dequeue_time='2019-11-19 11:38:33 +0800'
	export job_initrd='/lkp/jobs/scheduled/lkp-csl-2ap3/will-it-scale-performance-thread-50%-unlink2-ucode=0x500002b-deb-20191119-11626-1dkx125-3.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_setup $LKP_SRC/setup/cpufreq_governor 'performance'

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper iostat
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-numastat
	run_monitor $LKP_SRC/monitors/wrapper numa-vmstat
	run_monitor $LKP_SRC/monitors/wrapper numa-meminfo
	run_monitor $LKP_SRC/monitors/wrapper proc-vmstat
	run_monitor $LKP_SRC/monitors/wrapper proc-stat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper slabinfo
	run_monitor $LKP_SRC/monitors/wrapper interrupts
	run_monitor $LKP_SRC/monitors/wrapper lock_stat
	run_monitor $LKP_SRC/monitors/wrapper latency_stats
	run_monitor $LKP_SRC/monitors/wrapper softirqs
	run_monitor $LKP_SRC/monitors/one-shot/wrapper bdi_dev_mapping
	run_monitor $LKP_SRC/monitors/wrapper diskstats
	run_monitor $LKP_SRC/monitors/wrapper nfsstat
	run_monitor $LKP_SRC/monitors/wrapper cpuidle
	run_monitor $LKP_SRC/monitors/wrapper cpufreq-stats
	run_monitor $LKP_SRC/monitors/wrapper turbostat
	run_monitor $LKP_SRC/monitors/wrapper sched_debug
	run_monitor $LKP_SRC/monitors/wrapper perf-stat
	run_monitor $LKP_SRC/monitors/wrapper mpstat
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper perf-profile
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test mode='thread' test='unlink2' $LKP_SRC/tests/wrapper will-it-scale
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper will-it-scale
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper iostat
	$LKP_SRC/stats/wrapper vmstat
	$LKP_SRC/stats/wrapper numa-numastat
	$LKP_SRC/stats/wrapper numa-vmstat
	$LKP_SRC/stats/wrapper numa-meminfo
	$LKP_SRC/stats/wrapper proc-vmstat
	$LKP_SRC/stats/wrapper meminfo
	$LKP_SRC/stats/wrapper slabinfo
	$LKP_SRC/stats/wrapper interrupts
	$LKP_SRC/stats/wrapper lock_stat
	$LKP_SRC/stats/wrapper latency_stats
	$LKP_SRC/stats/wrapper softirqs
	$LKP_SRC/stats/wrapper diskstats
	$LKP_SRC/stats/wrapper nfsstat
	$LKP_SRC/stats/wrapper cpuidle
	$LKP_SRC/stats/wrapper turbostat
	$LKP_SRC/stats/wrapper sched_debug
	$LKP_SRC/stats/wrapper perf-stat
	$LKP_SRC/stats/wrapper mpstat
	$LKP_SRC/stats/wrapper perf-profile

	$LKP_SRC/stats/wrapper time will-it-scale.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="job.yaml"

---
suite: will-it-scale
testcase: will-it-scale
category: benchmark
nr_task: 50%
will-it-scale:
  mode: thread
  test: unlink2
job_origin: "/lkp/lkp/.src-20191114-194134/allot/cyclic:p1:linux-devel:devel-hourly/lkp-csl-2ap3/will-it-scale-50.yaml"
queue_cmdline_keys:
- branch
- commit
- queue_at_least_once
queue: bisect
testbox: lkp-csl-2ap3
tbox_group: lkp-csl-2ap3
submit_id: 5dd35a58e2a89e2c8fb053b3
job_file: "/lkp/jobs/scheduled/lkp-csl-2ap3/will-it-scale-performance-thread-50%-unlink2-ucode=0x500002b-debia-20191119-11407-exdkkn-0.yaml"
id: 16584d2913357dab153e218408c4c8b6adc12f1c
queuer_version: "/lkp-src"
arch: x86_64
model: Cascade Lake
nr_node: 4
nr_cpu: 192
memory: 192G
ssd_partitions: 
rootfs_partition: LABEL=LKP-ROOTFS
kernel_cmdline_hw: acpi_rsdp=0x67f44014
brand: Intel(R) Xeon(R) Platinum 9242 CPU @ 2.30GHz
kmsg: 
boot-time: 
iostat: 
heartbeat: 
vmstat: 
numa-numastat: 
numa-vmstat: 
numa-meminfo: 
proc-vmstat: 
proc-stat: 
meminfo: 
slabinfo: 
interrupts: 
lock_stat: 
latency_stats: 
softirqs: 
bdi_dev_mapping: 
diskstats: 
nfsstat: 
cpuidle: 
cpufreq-stats: 
turbostat: 
sched_debug: 
perf-stat: 
mpstat: 
perf-profile: 
cpufreq_governor: performance
commit: ad3836e30e6f5f5e97867707b573f2fda5ce444a
need_kconfig_hw:
- CONFIG_IGB=y
- CONFIG_BLK_DEV_NVME
ucode: '0x500002b'
kconfig: x86_64-rhel-7.6
compiler: gcc-7
rootfs: debian-x86_64-2019-09-23.cgz
enqueue_time: 2019-11-19 10:59:25.229648421 +08:00
_id: 5dd35a58e2a89e2c8fb053b3
_rt: "/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a"
user: lkp
head_commit: 766ab49bc6f7fc3ee53aa55b18a315f1cd9c7296
base_commit: af42d3466bdc8f39806b26f593604fdc54140bcb
branch: linux-devel/devel-hourly-2019111807
result_root: "/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/0"
scheduler_version: "/lkp/lkp/.src-20191118-220541"
LKP_SERVER: inn
max_uptime: 1500
initrd: "/osimage/debian/debian-x86_64-2019-09-23.cgz"
bootloader_append:
- root=/dev/ram0
- user=lkp
- job=/lkp/jobs/scheduled/lkp-csl-2ap3/will-it-scale-performance-thread-50%-unlink2-ucode=0x500002b-debia-20191119-11407-exdkkn-0.yaml
- ARCH=x86_64
- kconfig=x86_64-rhel-7.6
- branch=linux-devel/devel-hourly-2019111807
- commit=ad3836e30e6f5f5e97867707b573f2fda5ce444a
- BOOT_IMAGE=/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/vmlinuz-5.4.0-rc6-00240-gad3836e30e6f5
- acpi_rsdp=0x67f44014
- max_uptime=1500
- RESULT_ROOT=/result/will-it-scale/performance-thread-50%-unlink2-ucode=0x500002b/lkp-csl-2ap3/debian-x86_64-2019-09-23.cgz/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/0
- LKP_SERVER=inn
- nokaslr
- debug
- apic=debug
- sysrq_always_enabled
- rcupdate.rcu_cpu_stall_timeout=100
- net.ifnames=0
- printk.devkmsg=on
- panic=-1
- softlockup_panic=1
- nmi_watchdog=panic
- oops=panic
- load_ramdisk=2
- prompt_ramdisk=0
- drbd.minor_count=8
- systemd.log_level=err
- ignore_loglevel
- console=tty0
- earlyprintk=ttyS0,115200
- console=ttyS0,115200
- vga=normal
- rw
modules_initrd: "/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/modules.cgz"
bm_initrd: "/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/will-it-scale_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/will-it-scale-x86_64-1eef89e-1_2019-11-16.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/mpstat_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/vmstat_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/turbostat_2019-10-11.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/turbostat-x86_64-3.7-4_2019-10-11.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/perf_2019-10-10.cgz,/osimage/pkg/debian-x86_64-2018-04-03.cgz/perf-x86_64-6c9594bdd474-1_2019-11-16.cgz
 ,/osimage/pkg/debian-x86_64-2018-04-03.cgz/sar-x86_64-c582fe4-1_2019-10-10.cgz,/osimage/deps/debian-x86_64-2018-04-03.cgz/hw_2019-10-09.cgz"
lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
site: inn
LKP_CGI_PORT: 80
LKP_CIFS_PORT: 139
oom-killer: 
watchdog: 
last_kernel: 5.4.0-rc8
repeat_to: 2
bad_samples:
- 11861
- 8482
- 8954

#! queue options
schedule_notify_address: 

#! user overrides
queue_at_least_once: 0

#! schedule options
kernel: "/pkg/linux/x86_64-rhel-7.6/gcc-7/ad3836e30e6f5f5e97867707b573f2fda5ce444a/vmlinuz-5.4.0-rc6-00240-gad3836e30e6f5"
dequeue_time: 2019-11-19 11:10:52.420907097 +08:00

#! /lkp/lkp/.src-20191118-220541/include/site/inn

#! runtime status
job_state: finished
loadavg: 73.50 60.67 27.70 1/1300 12588
start_time: '1574133116'
end_time: '1574133417'
version: "/lkp/lkp/.src-20191118-220614:69f5a189:f079678f1-dirty"

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reproduce


for cpu_dir in /sys/devices/system/cpu/cpu[0-9]*
do
	online_file="$cpu_dir"/online
	[ -f "$online_file" ] && [ "$(cat "$online_file")" -eq 0 ] && continue

	file="$cpu_dir"/cpufreq/scaling_governor
	[ -f "$file" ] && echo "performance" > "$file"
done

 "python2" "./runtest.py" "unlink2" "295" "thread" "96"

--ReaqsoxgOBHFXBhH--
