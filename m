From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 04/27] asm-generic: add legacy I/O header files
Date: Fri, 1 May 2009 14:22:29 +0200
Message-ID: <200905011422.29753.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <10b3a32656e5552458db7412ef9ff8530d5f92aa.1241105648.git.arnd@arndb.de> <c1a198be0904302309w4154f97dqddd0b2df1924a821@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.177]:49467 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbZEAMWn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 08:22:43 -0400
In-Reply-To: <c1a198be0904302309w4154f97dqddd0b2df1924a821@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Michal Simek wrote:
> > +/*
> > + * CLOCK_TICK_RATE is highly PC-specific and should not
> > + * be used in portable code. 1193182 is the value for the
> > + * original i8253 PIC.
> > + */
> > +#ifndef CLOCK_TICK_RATE
> > +#define CLOCK_TICK_RATE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01193182
> > +#endif
>=20
>=20
> Why is this in generic code?

CLOCK_TICK_RATE is only used in a few places:

drivers/char/vt_ioctl.c:                        arg =3D CLOCK_TICK_RATE=
 / arg;
drivers/char/vt_ioctl.c:                        count =3D CLOCK_TICK_RA=
TE / count;
drivers/clocksource/acpi_pm.c:  ((CALIBRATE_LATCH * (PMTMR_TICKS_PER_SE=
C >> 10)) / (CLOCK_TICK_RATE>>10))
drivers/input/joystick/analog.c:#define DELTA(x,y)      (cpu_has_tsc ? =
((y) - (x)) : ((x) - (y) + ((x) < (y) ? CLOCK_TICK_RATE / HZ : 0
drivers/rtc/rtc-pxa.c:#define TIMER_FREQ                CLOCK_TICK_RATE
drivers/serial/serial_ks8695.c:         .uartclk        =3D CLOCK_TICK_=
RATE * 16,
drivers/watchdog/davinci_wdt.c: timer_margin =3D (((u64)heartbeat * CLO=
CK_TICK_RATE) & 0xffffffff);
drivers/watchdog/davinci_wdt.c: timer_margin =3D (((u64)heartbeat * CLO=
CK_TICK_RATE) >> 32);
drivers/watchdog/ks8695_wdt.c:  unsigned long tval =3D wdt_time * CLOCK=
_TICK_RATE;
include/linux/jiffies.h:#define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ) =
 /* For divider */
include/linux/jiffies.h:#define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, =
8))
include/linux/timex.h: *        Moved CLOCK_TICK_RATE, CLOCK_TICK_FACTO=
R and FINETUNE to asm/timex.h
sound/oss/pas2_pcm.c:           foo =3D ((CLOCK_TICK_RATE / 2) + (arg /=
 2)) / arg;
sound/oss/pas2_pcm.c:           arg =3D ((CLOCK_TICK_RATE / 2) + (foo /=
 2)) / foo;
sound/oss/pas2_pcm.c:           foo =3D (CLOCK_TICK_RATE + (arg / 2)) /=
 arg;
sound/oss/pas2_pcm.c:           arg =3D (CLOCK_TICK_RATE + (foo / 2)) /=
 foo;

All of these are either PC-specific, or they don't actually care
about the specific value. Most architectures just use the
value from the IBM PC, so we might as well make that the generic
default.

Alternatively, we could also move the definition back to linux/timex.h
and allow asm/timex.h to be empty.

	Arnd <><
