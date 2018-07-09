From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
Date: Mon, 9 Jul 2018 15:49:14 +0200
Message-ID: <CAMuHMdWQNZ-Dpakqk7mTJ-O_H0QnCd-KUWpWNJC_d6Yw8GH0Kg@mail.gmail.com>
References: <20180709124741.21037-1-abrodkin@synopsys.com> <3d3ec70d99524a6fa7a38e7d2e0fdf98@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d3ec70d99524a6fa7a38e7d2e0fdf98@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@aculab.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Greg KH <gregkh@linuxfoundatio>
List-Id: linux-arch.vger.kernel.org

On Mon, Jul 9, 2018 at 3:29 PM David Laight <David.Laight@aculab.com> wrote:
> From: Alexey Brodkin
> > Sent: 09 July 2018 13:48
> > Atomic instructions require data they operate on to be aligned
> > according to data size. I.e. 32-bit atomic values must be 32-bit
> > aligned while 64-bit values must be 64-bit aligned.
> >
> > Otherwise even if CPU may handle not-aligend normal data access,
> > still atomic instructions fail and typically raise an exception
> > leaving us dead in the water.
> ...
> > diff --git a/include/asm-generic/atomic64.h b/include/asm-generic/atomic64.h
> > index 8d28eb010d0d..b94b749b5952 100644
> > --- a/include/asm-generic/atomic64.h
> > +++ b/include/asm-generic/atomic64.h
> > @@ -13,7 +13,7 @@
> >  #define _ASM_GENERIC_ATOMIC64_H
> >
> >  typedef struct {
> > -     long long counter;
> > +     u64 __aligned(8) counter;
> >  } atomic64_t;
>
> Apart from the fact that this changes the value from signed to unsigned
> should most of the architectures be using this generic definition?

64-bit architectures use the one from include/linux/types.h instead.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
