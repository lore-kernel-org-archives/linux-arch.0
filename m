From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 0/9] locking/rwsem: Enable reader optimistic spinning
Date: Thu, 8 Jun 2017 14:49:17 -0400
Message-ID: <df455d4a-471d-1ddb-fec1-aeefbbc1c62f@redhat.com>
References: <1496338747-20398-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1496338747-20398-1-git-send-email-longman@redhat.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Dave Chinner <david@fromorbit.com>
List-Id: linux-arch.vger.kernel.org

Hi,

Got the following tip-bit about this patch performance impact.

Cheers,
Longman

----------------------------------------------------

Greeting,

FYI, we noticed a 125.4% improvement of will-it-scale.per_thread_ops due to commit:


commit: a150752454e4aea37a44d7eb5baf5a538bcad6fc ("locking/rwsem: Enable readers spinning on writer")
url: https://github.com/0day-ci/linux/commits/Waiman-Long/locking-rwsem-Enable-reader-optimistic-spinning/20170602-071830


in testcase: will-it-scale
on test machine: 8 threads Ivy Bridge with 16G memory
with following parameters:

	nr_task: 100%
	mode: thread
	test: malloc1
	cpufreq_governor: performance

test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
test-url: https://github.com/antonblanchard/will-it-scale


Details are as below:
-------------------------------------------------------------------------------------------------->


To reproduce:

        git clone https://github.com/01org/lkp-tests.git
        cd lkp-tests
        bin/lkp install job.yaml  # job file is attached in this email
        bin/lkp run     job.yaml

testcase/path_params/tbox_group/run: will-it-scale/100%-thread-malloc1-performance/lkp-ivb-d01

f25a7e717bfb87ab  a150752454e4aea37a44d7eb5b  
----------------  --------------------------  
         %stddev      change         %stddev
             \          |                \  
      6092 ± 12%       125%      13734        will-it-scale.per_thread_ops
  14641877 ± 12%       126%   33029197        will-it-scale.time.minor_page_faults
     15.03 ± 13%        57%      23.66 ± 12%  will-it-scale.time.user_time
  40731914 ± 12%        46%   59414926 ±  5%  will-it-scale.time.voluntary_context_switches
     11954 ± 18%        28%      15275 ± 11%  will-it-scale.time.maximum_resident_set_size
       142              22%        174        will-it-scale.time.percent_of_cpu_this_job_got
       414              21%        502        will-it-scale.time.system_time
    539104             -78%     117329 ± 13%  will-it-scale.time.involuntary_context_switches
  31904937 ± 13%        55%   49519854 ±  5%  interrupts.CAL:Function_call_interrupts
    129303 ± 10%        48%     191426 ±  4%  vmstat.system.in
    297417 ± 11%        42%     421902 ±  4%  vmstat.system.cs
     25.73                       26.28        turbostat.CorWatt
     31.60                       32.21        turbostat.PkgWatt
     22.67              19%      27.03        turbostat.%Busy
       837              20%       1006        turbostat.Avg_MHz
      1271 ± 36%      6e+04      56891 ± 74%  latency_stats.max.call_rwsem_down_read_failed.__do_page_fault.do_page_fault.page_fault
      2249 ± 19%      5e+04      52972 ± 86%  latency_stats.max.call_rwsem_down_write_failed_killable.vm_mmap_pgoff.SyS_mmap_pgoff.SyS_mmap.entry_SYSCALL_64_fastpath
      2264 ± 19%      5e+04      52187 ± 88%  latency_stats.max.call_rwsem_down_write_failed_killable.vm_munmap.SyS_munmap.entry_SYSCALL_64_fastpath
      9934 ± 25%      5e+04      57497 ± 75%  latency_stats.max.max
  14956191 ± 12%       123%   33343207        perf-stat.page-faults
  14956191 ± 12%       123%   33343206        perf-stat.minor-faults
 2.266e+11 ±  4%        46%  3.318e+11        perf-stat.branch-instructions
 3.231e+11 ±  3%        39%  4.485e+11        perf-stat.dTLB-loads
 1.155e+12 ±  3%        38%  1.593e+12        perf-stat.instructions
      0.02 ± 11%       103%       0.05 ±  6%  perf-stat.dTLB-store-miss-rate%
  86305241 ±  8%        74%  1.502e+08 ±  6%  perf-stat.dTLB-store-misses
      0.56              14%       0.64        perf-stat.ipc
 2.057e+12              21%  2.481e+12        perf-stat.cpu-cycles
 3.674e+11 ±  3%       -15%  3.136e+11        perf-stat.dTLB-stores
      0.76 ±  3%       -32%       0.51 ±  4%  perf-stat.branch-miss-rate%
      1869 ±  5%        30%       2432 ±  8%  perf-stat.instructions-per-iTLB-miss
 6.014e+10 ±  8%       -48%  3.146e+10 ±  5%  perf-stat.cache-references
      0.29 ±  6%       -17%       0.24 ± 12%  perf-stat.dTLB-load-miss-rate%
  90408163 ± 11%        42%  1.283e+08 ±  4%  perf-stat.context-switches
    182383 ± 13%       -55%      82982 ± 49%  perf-stat.cpu-migrations




  [*] bisect-good sample
  [O] bisect-bad  sample


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


Thanks,
Xiaolong


