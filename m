From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Date: Mon, 9 Jul 2018 11:23:19 +0200
Message-ID: <CAMuHMdUdTNpt6G1gzdd6tg9cTo4+kOQCP0Ekouhogug_1sJNPg@mail.gmail.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com> <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Greg KH <greg@kroah.com>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, stable <stable@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 9, 2018 at 11:15 AM David Laight <David.Laight@aculab.com> wrote:
> From: Alexey Brodkin
> > Sent: 09 July 2018 05:45
> > Depending on ABI "long long" type of a particular 32-bit CPU
> > might be aligned by either word (32-bits) or double word (64-bits).
> > Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> >
> > At least for 32-bit ARC cores ABI requires "long long" types
> > to be aligned by normal 32-bit word. This makes "data" field aligned to
> > 12 bytes. Which is still OK as long as we use 32-bit data only.
> >
> > But once we want to use native atomic64_t type (i.e. when we use special
> > instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> > misaligned access exception.
>
> Shouldn't there be a typedef for the actual type.
> Perhaps it is even atomic64_t ?
> And have the __aligned(8) applied to that typedef ??

That indeed sounds like the best thing to do, as it will fix this issue in other
places, too.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
