From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Software prefetching considered harmful
Date: Thu, 19 May 2011 21:28:42 +0200
Message-ID: <20110519192842.GA7421@elte.hu>
References: <BANLkTim5MaJBYSuTnXfmOjgPNVOyZSgQuQ@mail.gmail.com>
 <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:57849 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933896Ab1EST3D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 May 2011 15:29:03 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=428+KWmDcHoFYs5gO_C9wyhxJnQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Russell King <rmk@arm.linux.org.uk>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, May 19, 2011 at 10:12 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Now, notice that right now I'm *only* talking about removing it for
> > the "hlist" cases (patch attached). I suspect we should do the same
> > thing for all the list helpers.
> 
> Actually, it's the "rcu" versions of the hlist helpers that need this
> most, since those are the performance-critical ones and the ones used
> in avc traversal. So the previous patch did nothing.
> 
> So here's the actual patch I think I should commit.
> 
> Added davem, benh and rmk explicitly - I think you're on linux-arch,
> but still..  You may have machines that like prefetch more, although I
> think the "pollute the L1 cache" issue means that even if  you don't
> have the NULL pointer microtrap issue you'll still find this actually
> performs better..

As further background, i've attached below the 3 mails i wrote earlier today, 
with hard numbers and analysis about the prefetch situation on x86. The 
conclusion of both Linus's and my numbers are that the more explicit 
prefetching we remove from these list walks, the better the CPU handles the 
workload.

Thanks,

	Ingo

------------------------->

* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So yes, the prefetching ACTUALLY HURTS. Repeatably. And the numbers are 
> pretty stable.
> 
> Both of the above were done directly after a boot, after having warmed up the 
> caches with a "make -j" before. Both of the above are with that "perf record" 
> that I already quoted earlier (basically doing ten empty -j16 builds to get 
> enough samples to make the profiles worth something).

Very interesting.

Out of curiosity i reproduced your workload to look at all the CPU hardware 
event details using 'perf stat' and generalized hardware events.

I took a slightly different approach to reduce systematic measurement errors: i 
added a very simple hack to turn the prefetch on/off dynamically via a sysctl, 
on the same system. This adds more instructions to the hotpath, but the sysctl 
flag i used is __read_mostly so it does not disturb execution much.

This way there's no bzImage-to-bzImage noise (it's the same bzImage) and 
there's not much data layout noise (i ran the exact same workload from the same 
shell, on a totally quiet system that had even crond shut off).

 [ I used perf stat's --detailed event statistics (this is a new feature for 
   .40) and i used the --sync option so that any writes the build job made 
   touch disk before the next benchmark iteration. I used --repeat 100 to get 
   well-averaged results and a low average standard deviation. Nehalem box. ]

