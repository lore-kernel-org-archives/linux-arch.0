Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33183 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbeH3D5P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 23:57:15 -0400
Date: Thu, 30 Aug 2018 09:57:47 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/3] mm/cow: optimise pte dirty/accessed bits handling
 in fork
Message-ID: <20180830095747.491f7770@roar.ozlabs.ibm.com>
In-Reply-To: <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
References: <20180828112034.30875-1-npiggin@gmail.com>
        <20180828112034.30875-3-npiggin@gmail.com>
        <CA+55aFwbZrsdZEh0ds1W3AWUeTamDRheQPKSi9O=--cEOSjr5g@mail.gmail.com>
        <20180830091213.78b64354@roar.ozlabs.ibm.com>
        <CA+55aFzBHNsLNs4TfOrMQXTsV9u8=7yAu4GbsOM84AQb-OhJmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20180829235747.qFwMUHClF5b7gj-UwrpZIMQ_JWJ1uB8ndZBzzV2GDd4@z>

On Wed, 29 Aug 2018 16:15:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Aug 29, 2018 at 4:12 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Dirty micro fault seems to be the big one for my Skylake, takes 300
> > nanoseconds per access. Accessed takes about 100. (I think, have to
> > go over my benchmark a bit more carefully and re-test).  
> 
> Yeah, but they only happen for shared areas after fork, which sounds
> like it shouldn't be a big deal in most cases.

You might be right there.

> 
> And I'm not entirely objecting to your patch per se, I just would want
> to keep the accessed bit changes separate from the dirty bit ones.
> 
> *If* somebody has bisectable issues with it (performance or not), it
> will then be clearer what the exact issue is.

Yeah that makes a lot of sense. I'll do a bit more testing and send
Andrew a respin at least with those split (and a good comment for
the dirty bit vs unmap handling that you pointed out).

Thanks,
Nick
