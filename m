Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36304 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2Tjw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 15:39:52 -0400
MIME-Version: 1.0
References: <20180828112034.30875-1-npiggin@gmail.com> <20180828112034.30875-3-npiggin@gmail.com>
In-Reply-To: <20180828112034.30875-3-npiggin@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Aug 2018 08:42:09 -0700
Message-ID: <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180829154209.Whdt5tWLTpahm3x4apXfXXAw1ERZIOdoCXjDGIfkvDo@z>

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