The raw results are:

 | Prefetches turned on in hlist_for_each_entry_rcu:
 ---------------------------------------------------

 Performance counter stats for 'make -j128 bzImage' (100 runs):

      17328.280466 task-clock                #    7.951 CPUs utilized            ( +-  0.05% )
            14,320 context-switches          #    0.001 M/sec                    ( +-  0.32% )
             1,249 CPU-migrations            #    0.000 M/sec                    ( +-  0.21% )
           484,119 page-faults               #    0.028 M/sec                    ( +-  0.00% )
    45,606,735,329 cycles                    #    2.632 GHz                      ( +-  0.07% ) [31.14%]
    27,798,532,726 stalled-cycles-frontend   #   60.95% frontend cycles idle     ( +-  0.09% ) [30.63%]
     9,241,209,197 stalled-cycles-backend    #   20.26% backend  cycles idle     ( +-  0.13% ) [30.55%]
    39,343,479,066 instructions              #    0.86  insns per cycle        
                                             #    0.71  stalled cycles per insn  ( +-  0.06% ) [36.66%]
     8,763,820,658 branches                  #  505.752 M/sec                    ( +-  0.07% ) [36.18%]
       245,647,798 branch-misses             #    2.80% of all branches          ( +-  0.07% ) [36.24%]
     9,438,932,203 L1-dcache-loads           #  544.713 M/sec                    ( +-  0.08% ) [30.32%]
       327,752,134 L1-dcache-load-misses     #    3.47% of all L1-dcache hits    ( +-  0.12% ) [30.75%]
        85,066,061 LLC-loads                 #    4.909 M/sec                    ( +-  0.14% ) [24.13%]
        13,969,955 LLC-load-misses           #   16.42% of all LL-cache hits     ( +-  0.84% ) [ 6.33%]
    15,415,575,590 L1-icache-loads           #  889.619 M/sec                    ( +-  0.07% ) [13.22%]
       725,290,789 L1-icache-load-misses     #    4.70% of all L1-icache hits    ( +-  0.09% ) [19.48%]
    10,991,543,761 dTLB-loads                #  634.312 M/sec                    ( +-  0.08% ) [25.53%]
        88,971,714 dTLB-load-misses          #    0.81% of all dTLB cache hits   ( +-  0.58% ) [25.27%]
    38,822,469,874 iTLB-loads                # 2240.411 M/sec                    ( +-  0.08% ) [25.23%]
         8,631,752 iTLB-load-misses          #    0.02% of all iTLB cache hits   ( +-  0.14% ) [25.16%]
       237,870,999 L1-dcache-prefetches      #   13.727 M/sec                    ( +-  0.16% ) [25.09%]
        92,041,053 L1-dcache-prefetch-misses #    5.312 M/sec                    ( +-  0.19% ) [24.98%]

       2.179404908 seconds time elapsed                                          ( +-  0.16% )


 | Prefetches turned off in hlist_for_each_entry_rcu:
 ----------------------------------------------------

 Performance counter stats for 'make -j128 bzImage' (100 runs):

      17239.878672 task-clock                #    7.951 CPUs utilized            ( +-  0.04% )
            14,160 context-switches          #    0.001 M/sec                    ( +-  0.31% )
             1,249 CPU-migrations            #    0.000 M/sec                    ( +-  0.19% )
           484,116 page-faults               #    0.028 M/sec                    ( +-  0.00% )
    45,365,644,942 cycles                    #    2.631 GHz                      ( +-  0.07% ) [31.13%]
    27,560,997,994 stalled-cycles-frontend   #   60.75% frontend cycles idle     ( +-  0.08% ) [30.64%]
     9,144,776,111 stalled-cycles-backend    #   20.16% backend  cycles idle     ( +-  0.14% ) [30.62%]
    39,263,121,273 instructions              #    0.87  insns per cycle        
                                             #    0.70  stalled cycles per insn  ( +-  0.07% ) [36.73%]
     8,756,901,465 branches                  #  507.944 M/sec                    ( +-  0.08% ) [36.26%]
       245,972,385 branch-misses             #    2.81% of all branches          ( +-  0.07% ) [36.30%]
     9,413,229,527 L1-dcache-loads           #  546.015 M/sec                    ( +-  0.08% ) [30.32%]
       315,077,423 L1-dcache-load-misses     #    3.35% of all L1-dcache hits    ( +-  0.12% ) [30.75%]
        84,722,017 LLC-loads                 #    4.914 M/sec                    ( +-  0.12% ) [24.10%]
        14,004,791 LLC-load-misses           #   16.53% of all LL-cache hits     ( +-  1.18% ) [ 6.33%]
    15,391,274,240 L1-icache-loads           #  892.772 M/sec                    ( +-  0.09% ) [13.22%]
       728,973,617 L1-icache-load-misses     #    4.74% of all L1-icache hits    ( +-  0.09% ) [19.47%]
    10,832,105,195 dTLB-loads                #  628.317 M/sec                    ( +-  0.10% ) [25.52%]
        63,746,375 dTLB-load-misses          #    0.59% of all dTLB cache hits   ( +-  0.62% ) [25.27%]
    38,756,406,589 iTLB-loads                # 2248.067 M/sec                    ( +-  0.09% ) [25.22%]
         8,642,298 iTLB-load-misses          #    0.02% of all iTLB cache hits   ( +-  0.13% ) [25.16%]
       239,723,571 L1-dcache-prefetches      #   13.905 M/sec                    ( +-  0.15% ) [25.07%]
        92,558,091 L1-dcache-prefetch-misses #    5.369 M/sec                    ( +-  0.18% ) [24.97%]

       2.168310831 seconds time elapsed                                          ( +-  0.15% )


Firstly, the elapsed time numbers tells us that actual wall-clock performance 
of this workload sped up by %0.51%:

  prefetch-on:       2.179404908 seconds time elapsed                            ( +-  0.16% )
  prefetch-off:      2.168310831 seconds time elapsed                            ( +-  0.15% )

