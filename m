Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dc8-smtprelay2.synopsys.com ([198.182.47.102]:50542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726062AbfFTSsb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Jun 2019 14:48:31 -0400
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
 <20190619081227.GL3419@hirez.programming.kicks-ass.net>
 <C2D7FE5348E1B147BCA15975FBA2307501A252E40B@us01wembx1.internal.synopsys.com>
 <20190620070120.GU3402@hirez.programming.kicks-ass.net>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <a0a1aa81-d46e-71db-ff7b-207bc468068d@synopsys.com>
Date: Thu, 20 Jun 2019 11:48:17 -0700
MIME-Version: 1.0
In-Reply-To: <20190620070120.GU3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Jason Baron <jbaron@akamai.com>, Paolo Bonzini <pbonzini@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190620184817.aB7KCRJwS9Hl3Q7RpkTdvADz2f83B8vr_JGZV2NYZm0@z>

On 6/20/19 12:01 AM, Peter Zijlstra wrote:

> 
> In particular we do not need the alignment.
> 
> So what the x86 code does is:
> 
>  - overwrite the first byte of the instruction with a single byte trap
>    instruction
> 
>  - machine wide IPI which synchronizes I$
> 
> At this point, any CPU that encounters this instruction will trap; and
> the trap handler will emulate the 'new' instruction -- typically a jump.
> 
>   - overwrite the tail of the instruction (if there is a tail)
> 
>   - machine wide IPI which syncrhonizes I$
> 
> At this point, nobody will execute the tail, because we'll still trap on
> that first single byte instruction, but if they were to read the
> instruction stream, the tail must be there.
> 
>   - overwrite the first byte of the instruction to now have a complete
>     instruction.
> 
>   - machine wide IPI which syncrhonizes I$
> 
> At this point, any CPU will encounter the new instruction as a whole,
> irrespective of alignment.
> 
> 
> So the benefit of this scheme is that is works irrespective of the
> instruction fetch window size and don't need the 'funny' alignment
> stuff.
> 
> Now, I've no idea if something like this is feasible on ARC; for it to
> work you need that 2 byte trap instruction -- since all instructions are
> 2 byte aligned, you can always poke that without issue.

We do have a 2 byte TRAP_S u6 which is used for all/any trap'ing: syscalls,
software breakpoint, kprobes etc. But using it like x86 seems a bit excessive for
ARC. Given that x86 doesn't implement flush_icache_range() it must have I$
snooping D$ and also this machine wide IPI sync I$ must be totally under the hood
all hardware affair - unlike ARC which needs on_each_cpu( I$ line range).

Using TRAP_S would actually requires 2 passes (and 2 rounds of IPI) for code
patching - the last one to undo the TRAP_S itself.

I do worry about the occasional alignment induced extra NOP_S instruction (2 byte)
but there doesn't seem to be an easy solution. Heck if we could use the NOP_S /
B_S in first place. While not a clean solution by any standards, could anything be
done to reduce the code path of DO_ONCE() so that unlikely code is not too far off.
