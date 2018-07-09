From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 11:03:54 +0200
Message-ID: <CAMuHMdXJ7izWV2iRYogYzoufrOtqo43c54X78D2FSH8yd2_oaQ@mail.gmail.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com> <20180709054842.GB7618@kroah.com>
 <CAMuHMdVBBu6gho_JVQTiOHxVFHqX2MUxS_c-6-x50OEu4OqpRQ@mail.gmail.com>
 <71dfb71de86ebe365897b2069bec0cb40b376928.camel@synopsys.com>
 <CAMuHMdULgdLsETpZ9+RC6d2ZoARPs72Fn=SRboM-8Xm7t1Qd2g@mail.gmail.com> <cabc2aa35ecf81dc7a47d4ec7bd5dcb1c3d566c3.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cabc2aa35ecf81dc7a47d4ec7bd5dcb1c3d566c3.camel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, stable <stable@vger.kernel.org>, Greg KH <greg@kroah.com>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Hi Alexey,

On Mon, Jul 9, 2018 at 10:37 AM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> On Mon, 2018-07-09 at 09:52 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 9, 2018 at 9:22 AM Alexey Brodkin
> > <Alexey.Brodkin@synopsys.com> wrote:
> > > On Mon, 2018-07-09 at 09:07 +0200, Geert Uytterhoeven wrote:
> > > > On Mon, Jul 9, 2018 at 7:49 AM Greg KH <greg@kroah.com> wrote:
> > > > > On Mon, Jul 09, 2018 at 07:44:44AM +0300, Alexey Brodkin wrote:
> > > > > > Depending on ABI "long long" type of a particular 32-bit CPU
> > > > > > might be aligned by either word (32-bits) or double word (64-bits).
> > > >
> > > > Or even 16-bit (on e.g. m68k).
> > >
> > > Indeed, thanks for the note!
> > > Will add this in my v3.
> >
> > Note that in this particular case, the field will probably always be
> > aligned to 4 bytes,
> > as the struct will be allocated using *alloc().
>
> Well I think maybe it worth mentioning only 32-bit and 64-bit alignments in
> this particular case because as it was mentioned initially in the comment there're
> 3 pointers before "data" field and for 32-bit machines I guess we may safely
> assume that a pointer size is 32-bit.
>
> This leaves us only one problematic situation 32-bit instead of 64-bit alignment.
>
> > > For ARC I'd like this fix to be back-ported starting
> > > from v4.8 where we added support of "native" atomic64_t, see commit
> > > ce6365270ecd (" ARCv2: Implement atomic64 based on LLOCKD/SCONDD instructions").
> > >
> > > What about m68k, do you have any preference of earliest kernel version
> > > where this fix might be useful?
> >
> > Given m68k is 32-bit, it will access atomic64_t variables while
> > holding a spinlock,
> > so it should still be safe without this change.
>
> Well ARC and ARMv7 are 32-bit machines as well still both have
> a special instructions to read/write 64-bit data.

Sure.

> > Not to mention no one will try etnaviv on m68k ;-)
>
> See it was just a trigger case but other GPUs that use or will use
> DRM GPU scheduler are good candidates to it that problem and not to
> mention some other users of atomic64_t.
>
> But from you above comment I may deduce that m68k doesn't have
> instructions for 64-bit data; in that case there's no reason to worry
> at least about struct devres_node :)

That's correct: m68k has no instructions for 64-bit data.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