Which is well outside the noise threshold of ~0.15%. So yes, prefetching hurts.

The number of instructions went down:

  prefetch-on:    39,343,479,066 instructions              #    0.86  insns per cycle        
  prefetch-ff:    39,263,121,273 instructions              #    0.87  insns per cycle        

By about 80 million instructions.

Interestingly, the number of prefetches did not go down:

  prefetch-on:
       237,870,999 L1-dcache-prefetches      #   13.727 M/sec                    ( +-  0.16% ) [25.09%]
        92,041,053 L1-dcache-prefetch-misses #    5.312 M/sec                    ( +-  0.19% ) [24.98%]

  prefetch-off:
       239,723,571 L1-dcache-prefetches      #   13.905 M/sec                    ( +-  0.15% ) [25.07%]
        92,558,091 L1-dcache-prefetch-misses #    5.369 M/sec                    ( +-  0.18% ) [24.97%]

Which would suggest to me that the hardware prefetcher took over the place of 
our software prefetches and kept a steady rate of opportunistic prefetching.

What went down *very* visibly are dTLB misses:

    10,991,543,761 dTLB-loads                #  634.312 M/sec                    ( +-  0.08% ) [25.53%]
        88,971,714 dTLB-load-misses          #    0.81% of all dTLB cache hits   ( +-  0.58% ) [25.27%]

    10,832,105,195 dTLB-loads                #  628.317 M/sec                    ( +-  0.10% ) [25.52%]
        63,746,375 dTLB-load-misses          #    0.59% of all dTLB cache hits   ( +-  0.62% ) [25.27%]

The number of dTLB misses went down by 39% (!).

There are two ways to interpret this:

 1) the efficiency of the hardware prefetcher is much better than our software 
    prefetch - we prefetch items in a way that causes us to thrash the dTLB

 2) prefetch(NULL) creates many dTLB cachemisses, due to the zero page not 
    being present.

To examine the second, NULL-prefetch hypothesis i wrote a simple loop in 
user-space that tests the impact of NULL prefetches:


#include <stdlib.h>
#include <stdio.h>
#include <time.h>

static inline void prefetch(const void *x)
{
	asm volatile ("prefetchnta (%0)":: "r" (x));
}

#define BILLION (1000*1000*1000)

int main (void)
{
	int i;

	for (i = 0; i < BILLION; i++) {
		prefetch(NULL);
		prefetch(&i);
	}

	return 0;
}

The 1-billion iterations loop consists of 4 instructions:

  4003a0:       0f 18 02                prefetchnta (%rdx)
  4003a3:       0f 18 01                prefetchnta (%rcx)
  4003a6:       83 e8 01                sub    $0x1,%eax
  4003a9:       75 f5                   jne    4003a0 <main+0x10>

