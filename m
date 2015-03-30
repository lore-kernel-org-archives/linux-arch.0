From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Mon, 30 Mar 2015 12:25:12 -0400
Message-ID: <551978E8.30904@hp.com>
References: <20150316131613.720617163@infradead.org> <20150325194739.GK25884@l.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:46873 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbC3QZV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2015 12:25:21 -0400
In-Reply-To: <20150325194739.GK25884@l.oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On 03/25/2015 03:47 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 16, 2015 at 02:16:13PM +0100, Peter Zijlstra wrote:
>> Hi Waiman,
>>
>> As promised; here is the paravirt stuff I did during the trip to BOS last week.
>>
>> All the !paravirt patches are more or less the same as before (the only real
>> change is the copyright lines in the first patch).
>>
>> The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
>> convoluted and I've no real way to test that but it should be stright fwd to
>> make work.
>>
>> I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
>> overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
>> it both booted and survived a hackbench run (perf bench sched messaging -g 20
>> -l 5000).
>>
>> So while the paravirt code isn't the most optimal code ever conceived it does work.
>>
>> Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
>> for the native case, which should greatly reduce the cost of having
>> CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.
> Ah nice. That could be spun out as a seperate patch to optimize the existing
> ticket locks I presume.

The goal is to replace ticket spinlock by queue spinlock. We may not 
want to support 2 different spinlock implementations in the kernel.

>
> Now with the old pv ticketlock code an vCPU would only go to sleep once and
> be woken up when it was its turn. With this new code it is woken up twice
> (and twice it goes to sleep). With an overcommit scenario this would imply
> that we will have at least twice as many VMEXIT as with the previous code.

I did it differently in my PV portion of the qspinlock patch. Instead of 
just waking up the CPU, the new lock holder will check if the new queue 
head has been halted. If so, it will set the slowpath flag for the 
halted queue head in the lock so as to wake it up at unlock time. This 
should eliminate your concern of dong twice as many VMEXIT in an 
overcommitted scenario.

BTW, I did some qspinlock vs. ticketspinlock benchmarks using AIM7 
high_systime workload on a 4-socket IvyBridge-EX system (60 cores, 120 
threads) with some interesting results.

In term of the performance benefit of this patch, I ran the
high_systime workload (which does a lot of fork() and exit())
at various load levels (500, 1000, 1500 and 2000 users) on a
4-socket IvyBridge-EX bare-metal system (60 cores, 120 threads)
with intel_pstate driver and performance scaling governor. The JPM
(jobs/minutes) and execution time results were as follows:

     Kernel          JPM        Execution Time
     ------          ---        --------------
At 500 users:
      3.19        118857.14        26.25s
     3.19-qspinlock    134889.75        23.13s
     % change     +13.5%            -11.9%

At 1000 users:
      3.19        204255.32        30.55s
      3.19-qspinlock    239631.34        26.04s
     % change     +17.3%            -14.8%

At 1500 users:
      3.19        177272.73        52.80s
      3.19-qspinlock    326132.40        28.70s
     % change     +84.0%            -45.6%

At 2000 users:
      3.19        196690.31        63.45s
      3.19-qspinlock    341730.56        36.52s
     % change     +73.7%            -42.4%

It turns out that this workload was causing quite a lot of spinlock
contention in the vanilla 3.19 kernel. The performance advantage of
this patch increases with heavier loads.

With the powersave governor, the JPM data were as follows:

     Users        3.19     3.19-qspinlock      % Change
     -----        ----    --------------      --------
      500      112635.38      132596.69       +17.7%
     1000      171240.40      240369.80       +40.4%
     1500      130507.53      324436.74      +148.6%
     2000      175972.93      341637.01       +94.1%

With the qspinlock patch, there wasn't too much difference in
performance between the 2 scaling governors. Without this patch,
the powersave governor was much slower than the performance governor.

By disabling the intel_pstate driver and use acpi_cpufreq instead,
the benchmark performance (JPM) at 1000 users level for the performance
and ondemand governors were:

       Governor          3.19    3.19-qspinlock       % Change
       --------          ----    --------------       --------
       performance   124949.94       219950.65        +76.0%
       ondemand          4838.90       206690.96        +4171%

The performance was just horrible when there was significant spinlock
contention with the ondemand governor. There was also significant
run-to-run variation.  A second run of the same benchmark gave a result
of 22115 JPMs. With the qspinlock patch, however, the performance was
much more stable under different cpufreq drivers and governors. That
is not the case with the default ticket spinlock implementation.

The %CPU times spent on spinlock contention (from perf) with the
performance governor and the intel_pstate driver were:

   Kernel Function        3.19 kernel    3.19-qspinlock kernel
   ---------------        -----------    ---------------------
At 500 users:
   _raw_spin_lock*          28.23%        2.25%
   queue_spin_lock_slowpath       N/A            4.05%

At 1000 users:
   _raw_spin_lock*          23.21%        2.25%
   queue_spin_lock_slowpath       N/A            4.42%

At 1500 users:
   _raw_spin_lock*          29.07%        2.24%
   queue_spin_lock_slowpath       N/A            4.49%

At 2000 users:
   _raw_spin_lock*          29.15%        2.26%
   queue_spin_lock_slowpath       N/A            4.82%

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
