From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/6] rtc: m68k: provide rtc_class_ops directly
Date: Wed, 27 Apr 2016 12:34:19 +0200
Message-ID: <4888267.R0sXv0tuDQ@wuerfel>
References: <1461707551-1337971-1-git-send-email-arnd@arndb.de> <1461707551-1337971-2-git-send-email-arnd@arndb.de> <CAMuHMdXS0JL_weLvjV4+i0ZPj=N+G6Vs1WDE9jffGUWehq5Xzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXS0JL_weLvjV4+i0ZPj=N+G6Vs1WDE9jffGUWehq5Xzg@mail.gmail.com>
Sender: linux-m68k-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wednesday 27 April 2016 09:47:56 Geert Uytterhoeven wrote:
> > --- a/arch/m68k/kernel/time.c
> > +++ b/arch/m68k/kernel/time.c
> > @@ -86,7 +86,24 @@ void read_persistent_clock(struct timespec *ts)
> >         }
> >  }
> >
> > -#ifdef CONFIG_ARCH_USES_GETTIMEOFFSET
> > +#if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && defined(CONFIG_RTC_DRV_GENERIC)
> 
> s/defined/IS_ENABLED/ for the modular case.

Thanks, fixed in all three architectures/

> > @@ -95,7 +112,10 @@ static int __init rtc_init(void)
> >         if (!mach_hwclk)
> >                 return -ENODEV;
> >
> > -       pdev = platform_device_register_simple("rtc-generic", -1, NULL, 0);
> > +       /* or just call devm_rtc_device_register instead? */
> 
> I guess this comment is a bogus leftover? There's no "dev" parameter to
> pass to devm_rtc_device_register() here.

Sort of. When I wrote it, I thought that a NULL argument would work,
and I later found out myself that it doesn't.

I'll drop the comment there, but there are still a few ways we (probably
not me, but whoever is interested) could take this further:

- register both the device and the driver here, and call
  devm_rtc_device_register from the probe function so we can move away
  from drivers/rtc/rtc-generic.c

- do this separately for mac, mvme147, mvme16x, sun3, q40 and sun3x

- move the six implementations into drivers/rtc as standalone drivers.

One (AFAIK) unsolved problem here is the question of how to handle
read_boot_clock/read_persistent_clock/update_persistent_clock in this
case. This is a really odd API that is implemented in various ways
on a few major architectures, and not at all on others, so it's all
highly inconsistent.

	Arnd