The perf stat results (with most of our generalized events turned on) are:

 $ perf stat -d -d -d --repeat 3 ./prefetch_1b

 Performance counter stats for './prefetch_1b' (3 runs):

       7064.974193 task-clock                #    0.998 CPUs utilized            ( +-  0.02% )
                91 context-switches          #    0.000 M/sec                    ( +- 35.78% )
                 0 CPU-migrations            #    0.000 M/sec                    ( +-  0.00% )
                99 page-faults               #    0.000 M/sec                    ( +-  0.00% )
    22,501,301,997 cycles                    #    3.185 GHz                      ( +-  0.01% ) [27.78%]
    20,494,447,003 stalled-cycles-frontend   #   91.08% frontend cycles idle     ( +-  0.01% ) [27.79%]
    20,353,062,624 stalled-cycles-backend    #   90.45% backend  cycles idle     ( +-  0.20% ) [27.80%]
     4,023,157,956 instructions              #    0.18  insns per cycle        
                                             #    5.09  stalled cycles per insn  ( +-  0.02% ) [33.36%]
     1,004,948,813 branches                  #  142.244 M/sec                    ( +-  0.02% ) [33.36%]
            96,179 branch-misses             #    0.01% of all branches          ( +-  1.09% ) [33.37%]
     2,009,042,385 L1-dcache-loads           #  284.367 M/sec                    ( +-  0.01% ) [27.80%]
           161,471 L1-dcache-load-misses     #    0.01% of all L1-dcache hits    ( +- 18.40% ) [27.79%]
             6,313 LLC-loads                 #    0.001 M/sec                    ( +- 34.26% ) [22.23%]
             1,782 LLC-load-misses           #   28.23% of all LL-cache hits     ( +- 36.32% ) [ 5.56%]
        12,830,415 L1-icache-loads           #    1.816 M/sec                    ( +-  0.61% ) [11.13%]
         1,085,510 L1-icache-load-misses     #    8.46% of all L1-icache hits    ( +-  0.43% ) [16.69%]
    22,482,377,347 dTLB-loads                # 3182.231 M/sec                    ( +-  0.02% ) [22.24%]
       999,018,134 dTLB-load-misses          #    4.44% of all dTLB cache hits   ( +-  0.02% ) [22.24%]
     4,021,706,221 iTLB-loads                #  569.246 M/sec                    ( +-  0.02% ) [22.24%]
               853 iTLB-load-misses          #    0.00% of all iTLB cache hits   ( +- 17.89% ) [22.23%]
            64,154 L1-dcache-prefetches      #    0.009 M/sec                    ( +-  5.48% ) [22.23%]
             8,841 L1-dcache-prefetch-misses #    0.001 M/sec                    ( +- 18.47% ) [22.22%]

       7.079732683 seconds time elapsed                                          ( +-  0.02% )


Two things are worth noting:

1) 

4 billion instructions were executed (4 per iteration, 1 billion times):

     4,023,157,956 instructions              #    0.18  insns per cycle        

Which generated 22 billion dTLB accesses (!):  

    22,482,377,347 dTLB-loads                # 3182.231 M/sec                    ( +-  0.02% ) [22.24%]
       999,018,134 dTLB-load-misses          #    4.44% of all dTLB cache hits   ( +-  0.02% ) [22.24%]

Those are clearly generated by the prefetch instructions: 11 by each. So they 
fill up the prefetch queue.

Note that 1 billion accesses missed. This is the number of times we executed 
the prefetch(NULL) instruction.

If i change both prefetches to be prefetch(&i), i get:

     1,983,482,001 dTLB-loads                # 3154.645 M/sec                    ( +-  0.12% ) [22.44%]
               129 dTLB-load-misses          #    0.00% of all dTLB cache hits   ( +- 45.76% ) [22.40%]

So yes, we did get 1 billion dTLB misses from the prefetch(NULL).

2)

The loop shows a *lot* of stalled cycles:

    20,494,447,003 stalled-cycles-frontend   #   91.08% frontend cycles idle     ( +-  0.01% ) [27.79%]
    20,353,062,624 stalled-cycles-backend    #   90.45% backend  cycles idle     ( +-  0.20% ) [27.80%]
     4,023,157,956 instructions              #    0.18  insns per cycle        
                                             #    5.09  stalled cycles per insn  ( +-  0.02% ) [33.36%]

Instruction throughput is at a very low 0.18 instructions per cycle, and the 
stall metric is very, very high at 5.09 cycles per instruction.

If i change the testcase to two prefetch(&i)'s, the stalls drop dramatically:

         4,732,455 stalled-cycles-frontend   #    0.24% frontend cycles idle     ( +- 29.23% ) [27.77%]
         3,726,448 stalled-cycles-backend    #    0.19% backend  cycles idle     ( +- 34.34% ) [27.78%]
     3,997,385,701 instructions              #    2.00  insns per cycle        
                                             #    0.00  stalled cycles per insn  ( +-  0.01% ) [33.33%]

And performance is at a healthier 2 instructions retired per cycle.

So we can conclude that the prefetch(NULL) causes a dTLB miss, a big pipeline 
stall that costs about 20 cycles each.

So the (untested) patch below could in theory help with this problem. Note, i 
have not measured it yet, so i do not know which one is better: full removal of 
the prefetch or conditional prefetch of non-NULL addresses.

In any case, i think three things are clear:

 - for *years* people were adding prefetches to the kernel blindly, without 
   actually testing it much and proving that it helps! I think we should 
   re-examine this very carefully.

 - hardware is fundamentally better at prefetching than software. The 
   much-glorified 'hints' were *hurting* our performance big time.

 - Generalized CPU hw perf-events are the way to go: they were *very* useful to 
   me to analyze the situation above - and i didnt actually have to know what 
   CPU model i am running the tests on. This is a big advantage IMO.

