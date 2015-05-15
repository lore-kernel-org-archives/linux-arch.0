Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37697 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbbEOHv2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2015 03:51:28 -0400
Date: Fri, 15 May 2015 09:51:23 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
Message-ID: <20150515075122.GA5270@gmail.com>
References: <20150513131835.GJ1517@pd.tnic>
 <20150513134842.GA1657@gmail.com>
 <20150513162757.GA21894@x>
 <20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
 <20150514101518.GA27550@gmail.com>
 <20150514103544.GA7027@gmail.com>
 <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
 <20150514195925.GA27570@gmail.com>
 <20150515083334.535ad43e@canb.auug.org.au>
 <20150515073805.GA14993@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150515073805.GA14993@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150515075123.UCta8FtxvkgFsleJZV0YJmKQQ1SWLgS-gtYrolpvt9M@z>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Ingo,
> > 
> > Thanks for this.  The concept is certainly good.
> > 
> > On Thu, 14 May 2015 21:59:25 +0200 Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > The patch that adds a new architecture to all these files would give 
> > > us a good overview about how complete an initial port is.
> > 
> > If you want to test how hard that is (and what sort of patch it
> > produces), the h8300 architecture was added to linux-next recently.
> 
> I tried this out, this is the resulting feature support matrix for the 
> new h8300 architecture:
> 
> #
> # Kernel feature support matrix of architecture 'h8300':
> #
>            arch-tick-broadcast:     |       h8300: | TODO |
>                        BPF-JIT:     |       h8300: | TODO |

Perhaps the more verbose table is more useful:

#
# Kernel feature support matrix of architecture 'h8300':
#
   arch-tick-broadcast:  | TODO |                            ARCH_HAS_TICK_BROADCAST #  arch provides tick_broadcast()
               BPF-JIT:  | TODO |                                       HAVE_BPF_JIT #  arch supports BPF JIT optimizations
           clockevents:  |  ok  |                                GENERIC_CLOCKEVENTS #  arch support generic clock events
         cmpxchg-local:  | TODO |                                 HAVE_CMPXCHG_LOCAL #  arch supports the this_cpu_cmpxchg() API
      context-tracking:  | TODO |                              HAVE_CONTEXT_TRACKING #  arch supports context tracking for NO_HZ_FULL
         dma-api-debug:  | TODO |                                 HAVE_DMA_API_DEBUG #  arch supports DMA debug facilities
        dma-contiguous:  | TODO |                                HAVE_DMA_CONTIGUOUS #  arch supports the DMA CMA (continuous memory allocator)
         dma_map_attrs:  |  ok  |                                     HAVE_DMA_ATTRS #  arch provides dma_*map*_attrs() APIs
              ELF-ASLR:  | TODO |                             ARCH_HAS_ELF_RANDOMIZE #  arch randomizes the stack, heap and binary images of ELF binaries
      gcov-profile-all:  | TODO |                          ARCH_HAS_GCOV_PROFILE_ALL #  arch supports whole-kernel GCOV code coverage profiling
   generic-idle-thread:  | TODO |                            GENERIC_SMP_IDLE_THREAD #  arch makes use of the generic SMP idle thread facility
             huge-vmap:  | TODO |                                HAVE_ARCH_HUGE_VMAP #  arch supports the ioremap_pud_enabled() and ioremap_pmd_enabled() VM APIs
          ioremap_prot:  | TODO |                                  HAVE_IOREMAP_PROT #  arch has ioremap_prot()
         irq-time-acct:  | TODO |                           HAVE_IRQ_TIME_ACCOUNTING #  arch supports precise IRQ time accounting
           jump-labels:  | TODO |                               HAVE_ARCH_JUMP_LABEL #  arch supports live patched high efficiency branches
                 KASAN:  | TODO |                                    HAVE_ARCH_KASAN #  arch supports the KASAN runtime memory checker
                  kgdb:  | TODO |                                     HAVE_ARCH_KGDB #  arch supports the kGDB kernel debugger
               kprobes:  | TODO |                                       HAVE_KPROBES #  arch supports live patched kernel probe
         kprobes-event:  | TODO |                     HAVE_REGS_AND_STACK_ACCESS_API #  arch supports kprobes with perf events
     kprobes-on-ftrace:  | TODO |                             HAVE_KPROBES_ON_FTRACE #  arch supports combined kprobes and ftrace live patching
            kretprobes:  | TODO |                                    HAVE_KRETPROBES #  arch supports kernel function-return probes
               lockdep:  | TODO |                                    LOCKDEP_SUPPORT #  arch supports the runtime locking correctness debug facility
    modern-timekeeping:  |  ok  |                           !ARCH_USES_GETTIMEOFFSET #  arch does not use arch_gettimeoffset() anymore
        numa-balancing:  |  ..  |      ARCH_SUPPORTS_NUMA_BALANCING && 64BIT && NUMA #  arch supports NUMA balancing
         numa-memblock:  |  ..  |                             HAVE_MEMBLOCK_NODE_MAP #  arch supports NUMA aware memblocks
             optprobes:  | TODO |                                     HAVE_OPTPROBES #  arch supports live patched optprobes
             perf-regs:  | TODO |                                     HAVE_PERF_REGS #  arch supports perf events register access
        perf-stackdump:  | TODO |                          HAVE_PERF_USER_STACK_DUMP #  arch supports perf events stack dumps
           PG_uncached:  | TODO |                              ARCH_USES_PG_UNCACHED #  arch supports the PG_uncached page flag
  pmdp_splitting_flush:  | TODO |           #define __HAVE_ARCH_PMDP_SPLITTING_FLUSH #  arch supports the pmdp_splitting_flush() VM API
           pte_special:  | TODO |                    #define __HAVE_ARCH_PTE_SPECIAL #  arch supports the pte_special()/pte_mkspecial() VM APIs
        queued-rwlocks:  | TODO |                            ARCH_USE_QUEUED_RWLOCKS #  arch supports queued rwlocks
      queued-spinlocks:  | TODO |                          ARCH_USE_QUEUED_SPINLOCKS #  arch supports queued spinlocks
       rwsem-optimized:  |  ok  |                              Optimized asm/rwsem.h #  arch provides optimized rwsem APIs
        seccomp-filter:  | TODO |                           HAVE_ARCH_SECCOMP_FILTER #  arch supports seccomp filters
              sg-chain:  | TODO |                                  ARCH_HAS_SG_CHAIN #  arch supports chained scatter-gather lists
        stackprotector:  | TODO |                             HAVE_CC_STACKPROTECTOR #  arch supports compiler driven stack overflow protection
           strncasecmp:  | TODO |                            __HAVE_ARCH_STRNCASECMP #  arch provides an optimized strncasecmp() function
                   THP:  |  ..  |            HAVE_ARCH_TRANSPARENT_HUGEPAGE && 64BIT #  arch supports transparent hugepages
             tracehook:  | TODO |                                HAVE_ARCH_TRACEHOOK #  arch supports tracehook (ptrace) register handling APIs
               uprobes:  | TODO |                              ARCH_SUPPORTS_UPROBES #  arch supports live patched user probes
     user-ret-profiler:  | TODO |                          HAVE_USER_RETURN_NOTIFIER #  arch supports user-space return from system call profiler
          virt-cpuacct:  | TODO |                  HAVE_VIRT_CPU_ACCOUNTING || 64BIT #  arch supports precise virtual CPU time accounting

Thanks,

	Ingo
