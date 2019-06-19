From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Date: Wed, 19 Jun 2019 10:12:27 +0200
Message-ID: <20190619081227.GL3419@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 18, 2019 at 04:16:20PM +0000, Vineet Gupta wrote:

> > +/*
> > + * To make atomic update of patched instruction available we need to guarantee
> > + * that this instruction doesn't cross L1 cache line boundary.
> > + *

Oh urgh. Is that the only way ARC can do text patching? We've actually
considered something like this on x86 at some point, but there we have
the 'fun' detail that the i-fetch window does not in fact align with L1
size on all uarchs, so that got complicated real fast.

I'm assuming you've looked at what x86 currently does and found
something like that doesn't work for ARC?

> > +/* Halt system on fatal error to make debug easier */
> > +#define arc_jl_fatal(format...)						\
> > +({									\
> > +	pr_err(JUMPLABEL_ERR format);					\
> > +	BUG();								\
> 
> Does it make sense to bring down the whole system vs. failing and returning.
> I see there is no error propagation to core code, but still.

It is what x86 does. And I've been fairly adamant about doing so. When
the kernel text is compromised, do you really want to continue running
it?

> > +})
> > +
> > +static inline u32 arc_gen_nop(void)
> > +{
> > +	/* 1x 32bit NOP in middle endian */

I dare not ask...

> > +	return 0x7000264a;
> > +}
> > +

> > +	/*
> > +	 * All instructions are aligned by 2 bytes so we should never get offset
> > +	 * here which is not 2 bytes aligned.
> > +	 */

> > +	WRITE_ONCE(*instr_addr, instr);
> > +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);

So do you have a 2 byte opcode that traps unconditionally? In that case
I'm thinking you could do something like x86 does. And it would avoid
that NOP padding you do to get the alignment.
