From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 29/31] arch,xtensa: Convert smp_mb__*
Date: Wed, 19 Mar 2014 14:30:30 +0100
Message-ID: <20140319133030.GA7744@laptop.programming.kicks-ass.net>
References: <20140319064729.660482086@infradead.org>
 <20140319065205.319240141@infradead.org>
 <CAMo8BfLLFqYz96LLJy0f+9XgAdQVUVhRg_VGp+yG92Gfk=sfaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfLLFqYz96LLJy0f+9XgAdQVUVhRg_VGp+yG92Gfk=sfaQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, will.deacon@arm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 19, 2014 at 05:11:34PM +0400, Max Filippov wrote:
> Hi Peter,
> 
> On Wed, Mar 19, 2014 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > Xtensa SMP has ll/sc which is fully serializing, therefore its exising
> 
> One minor correction: current xtensa ISA doens't have ll/sc, it only
> has cas (s32c1i instruction), which is fully serializing.

Oh; my bad in reading your asm. The l32i and s32cli read like a load 32
and store 32 conditional to me. But sure, cas works too :-)

I'll ammend the changelog. Thanks!