So i think we should also consider removing all of these common prefetches (on 
x86 at least) and only use prefetches in special cases when there's some good 
caching reason for it.

Then we can add back prefetches one by one, but only based on carefully 
measured proof, not based on belief ...

Thanks,

	Ingo

---
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4c25ab4..5966f97 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -830,10 +830,8 @@ extern char			ignore_fpu_irq;
  */
 static inline void prefetch(const void *x)
 {
-	alternative_input(BASE_PREFETCH,
-			  "prefetchnta (%1)",
-			  X86_FEATURE_XMM,
-			  "r" (x));
+	if (x != NULL)
+		alternative_input(BASE_PREFETCH, "prefetchnta (%1)", X86_FEATURE_XMM, "r" (x));
 }
 
 /*
@@ -843,10 +841,8 @@ static inline void prefetch(const void *x)
  */
 static inline void prefetchw(const void *x)
 {
-	alternative_input(BASE_PREFETCH,
-			  "prefetchw (%1)",
-			  X86_FEATURE_3DNOW,
-			  "r" (x));
+	if (x != NULL)
+		alternative_input(BASE_PREFETCH, "prefetchw (%1)", X86_FEATURE_3DNOW, "r" (x));
 }
 
 static inline void spin_lock_prefetch(const void *x)

----------------------------------------------------->

* Ingo Molnar <mingo@elte.hu> wrote:

> int main (void)
> {
> 	int i;
> 
> 	for (i = 0; i < BILLION; i++) {
> 		prefetch(NULL);
> 		prefetch(&i);
> 	}
> 
> 	return 0;
> }
> 
> The 1-billion iterations loop consists of 4 instructions:
> 
>   4003a0:       0f 18 02                prefetchnta (%rdx)
>   4003a3:       0f 18 01                prefetchnta (%rcx)
>   4003a6:       83 e8 01                sub    $0x1,%eax
>   4003a9:       75 f5                   jne    4003a0 <main+0x10>

The cycles:pp precise profile very clearly pinpoints the NULL prefetch as well:

    0.00 :        40039a:       31 d2                   xor    %edx,%edx
    0.00 :        40039c:       0f 1f 40 00             nopl   0x0(%rax)
   95.45 :        4003a0:       0f 18 02                prefetchnta (%rdx)
    0.03 :        4003a3:       0f 18 01                prefetchnta (%rcx)
    0.00 :        4003a6:       83 e8 01                sub    $0x1,%eax
    4.52 :        4003a9:       75 f5                   jne    4003a0 <main+0x10>

95% of the overhead is in that instruction.

So the NULL generates a TLB miss every time it is executed.

Btw., a 'perf record -e dTLB-load-misses' profile of the workload shows this:

# Events: 15K dTLB-load-misses
#
# Overhead   Command                 Shared Object                            Symbol
# ........  ........  ............................  ................................
#
    25.45%      make  [kernel.kallsyms]             [k] avc_has_perm_noaudit
    13.92%      make  [kernel.kallsyms]             [k] __d_lookup_rcu
    12.93%      make  [kernel.kallsyms]             [k] inode_has_perm
     5.31%      make  [kernel.kallsyms]             [k] acl_permission_check
     5.03%      make  [kernel.kallsyms]             [k] __read_seqcount_begin
     3.29%      make  make                          [.] 0x1f153         
     2.96%      make  [kernel.kallsyms]             [k] link_path_walk
     2.50%      make  [kernel.kallsyms]             [k] audit_dummy_context
     2.12%      make  [kernel.kallsyms]             [k] virt_to_head_page
     1.77%      make  [kernel.kallsyms]             [k] generic_fillattr
     1.53%      make  [kernel.kallsyms]             [k] walk_component
     1.50%      make  libc-2.13.90.so               [.] _int_malloc
     1.27%      make  [kernel.kallsyms]             [k] selinux_inode_permission
     1.14%      make  [kernel.kallsyms]             [k] kmem_cache_alloc
     1.06%      make  [kernel.kallsyms]             [k] exec_permission
     0.91%      make  [kernel.kallsyms]             [k] audit_get_context
     0.87%      make  [kernel.kallsyms]             [k] audit_syscall_entry
     0.84%      make  libc-2.13.90.so               [.] _int_free
     0.71%      make  [kernel.kallsyms]             [k] security_inode_exec_permission
     0.70%      make  [kernel.kallsyms]             [k] vfs_getattr

