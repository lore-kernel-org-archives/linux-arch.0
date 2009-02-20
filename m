From: Suresh Siddha <suresh.b.siddha@intel.com>
Subject: Re: smp.c && barriers (Was: [PATCH 1/4] generic-smp: remove single
	ipi fallback for smp_call_function_many())
Date: Fri, 20 Feb 2009 10:56:54 -0800
Message-ID: <1235156214.14523.54.camel@vayu>
References: <20090217101130.GA8660@wotan.suse.de>
	 <1234866453.4744.58.camel@laptop> <20090217112657.GE26402@wotan.suse.de>
	 <1234923702.29823.7.camel@vayu> <20090218135945.GC23125@wotan.suse.de>
	 <1234982620.29823.22.camel@vayu> <20090218191757.GD8889@elte.hu>
	 <1235001314.14523.2.camel@vayu> <20090219122031.GC1703@elte.hu>
	 <1235080824.14523.19.camel@vayu>  <20090220105640.GE28581@elte.hu>
Reply-To: Suresh Siddha <suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755786AbZBTS6u@vger.kernel.org>
In-Reply-To: <20090220105640.GE28581@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <npiggin@suse.de>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Oleg Nesterov <oleg@redhat.com>, Jens Axboe <jens.axboe@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, steiner@sgi.com
List-Id: linux-arch.vger.kernel.org

On Fri, 2009-02-20 at 02:56 -0800, Ingo Molnar wrote:
> * Suresh Siddha <suresh.b.siddha@intel.com> wrote:
> 
> > On Thu, 2009-02-19 at 04:20 -0800, Ingo Molnar wrote:
> > > Could you please refresh this patch to latest tip:master? The 
> > > APIC drivers moved to arch/x86/kernel/apic/.
> > 
> > Appended the refreshed patch. Thanks.
> 
> thanks. Two details i noticed:
> 
> Firstly:
> 
> > +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> > +++ b/arch/x86/kernel/apic/x2apic_phys.c
> 
> how about x2apic_uv.c? It uses uv_write_global_mmr64() in its 
> IPI sending method, which uses:
> 
> static inline void uv_write_global_mmr64(int pnode, unsigned long offset,
>                                 unsigned long val)
> {
>         *uv_global_mmr64_address(pnode, offset) = val;
> }
> 
> which uses ->mmr_base, which is mapped via:
> 
>         init_extra_mapping_uc(UV_LOCAL_MMR_BASE, UV_LOCAL_MMR_SIZE);
>
> so it should be fine because uncached - but at minimum we should 
> put a comment into x2apic_uv.c that the generic IPI code relies 
> on the lowlevel code serializing - i.e. relies on the UC PAT 
> attribute.

Oops. I forgot to mention that and copy Jack to confirm our
understanding. I can send a followup patch adding the comments for UV.
Jack, are you ok?

> 
> Secondly, you added smp_mb(), which will translate to an MFENCE. 
> 
> But in theory it should be enough to have a wmb() here. [Note, 
> not an smp_wmb() that i suggested before.] That will translate 
> to an SFENCE - which will serialize writes but still allows 
> reads/prefetches to pass.
> 
> So the question is, is an SFENCE there enough to serialize the 
> WRMSR with previous memory-writes? It's not specified in the 
> x2apic docs as far as i could see.

No. sfence is not enough (wrmsr to x2apic regs was still passing ahead).
We have done a small experiment to demonstrate the issue and adding
mfence fixes the issue but not sfence. We need a serializing instruction
or mfence. I will try to get the SDM updated.

thanks,
suresh
