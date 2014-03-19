From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 29/31] arch,xtensa: Convert smp_mb__*
Date: Wed, 19 Mar 2014 17:11:34 +0400
Message-ID: <CAMo8BfLLFqYz96LLJy0f+9XgAdQVUVhRg_VGp+yG92Gfk=sfaQ@mail.gmail.com>
References: <20140319064729.660482086@infradead.org>
	<20140319065205.319240141@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140319065205.319240141@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, will.deacon@arm.com, Paul McKenney <paulmck@linux.vnet.ibm.com>
List-Id: linux-arch.vger.kernel.org

Hi Peter,

On Wed, Mar 19, 2014 at 10:47 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> Xtensa SMP has ll/sc which is fully serializing, therefore its exising

One minor correction: current xtensa ISA doens't have ll/sc, it only
has cas (s32c1i instruction), which is fully serializing.

> smp_mb__{before,after}_clear_bit() appear unduly heavy.
>
> Implement the new barriers are barrier().
>
> Signed-off-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/xtensa/include/asm/atomic.h  |    7 +------
>  arch/xtensa/include/asm/barrier.h |    3 +++
>  arch/xtensa/include/asm/bitops.h  |    4 +---
>  3 files changed, 5 insertions(+), 9 deletions(-)

-- 
Thanks.
-- Max