So the kernel is generating more than 90% of all dTLB misses.

With prefetches turned off in the list iteration primitive it becomes:

# Events: 15K dTLB-load-misses
#
# Overhead        Command                 Shared Object                              Symbol
# ........  .............  ............................  ..................................
#
    16.70%           make  [kernel.kallsyms]             [k] __d_lookup_rcu
    14.42%           make  [kernel.kallsyms]             [k] inode_has_perm
    10.53%           make  [kernel.kallsyms]             [k] avc_has_perm_noaudit
     5.70%           make  [kernel.kallsyms]             [k] acl_permission_check
     5.58%           make  [kernel.kallsyms]             [k] __read_seqcount_begin
     3.77%           make  make                          [.] 0x1ed97         
     3.63%           make  [kernel.kallsyms]             [k] link_path_walk
     2.85%           make  [kernel.kallsyms]             [k] audit_dummy_context
     2.36%           make  [kernel.kallsyms]             [k] virt_to_head_page
     2.28%           make  [kernel.kallsyms]             [k] walk_component
     2.23%           make  [kernel.kallsyms]             [k] generic_fillattr
     1.78%           make  [kernel.kallsyms]             [k] selinux_inode_permission
     1.73%           make  libc-2.13.90.so               [.] _int_malloc
     1.59%           make  [kernel.kallsyms]             [k] exec_permission
     1.51%           make  [kernel.kallsyms]             [k] kmem_cache_alloc
     1.29%           make  [kernel.kallsyms]             [k] audit_get_context
     1.25%           make  [kernel.kallsyms]             [k] vfs_getattr
     1.08%           make  [kernel.kallsyms]             [k] audit_syscall_entry
     1.04%           make  libc-2.13.90.so               [.] _int_free
     0.87%           make  [kernel.kallsyms]             [k] path_init

avc_has_perm_noaudit is *way* down, but so are other functions and the 
histogram has flattened significantly.

I'll boot a test kernel with the NULL prefetches patch.

	Ingo

----------------------------------------------------->


* Ingo Molnar <mingo@elte.hu> wrote:

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 4c25ab4..5966f97 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -830,10 +830,8 @@ extern char			ignore_fpu_irq;
>   */
>  static inline void prefetch(const void *x)
>  {
> -	alternative_input(BASE_PREFETCH,
> -			  "prefetchnta (%1)",
> -			  X86_FEATURE_XMM,
> -			  "r" (x));
> +	if (x != NULL)
> +		alternative_input(BASE_PREFETCH, "prefetchnta (%1)", X86_FEATURE_XMM, "r" (x));
>  }
>  
>  /*
> @@ -843,10 +841,8 @@ static inline void prefetch(const void *x)
>   */
>  static inline void prefetchw(const void *x)
>  {
> -	alternative_input(BASE_PREFETCH,
> -			  "prefetchw (%1)",
> -			  X86_FEATURE_3DNOW,
> -			  "r" (x));
> +	if (x != NULL)
> +		alternative_input(BASE_PREFETCH, "prefetchw (%1)", X86_FEATURE_3DNOW, "r" (x));
>  }
>  
>  static inline void spin_lock_prefetch(const void *x)

So i have tested this, and the results are pretty clear with --repeat 10 
already:

 cond-prefetch:   2.476067346 seconds time elapsed                               ( +-  0.57% )
   no-prefetch:   2.436969143 seconds time elapsed                               ( +-  0.39% )

There's a +1.6% speedup from *not* using *any* prefetches - versus the 
prefetches that excluded the NULL case.

It's pretty clear from the stats where the blame goes:

with non-NULL prefetches:

    [ cond-prefetches: ]
    --------------------
    11,595,337,879 dTLB-loads                #  613.012 M/sec                    ( +-  0.50% ) [26.82%]
       162,004,965 dTLB-load-misses          #    1.40% of all dTLB cache hits   ( +-  2.45% ) [26.39%]

    [ no prefetches: ]
    ------------------
    11,081,251,820 dTLB-loads                #  593.693 M/sec                    ( +-  0.20% ) [26.92%]
       141,494,408 dTLB-load-misses          #    1.28% of all dTLB cache hits   ( +-  0.52% ) [26.62%]

