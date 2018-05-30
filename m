From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Date: Wed, 30 May 2018 17:36:34 -0500
Message-ID: <CAL_Jsq+7=NGj57k=E5GAuDmW7Uu_YkHJXf8jSyc_ad3r1op4yA@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl> <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com> <20180530194032.982.41562@harbor.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180530194032.982.41562@harbor.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Frank
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 2:40 PM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Hi Rob,
>
> Quoting Rob Herring (2018-05-14 06:20:57)
>> On Mon, May 14, 2018 at 6:38 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> > 2018-05-11 22:13 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
>> >> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>> >>> This series is a follow-up to the RFC[1] posted a couple days ago.
>> >>>
>> >>> NOTE: this series applies on top of my recent patches[2] that move the previous
>> >>> implementation of early platform devices to arch/sh.
>> >>>
>> >>> Problem:
>> >>>
>> >>> Certain class of devices, such as timers, certain clock drivers and irq chip
>> >>> drivers need to be probed early in the boot sequence. The currently preferred
>> >>> approach is using one of the OF_DECLARE() macros. This however does not create
>> >>> a platform device which has many drawbacks - such as not being able to use
>> >>> devres routines, dev_ log functions or no way of deferring the init OF function
>> >>> if some other resources are missing.
>> >>
>> >> I skimmed though this and it doesn't look horrible (how's that for
>> >> positive feedback? ;) ). But before going into the details, I think
>> >> first there needs to be agreement this is the right direction.
>> >>
>> >> The question does remain though as to whether this class of devices
>> >> should be platform drivers. They can't be modules. They can't be
>> >> hotplugged. Can they be runtime-pm enabled? So the advantage is ...
>> >>
>> >
>> > The main (but not the only) advantage for drivers that can both be
>> > platform drivers and OF_DECLARE drivers is that we get a single entry
>> > point and can reuse code without resorting to checking if (!dev). It
>> > results in more consistent code base. Another big advantage is
>> > consolidation of device tree and machine code for SoC drivers used in
>> > different boards of which some are still using board files and others
>> > are defined in DT (see: DaVinci).
>> >
>> >> I assume that the clock maintainers had some reason to move clocks to
>> >> be platform drivers. It's just not clear to me what that was.
>> >>
>> >>> For drivers that use both platform drivers and OF_DECLARE the situation is even
>> >>> more complicated as the code needs to take into account that there can possibly
>> >>> be no struct device present. For a specific use case that we're having problems
>> >>> with, please refer to the recent DaVinci common-clock conversion patches and
>> >>> the nasty workaround that this problem implies[3].
>> >>
>> >> So devm_kzalloc will work with this solution? Why did we need
>> >> devm_kzalloc in the first place? The clocks can never be removed and
>> >> cleaning up on error paths is kind of pointless. The system would be
>> >> hosed, right?
>> >>
>> >
>> > It depends - not all clocks are necessary for system to boot.
>>
>> That doesn't matter. You have a single driver for all/most of the
>> clocks, so the driver can't be removed.
>
> -ECANOFWORMS
>
> A couple of quick rebuttals, but I imagine we're going to disagree on
> the platform_driver thing as a matter of taste no matter what...

It's really more should the clocksource, clockevents and primary
interrupt controller be drivers. Let's get agreement on that first. If
yes, then it probably does make sense that their dependencies are
drivers too. If not, then making only the dependencies drivers doesn't
seem right to me.

> 1) There should be multiple clk drivers in a properly modeled system.
> Some folks still incorrectly put all clocks in a system into a single
> driver because That's How We Used To Do It, and some systems (simpler
> ones) really only have a single clock generator IP block.
>
> Excepting those two reasons above, we really should have separate
> drivers for clocks controlled by the PMIC, for the (one or more) clock
> generator blocks inside of the AP/SoC, and then even more for the
> drivers that map to IP blocks that have their own clock gens.

I agree those should be separate entities at least. But for a given
h/w block, if you already have to use OF_DECLARE, why would you try to
split that into OF_DECLARE and a driver? what advantage does putting
non-boot essential clocks in a driver or transitioning to a driver get
you?

And I've seen PMIC clocks could be inputs to the SoC's clock
controller(s), so the dependencies get more complicated. Then does the
PMIC driver and its dependencies need to be early drivers too?

> Good examples of the latter are display controllers that generate their
> own PLL and pixel clock. Or MMC controllers that have a
> runtime-programmable clock divider. Examples of these are merged into
> mainline.

But those are drivers of types other than a clock controller that
happen to register some clocks as well. I wasn't saying these cases
can't or shouldn't be part of the driver model. Look at irqchips. We
have some that use the driver model (e.g. every GPIO driver) and some
that don't because there's no need (e.g. GIC).

> 2) Stephen and I wanted clock drivers to actually be represented in the
> driver model. There were these gigantic clock drivers that exclusively
> used CLK_OF_DECLARE and they just sort of floated out there in the
> ether... no representation in sysfs, no struct device to map onto a
> clock controller struct, etc.
>
> I'd be happy to hear why you think that platform_driver is a bad fit for
> a device driver that generally manages memory-mapped system resources
> that are part of the system glue and not really tied to a specific bus.
> Sounds like a good fit to me.
>
> If platform_driver doesn't handle the early boot thing well, that tells
> me that we have a problem to solve in platform_driver, not in the clk
> subsystem or drivers.

Doing things earlier is not the only way to solve the problems.
Perhaps we need to figure out how to start things later. Maybe it's
not feasible here, I don't know.

> 3) Lots of clock controllers should be loadable modules. E.g. i2c clock
> expanders, potentially external PMIC-related drivers, external audio
> codecs, etc.
>
> Again, repeating my point #1 above, just because many platforms have a
> monolithic clock driver does not mean that this is the Right Way to do
> it.

And in those cases, I completely agree they should be part of a driver.

Rob
