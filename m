From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Question] Documentation/features: More automation/scripting
 help?
Date: Fri, 30 Mar 2018 13:31:31 +0200
Message-ID: <20180330113130.fmwnxgnlm2cpwmcc@gmail.com>
References: <20180328122211.GA25420@andrea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180328122211.GA25420@andrea>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


* Andrea Parri <andrea.parri@amarulasolutions.com> wrote:

> Hi all,
> 
> The directory (not yet three years old although, I freely admit, I've
> only recently become aware of it) provides arch. support matrices for
> more than 40 generic kernel features that need per-arch. support:
> 
> This is a superb project! ;-)  and not a simple one given that, to be
> effective, this requires the prompt collaboration between (the intere-
> sted) features maintainers/developers, every architecture maintainers,
> and documentation maintainers.
> 
> There currently appear to be some mismatches between such doc and the
> the actual state of the code (e.g., missing architecture, feature not
> existing anymore, status flags out-of-date). Realized this, I started
> to patch the doc, but this process became soon tedious (consider also
> that I barely know what some of these features are about...).
> 
> Hence this post. I am wondering if it would make sense to script some
> of these matrices.  So, rather than (or together with) using the cur-
> rently hard-coded matrices, try to (automatically) generate them from
> the sources/configs. Consider the sketch below (sorry for the raw sh).
> 
> diff --git a/Documentation/features/list-arch.sh b/Documentation/features/list-arch.sh
> index c16b5b5956889..cdec0c1db9db2 100755
> --- a/Documentation/features/list-arch.sh
> +++ b/Documentation/features/list-arch.sh
> @@ -18,7 +18,13 @@ for F in */*/arch-support.txt; do
>    C=$(grep -h "^#         Kconfig:"     $F | cut -c25-)
>    D=$(grep -h "^#         description:" $F | cut -c25-)
>    S=$(grep -hw $ARCH $F | cut -d\| -f3)
> +  myS=$(grep -h $C ../../arch/$ARCH/Kconfig)
> +  if [ -z "$myS" ]; then
> +	  myS=" -- "
> +  else
> +	  myS=" ok "
> +  fi
>  
> -  printf "%10s/%-22s:%s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$C" "$D"
> +  printf "%10s/%-22s:%s VS. %s| %35s # %s\n" "$SUBSYS" "$N" "$S" "$myS" "$C" "$D"
>  done
>  
> 
> With this diff.,
> 
> andrea@andrea:~$ ./Documentation/features/list-arch.sh riscv > /tmp/riscv.txt
> grep: asm/rwsem.h: No such file or directory
> andrea@andrea:~$ cat /tmp/riscv.txt
> #
> # Kernel feature support matrix of the 'riscv' architecture:
> #
>       core/ BPF-JIT              : VS.  -- |                        HAVE_BPF_JIT #  arch supports BPF JIT optimizations
>       core/ generic-idle-thread  : VS.  ok |             GENERIC_SMP_IDLE_THREAD #  arch makes use of the generic SMP idle thread facility
>       core/ jump-labels          : VS.  -- |                HAVE_ARCH_JUMP_LABEL #  arch supports live patched, high efficiency branches
>       core/ tracehook            : VS.  ok |                 HAVE_ARCH_TRACEHOOK #  arch supports tracehook (ptrace) register handling APIs
>      debug/ gcov-profile-all     : VS.  -- |           ARCH_HAS_GCOV_PROFILE_ALL #  arch supports whole-kernel GCOV code coverage profiling
>      debug/ KASAN                : VS.  -- |                     HAVE_ARCH_KASAN #  arch supports the KASAN runtime memory checker
>      debug/ kgdb                 : VS.  -- |                      HAVE_ARCH_KGDB #  arch supports the kGDB kernel debugger
>      debug/ kprobes              : VS.  ok |                        HAVE_KPROBES #  arch supports live patched kernel probe
>      debug/ kprobes-on-ftrace    : VS.  -- |              HAVE_KPROBES_ON_FTRACE #  arch supports combined kprobes and ftrace live patching
>      debug/ kretprobes           : VS.  -- |                     HAVE_KRETPROBES #  arch supports kernel function-return probes
>      debug/ optprobes            : VS.  -- |                      HAVE_OPTPROBES #  arch supports live patched optprobes
>      debug/ stackprotector       : VS.  -- |              HAVE_CC_STACKPROTECTOR #  arch supports compiler driven stack overflow protection
>      debug/ uprobes              : VS.  -- |               ARCH_SUPPORTS_UPROBES #  arch supports live patched user probes
>      debug/ user-ret-profiler    : VS.  -- |           HAVE_USER_RETURN_NOTIFIER #  arch supports user-space return from system call profiler
>         io/ dma-api-debug        : VS.  ok |                  HAVE_DMA_API_DEBUG #  arch supports DMA debug facilities
>         io/ dma-contiguous       : VS.  ok |                 HAVE_DMA_CONTIGUOUS #  arch supports the DMA CMA (continuous memory allocator)
>         io/ sg-chain             : VS.  -- |                   ARCH_HAS_SG_CHAIN #  arch supports chained scatter-gather lists
>        lib/ strncasecmp          : VS.  -- |             __HAVE_ARCH_STRNCASECMP #  arch provides an optimized strncasecmp() function
>    locking/ cmpxchg-local        : VS.  -- |                  HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
>    locking/ lockdep              : VS.  -- |                     LOCKDEP_SUPPORT #  arch supports the runtime locking correctness debug facility
>    locking/ queued-rwlocks       : VS.  -- |             ARCH_USE_QUEUED_RWLOCKS #  arch supports queued rwlocks
>    locking/ queued-spinlocks     : VS.  -- |           ARCH_USE_QUEUED_SPINLOCKS #  arch supports queued spinlocks
>    locking/ rwsem-optimized      : VS.  -- |               Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
>       perf/ kprobes-event        : VS.  -- |      HAVE_REGS_AND_STACK_ACCESS_API #  arch supports kprobes with perf events
>       perf/ perf-regs            : VS.  -- |                      HAVE_PERF_REGS #  arch supports perf events register access
>       perf/ perf-stackdump       : VS.  -- |           HAVE_PERF_USER_STACK_DUMP #  arch supports perf events stack dumps
>      sched/ membarrier-sync-core : VS.  -- |       ARCH_HAS_MEMBARRIER_SYNC_CORE #  arch supports core serializing membarrier
>      sched/ numa-balancing       : VS.  -- |        ARCH_SUPPORTS_NUMA_BALANCING #  arch supports NUMA balancing
>    seccomp/ seccomp-filter       : VS.  -- |            HAVE_ARCH_SECCOMP_FILTER #  arch supports seccomp filters
>       time/ arch-tick-broadcast  : VS.  -- |             ARCH_HAS_TICK_BROADCAST #  arch provides tick_broadcast()
>       time/ clockevents          : VS.  ok |                 GENERIC_CLOCKEVENTS #  arch support generic clock events
>       time/ context-tracking     : VS.  -- |               HAVE_CONTEXT_TRACKING #  arch supports context tracking for NO_HZ_FULL
>       time/ irq-time-acct        : VS.  -- |            HAVE_IRQ_TIME_ACCOUNTING #  arch supports precise IRQ time accounting
>       time/ modern-timekeeping   : VS.  -- |            !ARCH_USES_GETTIMEOFFSET #  arch does not use arch_gettimeoffset() anymore
>       time/ virt-cpuacct         : VS.  -- |            HAVE_VIRT_CPU_ACCOUNTING #  arch supports precise virtual CPU time accounting
>         vm/ ELF-ASLR             : VS.  -- |              ARCH_HAS_ELF_RANDOMIZE #  arch randomizes the stack, heap and binary images of ELF binaries
>         vm/ huge-vmap            : VS.  -- |                 HAVE_ARCH_HUGE_VMAP #  arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
>         vm/ ioremap_prot         : VS.  -- |                   HAVE_IOREMAP_PROT #  arch has ioremap_prot()
>         vm/ numa-memblock        : VS.  ok |              HAVE_MEMBLOCK_NODE_MAP #  arch supports NUMA aware memblocks
>         vm/ PG_uncached          : VS.  -- |               ARCH_USES_PG_UNCACHED #  arch supports the PG_uncached page flag
>         vm/ pte_special          : VS.  -- |             __HAVE_ARCH_PTE_SPECIAL #  arch supports the pte_special()/pte_mkspecial() VM APIs
>         vm/ THP                  : VS.  -- |      HAVE_ARCH_TRANSPARENT_HUGEPAGE #  arch supports transparent hugepages
>         vm/ batch-unmap-tlb-flush: VS.  -- |   ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH #  arch supports deferral of TLB flush until multiple pages are unmapped
> 
> 
> Suggesting that riscv is not included within the hard-coded matrices.
> This also shows a first limitation of the proposed approach, i.e., it
> doesn't parse "Optimized asm/rwsem.h" (wants "true" configs). It also
> won't find "__HAVE_ARCH_PTE_SPECIAL" (reads Kconfig files) but things
> like "!ARCH_USES_GETTIMEOFFSET" could still be handled...
> 
> We could try switching to another architectures: none of these should
> result in "core/ BPF-JIT" set: the "HAVE_BPF_JIT" config was splitted
> into cBPF and eBPF variants more recently. The comparison of the hard
> coded status flags with the new/generated flags should also highlight
> out-of-date values.
> 
> Alternative/Additional help could probably be provided by checkpatch,
> say, warn when a patch touches/adds to Kconfig without updating such
> documentation...
> 
> Thoughts?

Yeah, so I think what should be done instead is to write a script that refreshes 
all the arch-support.txt files in-place.

(And no, I'd not add checkpatch support.)

It's OK for the script to have various quirks for weirdly implemented features and 
exceptions: i.e. basically whenever it gets a feature wrong, we can just tweak the 
script with quirks to make it all work out of box.
 
New features can then be added by basically just creating a header-only 
arch-support.txt file, such as:

  triton:~/tip/Documentation/features> cat foo/bar/arch-support.txt
  #
  # Feature name:          shiny new fubar kernel feature
  #         Kconfig:       ARCH_USE_FUBAR
  #         description:   arch supports the fubar feature
  #

And running Documentation/features/scripts/features-refresh.sh would auto-generate 
the arch support matrix.

Minimal changes to the existing arch-support.txt headers to make them more 
script-friendly would be OK as well I suppose, for example 
locking/rwsem-optimized/arch-support.txt right now has this:

  #         Kconfig:       Optimized asm/rwsem.h

A real Kconfig value could be used here - or even introduced, to make this all 
easier to support. I.e. it's OK to harmonize feature support within the kernel to 
make everything more clearly organized.

But in the end there should only be a single new script:

  Documentation/features/scripts/features-refresh.sh

... which operates on the arch-support.txt files and refreshes them in place, and 
which, after all the refreshes have been committed, should produce an empty
'git diff' result.

This way we soft- decouple the refreshing of the entries from the introduction of 
the features, while still making it all easy to keep sync and to extend.

I don't have the time to implement this feature myself, but if you'd like to try 
such an approach yourself, I can help merge the result upstream via the -tip tree.

Thanks,

	Ingo