So we have 15% more dTLB misses with these manual prefetches. They are 
prefetching the wrong things: the hash is probably larger than the L1 cache,
so it pays not to widen the footprint of our walk through the hash by +1 chain 
length.

This shows up clearly in the L1 data cache stats as well:

    [ cond-prefetches: ]
    --------------------
     9,612,755,673 L1-dcache-loads           #  508.199 M/sec                    ( +-  0.22% ) [31.26%]
       364,069,747 L1-dcache-load-misses     #    3.79% of all L1-dcache hits    ( +-  0.77% ) [31.82%]

    [ no prefetches: ]
    ------------------
     9,373,182,863 L1-dcache-loads           #  502.181 M/sec                    ( +-  0.26% ) [31.36%]
       330,543,627 L1-dcache-load-misses     #    3.53% of all L1-dcache hits    ( +-  0.34% ) [31.92%]

+10.1% more L1 cachemisses due to the prefetches ...

In addition to the primary effect there's a secondary effect (and Linus 
mentioned this), we execute more branches as well, due to the conditional 
prefetch:

     [ cond-prefetches: ]
     --------------------
     8,984,204,888 branches                  #  474.969 M/sec                    ( +-  0.19% ) [37.34%]
       257,960,185 branch-misses             #    2.87% of all branches          ( +-  0.21% ) [37.38%]

     [ no prefetches: ]
     ------------------
     8,953,079,923 branches                  #  479.674 M/sec                    ( +-  0.24% ) [37.39%]
       259,719,603 branch-misses             #    2.90% of all branches          ( +-  0.26% ) [37.44%]

0.3% more branches is a bit above the noise of the measurement - and we 
expected this as well.

Branch-misses is the same within noise: the branch predictor is apparently 
pretty good.

The total number of prefetches is the same within noise:

       [ cond-prefetches: ]
       --------------------
       249,486,415 L1-dcache-prefetches      #   13.190 M/sec                    ( +-  0.43% ) [26.30%]
        97,603,452 L1-dcache-prefetch-misses #    5.160 M/sec                    ( +-  0.66% ) [26.22%]

       [ no prefetches: ]
       ------------------
       245,045,201 L1-dcache-prefetches      #   13.129 M/sec                    ( +-  0.28% ) [26.25%]
        93,749,778 L1-dcache-prefetch-misses #    5.023 M/sec                    ( +-  0.27% ) [26.04%]

But the number of prefetch misses is higher by about 4.1%. So the hardware 
prefetcher, at the same rate of work, does a much finer job of prefetching 
data.

So the conclusion is: prefetches are absolutely toxic, even if the NULL ones 
are excluded.

(Below are the raw stats for double checking.)

