From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 0/8] Introduce the for_each_set_clump macro
Date: Mon, 10 Sep 2018 09:54:47 +0200
Message-ID: <CACRpkdah-CSkdmpYQ_sgOFNqXMD5mMLkmRDRBszK+twPbRNLpA@mail.gmail.com>
References: <cover.1526400945.git.vilhelm.gray@gmail.com> <CACRpkdbRH-Bz3BoczD+YmaSGqtoeCwtvGj4dGm8PKRKYFXTdKA@mail.gmail.com>
 <20180905150348.GA27089@sophia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905150348.GA27089@sophia>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Sep 5, 2018 at 5:04 PM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Wed, May 16, 2018 at 04:03:51PM +0200, Linus Walleij wrote:
> >On Tue, May 15, 2018 at 6:22 PM, William Breathitt Gray
> ><vilhelm.gray@gmail.com> wrote:
> >
> >> For example, suppose you would like to iterate over a 16-bit integer 4
> >> bits at a time, skipping over 4-bit groups with no set bit, where XXXX
> >> represents the current 4-bit group:
> >>
> >>     Example:        1011 1110 0000 1111
> >>     First loop:     1011 1110 0000 XXXX
> >>     Second loop:    1011 XXXX 0000 1111
> >>     Third loop:     XXXX 1110 0000 1111
> >>
> >> Each iteration of the loop returns the next 4-bit group that has at
> >> least one set bit.
> >>
> >> The for_each_set_clump macro has six parameters:
> >>
> >>     * clump: set to current clump index for the iteration
> >>     * index: set to current bitmap word index for the iteration
> >>     * offset: bits offset of the found clump in the bitmap word
> >>     * bits: bitmap to search within
> >>     * size: bitmap size in number of clumps
> >>     * clump_size: clump size in number of bits
> >>
> >> The clump_size argument can be an arbitrary number of bits and is not
> >> required to be a multiple of 2.
> >
> >I must say I'm impressed. Very nice arithmetics going on there.
> >
> >If I can get some ACK for the bitops patch I'd be happy to merge
> >it all through the GPIO tree. The users are pretty clear cut.
> >
> >BTW: if I could, I would pull out Donald Knuth's "The Art of Computer
> >Programming vol 4A" chapter 7.1.3 "Bitwise Tricks and Techniques"
> >to see what he has to say about the subject, but I don't have
> >that book as it turns out.
> >
> >Yours,
> >Linus Walleij
>
> Hi Linus,
>
> I'd like to get this patchset merged, but I'm aware that we haven't yet
> received additional ACKs in the past couple months. Are there any
> changes you would like made, or should I resubmit this patchset with
> additional CCs in the hopes of some ACKs for the bitops patch?

It seems Andy wanted some time and he had ~4 months now
so either he forgot it or has way too much to do.

I would say send this patch to Andrew Morton (the bitops patches)
so he can decide on it. He has the right bird's eye view on this
kind of things.

Yours,
Linus Walleij
