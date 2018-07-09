Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34237 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932436AbeGIOKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:10:36 -0400
MIME-Version: 1.0
References: <20180709134550.29541-1-abrodkin@synopsys.com> <20180709135409.GQ2476@hirez.programming.kicks-ass.net>
 <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
In-Reply-To: <20180709140438.ashvw4otyusj3nfa@lakrids.cambridge.arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Jul 2018 16:10:23 +0200
Message-ID: <CAMuHMdUS1QXuV8L1zadJ4XP=2g4pfoXgKByZ7Yg9PEbXOT_KVw@mail.gmail.com>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, David Laight <David.Laight@aculab.com>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>, Greg KH <greg@kroah.com>, stable <stable@vger.kernel.org>
Message-ID: <20180709141023.LXemXzZ-859U1bEpE7S0WiKsHrfkWmwPOZxnAzAnCXs@z>

On Mon, Jul 9, 2018 at 4:04 PM Mark Rutland <mark.rutland@arm.com> wrote:
> On Mon, Jul 09, 2018 at 03:54:09PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 09, 2018 at 04:45:50PM +0300, Alexey Brodkin wrote:
> > > diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> > > index f98a097e73f2..d65327cb83c9 100644
> > > --- a/drivers/base/devres.c
> > > +++ b/drivers/base/devres.c
> > > @@ -24,8 +24,12 @@ struct devres_node {
> > >
> > >  struct devres {
> > >     struct devres_node              node;
> > > -   /* -- 3 pointers */
> > > -   unsigned long long              data[]; /* guarantee ull alignment */
> > > +   /*
> > > +    * data[] must be 64 bit aligned even on 32 bit architectures
> > > +    * because it might be accessed by instructions that require
> > > +    * aligned memory arguments such as atomic64_t.
> > > +    */
> > > +   u8 __aligned(8)                 data[];
> > >  };
> >
> > From a quick reading in Documentation/driver-model/devres.txt this
> > devres muck is supposed to be device memory, right?
>
> It's for associating resources (e.g. memory allocations) with a struct
> device.
>
> e.g. you do:
>
>         devm_kmalloc(dev, size, GFP_KERNEL);
>
> ... and that allocates sizeof(struct devres) + size, putting some
> accounting data into that devres, and returning a pointer to the
> remaining size bytes.
>
> The data[] thing is a hack to ensure that the structure is padded to
> 64-bit alignment, in case you'd done:
>
> struct foo {
>         atomic64_t counter;
> }
>
> struct foo *f = devm_kmalloc(dev, sizeof(*f), GFP_KERNEL);

So the big issue is that the minimum alignment of a buffer allocated with
devm_kmalloc() and friends is different (lower) than when allocated with
kmalloc().

On 32-bit, it's only aligned to 4 bytes. Ugh.
I wouldn't be surprised if some callers assume it to be cacheline-aligned...

Which means blind conversions to the devm_*() versions can be dangerous.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
