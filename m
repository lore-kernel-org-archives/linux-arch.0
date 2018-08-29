Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:55799 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbeH3DPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 23:15:03 -0400
MIME-Version: 1.0
References: <20180828112034.30875-1-npiggin@gmail.com> <20180828112034.30875-3-npiggin@gmail.com>
 <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com> <20180830091213.78b64354@roar.ozlabs.ibm.com>
In-Reply-To: <20180830091213.78b64354@roar.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Aug 2018 16:15:37 -0700
Message-ID: <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling in fork
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180829231537.73WDodXIlxoWHY8pa03jquGT49Y2OM2u_pElZ9bY_G8@z>

On Wed, Aug 29, 2018 at 4:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Dirty micro fault seems to be the big one for my Skylake, takes 300
> nanoseconds per access. Accessed takes about 100. (I think, have to
> go over my benchmark a bit more carefully and re-test).

Yeah, but they only happen for shared areas after fork, which sounds
like it shouldn't be a big deal in most cases.

And I'm not entirely objecting to your patch per se, I just would want
to keep the accessed bit changes separate from the dirty bit ones.

*If* somebody has bisectable issues with it (performance or not), it
will then be clearer what the exact issue is.

            Linus
