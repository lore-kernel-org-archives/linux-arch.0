From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
Date: Wed, 29 Aug 2018 08:42:09 -0700
Message-ID: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com> <20180828112034.30875-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828112034.30875-3-npiggin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 28, 2018 at 4:20 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> fork clears dirty/accessed bits from new ptes in the child. This logic
> has existed since mapped page reclaim was done by scanning ptes when
> it may have been quite important. Today with physical based pte
> scanning, there is less reason to clear these bits.

Can you humor me, and make the dirty/accessed bit patches separate?

There is actually a difference wrt the dirty bit: if we unmap an area
with dirty pages, we have to do the special synchronous flush.

So a clean page in the virtual mapping is _literally_ cheaper to have.

> This eliminates a major source of faults powerpc/radix requires to set
> dirty/accessed bits in ptes, speeding up a fork/exit microbenchmark by
> about 5% on POWER9 (16600 -> 17500 fork/execs per second).

I don't think the dirty bit matters.

The accessed bit I think may be worth keeping, so by all means remove the mkold.

                  Linus