Thanks,

	Ingo

 | Prefetches turned on in hlist_for_each_entry_rcu:
 ---------------------------------------------------

 Performance counter stats for 'make -j128' (10 runs):

      18915.352474 task-clock                #    7.639 CPUs utilized            ( +-  0.31% )
            24,066 context-switches          #    0.001 M/sec                    ( +-  0.26% )
             1,916 CPU-migrations            #    0.000 M/sec                    ( +-  0.47% )
           704,379 page-faults               #    0.037 M/sec                    ( +-  0.00% )
    47,626,094,731 cycles                    #    2.518 GHz                      ( +-  0.31% ) [32.61%]
    30,028,498,354 stalled-cycles-frontend   #   63.05% frontend cycles idle     ( +-  0.48% ) [31.91%]
    10,344,280,486 stalled-cycles-backend    #   21.72% backend  cycles idle     ( +-  0.57% ) [31.73%]
    39,671,478,312 instructions              #    0.83  insns per cycle        
                                             #    0.76  stalled cycles per insn  ( +-  0.18% ) [38.02%]
     8,984,204,888 branches                  #  474.969 M/sec                    ( +-  0.19% ) [37.34%]
       257,960,185 branch-misses             #    2.87% of all branches          ( +-  0.21% ) [37.38%]
     9,612,755,673 L1-dcache-loads           #  508.199 M/sec                    ( +-  0.22% ) [31.26%]
       364,069,747 L1-dcache-load-misses     #    3.79% of all L1-dcache hits    ( +-  0.77% ) [31.82%]
        91,884,145 LLC-loads                 #    4.858 M/sec                    ( +-  0.39% ) [25.09%]
        16,339,489 LLC-load-misses           #   17.78% of all LL-cache hits     ( +-  1.36% ) [ 6.52%]
    15,203,352,449 L1-icache-loads           #  803.757 M/sec                    ( +-  0.27% ) [13.99%]
       717,249,607 L1-icache-load-misses     #    4.72% of all L1-icache hits    ( +-  0.32% ) [20.58%]
    11,595,337,879 dTLB-loads                #  613.012 M/sec                    ( +-  0.50% ) [26.82%]
       162,004,965 dTLB-load-misses          #    1.40% of all dTLB cache hits   ( +-  2.45% ) [26.39%]
    38,859,253,924 iTLB-loads                # 2054.376 M/sec                    ( +-  0.27% ) [26.34%]
         9,076,241 iTLB-load-misses          #    0.02% of all iTLB cache hits   ( +-  0.47% ) [26.30%]
       249,486,415 L1-dcache-prefetches      #   13.190 M/sec                    ( +-  0.43% ) [26.30%]
        97,603,452 L1-dcache-prefetch-misses #    5.160 M/sec                    ( +-  0.66% ) [26.22%]

       2.476067346 seconds time elapsed                                          ( +-  0.57% )

 | Prefetches turned off in hlist_for_each_entry_rcu:
 ----------------------------------------------------

 Performance counter stats for 'make -j128' (10 runs):

      18664.941492 task-clock                #    7.659 CPUs utilized            ( +-  0.16% )
            23,790 context-switches          #    0.001 M/sec                    ( +-  0.15% )
             1,908 CPU-migrations            #    0.000 M/sec                    ( +-  0.61% )
           704,392 page-faults               #    0.038 M/sec                    ( +-  0.00% )
    46,890,449,220 cycles                    #    2.512 GHz                      ( +-  0.36% ) [32.46%]
    29,250,965,018 stalled-cycles-frontend   #   62.38% frontend cycles idle     ( +-  0.45% ) [31.69%]
    10,170,830,726 stalled-cycles-backend    #   21.69% backend  cycles idle     ( +-  0.44% ) [31.66%]
    39,282,270,372 instructions              #    0.84  insns per cycle        
                                             #    0.74  stalled cycles per insn  ( +-  0.26% ) [38.06%]
     8,953,079,923 branches                  #  479.674 M/sec                    ( +-  0.24% ) [37.39%]
       259,719,603 branch-misses             #    2.90% of all branches          ( +-  0.26% ) [37.44%]
     9,373,182,863 L1-dcache-loads           #  502.181 M/sec                    ( +-  0.26% ) [31.36%]
       330,543,627 L1-dcache-load-misses     #    3.53% of all L1-dcache hits    ( +-  0.34% ) [31.92%]
        91,068,069 LLC-loads                 #    4.879 M/sec                    ( +-  0.24% ) [25.12%]
        16,040,268 LLC-load-misses           #   17.61% of all LL-cache hits     ( +-  1.88% ) [ 6.46%]
    15,212,361,697 L1-icache-loads           #  815.023 M/sec                    ( +-  0.33% ) [13.96%]
       707,698,543 L1-icache-load-misses     #    4.65% of all L1-icache hits    ( +-  0.23% ) [20.59%]
    11,081,251,820 dTLB-loads                #  593.693 M/sec                    ( +-  0.20% ) [26.92%]
       141,494,408 dTLB-load-misses          #    1.28% of all dTLB cache hits   ( +-  0.52% ) [26.62%]
    38,663,320,691 iTLB-loads                # 2071.441 M/sec                    ( +-  0.17% ) [26.57%]
         9,146,374 iTLB-load-misses          #    0.02% of all iTLB cache hits   ( +-  0.33% ) [26.41%]
       245,045,201 L1-dcache-prefetches      #   13.129 M/sec                    ( +-  0.28% ) [26.25%]
        93,749,778 L1-dcache-prefetch-misses #    5.023 M/sec                    ( +-  0.27% ) [26.04%]

       2.436969143 seconds time elapsed                                          ( +-  0.39% )
