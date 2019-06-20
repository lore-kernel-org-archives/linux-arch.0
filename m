Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfFTHBd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Jun 2019 03:01:33 -0400
Date: Thu, 20 Jun 2019 09:01:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Message-ID: <20190620070120.GU3402@hirez.programming.kicks-ass.net>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190620070120.XzVUFYQkzHrFEKyveQI_BN_BpxlPko11wNZu00SrPg4@z>

On Wed, Jun 19, 2019 at 11:55:41PM +0000, Vineet Gupta wrote:
> On 6/19/19 1:12 AM, Peter Zijlstra wrote:

> > I'm assuming you've looked at what x86 currently does and found
> > something like that doesn't work for ARC?
> 
> Just looked at x86 code and it seems similar

I think you missed a bit.

> >>> +	WRITE_ONCE(*instr_addr, instr);
> >>> +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);
> > So do you have a 2 byte opcode that traps unconditionally? In that case
> > I'm thinking you could do something like x86 does. And it would avoid
> > that NOP padding you do to get the alignment.
> 
> Just to be clear there is no trapping going on in the canonical sense of it. There
> are regular instructions for NO-OP and Branch.
> We do have 2 byte opcodes for both but as described the branch offset is too
> limited so not usable.

In particular we do not need the alignment.

So what the x86 code does is:

 - overwrite the first byte of the instruction with a single byte trap
   instruction

 - machine wide IPI which synchronizes I$

At this point, any CPU that encounters this instruction will trap; and
the trap handler will emulate the 'new' instruction -- typically a jump.

  - overwrite the tail of the instruction (if there is a tail)

  - machine wide IPI which syncrhonizes I$

At this point, nobody will execute the tail, because we'll still trap on
that first single byte instruction, but if they were to read the
instruction stream, the tail must be there.

  - overwrite the first byte of the instruction to now have a complete
    instruction.

  - machine wide IPI which syncrhonizes I$

At this point, any CPU will encounter the new instruction as a whole,
irrespective of alignment.


So the benefit of this scheme is that is works irrespective of the
instruction fetch window size and don't need the 'funny' alignment
stuff.

Now, I've no idea if something like this is feasible on ARC; for it to
work you need that 2 byte trap instruction -- since all instructions are
2 byte aligned, you can always poke that without issue.
