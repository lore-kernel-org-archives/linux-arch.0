Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36208 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbbEOHiM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 May 2015 03:38:12 -0400
Date: Fri, 15 May 2015 09:38:06 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] Documentation/arch: Add kernel feature descriptions
 and arch support status under Documentation/features/
Message-ID: <20150515073805.GA14993@gmail.com>
References: <20150513094756.GD11030@gmail.com>
 <20150513131835.GJ1517@pd.tnic>
 <20150513134842.GA1657@gmail.com>
 <20150513162757.GA21894@x>
 <20150513150523.ddd65d7cd51f820b78f0c8e3@linux-foundation.org>
 <20150514101518.GA27550@gmail.com>
 <20150514103544.GA7027@gmail.com>
 <20150514123835.1bf436bc35d711f8dbf9bc0f@linux-foundation.org>
 <20150514195925.GA27570@gmail.com>
 <20150515083334.535ad43e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150515083334.535ad43e@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Triplett <josh@joshtriplett.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Message-ID: <20150515073806.jHHLuyumXe2uDhoWvOpLCYma6qOQr2bMKW1Y4SOQoyc@z>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> Thanks for this.  The concept is certainly good.
> 
> On Thu, 14 May 2015 21:59:25 +0200 Ingo Molnar <mingo@kernel.org> wrote:
> >
> > The patch that adds a new architecture to all these files would give 
> > us a good overview about how complete an initial port is.
> 
> If you want to test how hard that is (and what sort of patch it
> produces), the h8300 architecture was added to linux-next recently.

I tried this out, this is the resulting feature support matrix for the 
new h8300 architecture:

#
# Kernel feature support matrix of architecture 'h8300':
#
           arch-tick-broadcast:     |       h8300: | TODO |
                       BPF-JIT:     |       h8300: | TODO |
                   clockevents:     |       h8300: |  ok  |
                 cmpxchg-local:     |       h8300: | TODO |
              context-tracking:     |       h8300: | TODO |
                 dma-api-debug:     |       h8300: | TODO |
                dma-contiguous:     |       h8300: | TODO |
                 dma_map_attrs:     |       h8300: |  ok  |
                      ELF-ASLR:     |       h8300: | TODO |
              gcov-profile-all:     |       h8300: | TODO |
           generic-idle-thread:     |       h8300: | TODO |
                     huge-vmap:     |       h8300: | TODO |
                  ioremap_prot:     |       h8300: | TODO |
                 irq-time-acct:     |       h8300: | TODO |
                   jump-labels:     |       h8300: | TODO |
                         KASAN:     |       h8300: | TODO |
                          kgdb:     |       h8300: | TODO |
                       kprobes:     |       h8300: | TODO |
                 kprobes-event:     |       h8300: | TODO |
             kprobes-on-ftrace:     |       h8300: | TODO |
                    kretprobes:     |       h8300: | TODO |
                       lockdep:     |       h8300: | TODO |
            modern-timekeeping:     |       h8300: |  ok  |
                numa-balancing:     |       h8300: |  ..  |
                 numa-memblock:     |       h8300: |  ..  |
                     optprobes:     |       h8300: | TODO |
                     perf-regs:     |       h8300: | TODO |
                perf-stackdump:     |       h8300: | TODO |
                   PG_uncached:     |       h8300: | TODO |
          pmdp_splitting_flush:     |       h8300: | TODO |
                   pte_special:     |       h8300: | TODO |
                queued-rwlocks:     |       h8300: | TODO |
              queued-spinlocks:     |       h8300: | TODO |
               rwsem-optimized:     |       h8300: |  ok  |
                seccomp-filter:     |       h8300: | TODO |
                      sg-chain:     |       h8300: | TODO |
                stackprotector:     |       h8300: | TODO |
                   strncasecmp:     |       h8300: | TODO |
                           THP:     |       h8300: |  ..  |
                     tracehook:     |       h8300: | TODO |
                       uprobes:     |       h8300: | TODO |
             user-ret-profiler:     |       h8300: | TODO |
                  virt-cpuacct:     |       h8300: | TODO |

Thanks,

	Ingo
