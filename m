From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Date: Wed, 30 May 2018 12:40:35 -0700
Message-ID: <20180530194032.982.41562@harbor.lan>
References: <20180511162028.20616-1-brgl@bgdev.pl>
 <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
 <CAMRc=McDNYQ5uk8EyRkDf8eh9q7tyF=t7PcUd6DBLqXcseJ3AQ@mail.gmail.com>
 <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJ=DdkDR3LtnTMHPUpwaUbjPEBgkaCV8ja+p-mTvWZuYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, David Lechner <david@lechnology.com>, Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Johan Hovold <johan@kernel.org>, Frank Rowand <frowand.list@gmail.com>, mo
List-Id: linux-arch.vger.kernel.org

Hi Rob,

Quoting Rob Herring (2018-05-14 06:20:57)
> On Mon, May 14, 2018 at 6:38 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrot=
e:
> > 2018-05-11 22:13 GMT+02:00 Rob Herring <robh+dt@kernel.org>:
> >> On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
> >>> This series is a follow-up to the RFC[1] posted a couple days ago.
> >>>
> >>> NOTE: this series applies on top of my recent patches[2] that move th=
e previous
> >>> implementation of early platform devices to arch/sh.
> >>>
> >>> Problem:
> >>>
> >>> Certain class of devices, such as timers, certain clock drivers and i=
rq chip
> >>> drivers need to be probed early in the boot sequence. The currently p=
referred
> >>> approach is using one of the OF_DECLARE() macros. This however does n=
ot create
> >>> a platform device which has many drawbacks - such as not being able t=
o use
> >>> devres routines, dev_ log functions or no way of deferring the init O=
F function
> >>> if some other resources are missing.
> >>
> >> I skimmed though this and it doesn't look horrible (how's that for
> >> positive feedback? ;) ). But before going into the details, I think
> >> first there needs to be agreement this is the right direction.
> >>
> >> The question does remain though as to whether this class of devices
> >> should be platform drivers. They can't be modules. They can't be
> >> hotplugged. Can they be runtime-pm enabled? So the advantage is ...
> >>
> >
> > The main (but not the only) advantage for drivers that can both be
> > platform drivers and OF_DECLARE drivers is that we get a single entry
> > point and can reuse code without resorting to checking if (!dev). It
> > results in more consistent code base. Another big advantage is
> > consolidation of device tree and machine code for SoC drivers used in
> > different boards of which some are still using board files and others
> > are defined in DT (see: DaVinci).
> >
> >> I assume that the clock maintainers had some reason to move clocks to
> >> be platform drivers. It's just not clear to me what that was.
> >>
> >>> For drivers that use both platform drivers and OF_DECLARE the situati=
on is even
> >>> more complicated as the code needs to take into account that there ca=
n possibly
> >>> be no struct device present. For a specific use case that we're havin=
g problems
> >>> with, please refer to the recent DaVinci common-clock conversion patc=
hes and
> >>> the nasty workaround that this problem implies[3].
> >>
> >> So devm_kzalloc will work with this solution? Why did we need
> >> devm_kzalloc in the first place? The clocks can never be removed and
> >> cleaning up on error paths is kind of pointless. The system would be
> >> hosed, right?
> >>
> >
> > It depends - not all clocks are necessary for system to boot.
> =

> That doesn't matter. You have a single driver for all/most of the
> clocks, so the driver can't be removed.

-ECANOFWORMS

A couple of quick rebuttals, but I imagine we're going to disagree on
the platform_driver thing as a matter of taste no matter what...

1) There should be multiple clk drivers in a properly modeled system.
Some folks still incorrectly put all clocks in a system into a single
driver because That's How We Used To Do It, and some systems (simpler
ones) really only have a single clock generator IP block.

Excepting those two reasons above, we really should have separate
drivers for clocks controlled by the PMIC, for the (one or more) clock
generator blocks inside of the AP/SoC, and then even more for the
drivers that map to IP blocks that have their own clock gens.

Good examples of the latter are display controllers that generate their
own PLL and pixel clock. Or MMC controllers that have a
runtime-programmable clock divider. Examples of these are merged into
mainline.

2) Stephen and I wanted clock drivers to actually be represented in the
driver model. There were these gigantic clock drivers that exclusively
used CLK_OF_DECLARE and they just sort of floated out there in the
ether... no representation in sysfs, no struct device to map onto a
clock controller struct, etc.

I'd be happy to hear why you think that platform_driver is a bad fit for
a device driver that generally manages memory-mapped system resources
that are part of the system glue and not really tied to a specific bus.
Sounds like a good fit to me.

If platform_driver doesn't handle the early boot thing well, that tells
me that we have a problem to solve in platform_driver, not in the clk
subsystem or drivers.

3) Lots of clock controllers should be loadable modules. E.g. i2c clock
expanders, potentially external PMIC-related drivers, external audio
codecs, etc.

Again, repeating my point #1 above, just because many platforms have a
monolithic clock driver does not mean that this is the Right Way to do
it.

Best regards,
Mike

> =

> >>> We also used to have an early platform drivers implementation but the=
y were not
> >>> integrated with the linux device model at all - they merely used the =
same data
> >>> structures. The users could not use devres, defer probe and the early=
 devices
> >>> never became actual platform devices later on.
> >>>
> >>> Proposed solution:
> >>>
> >>> This series aims at solving this problem by (re-)introducing the conc=
ept of
> >>> early platform drivers and devices - this time however in a way that =
seamlessly
> >>> integrates with the existing platform drivers and also offers device-=
tree
> >>> support.
> >>>
> >>> The idea is to provide a way for users to probe devices early, while =
already
> >>> being able to use devres, devices resources and properties and also d=
eferred
> >>> probing.
> >>>
> >>> New structures are introduced: the early platform driver contains the
> >>> early_probe callback which has the same signature as regular platform=
_device
> >>> probe. This callback is called early on. The user can have both the e=
arly and
> >>> regular probe speficied or only one of them and they both receive the=
 same
> >>> platform device object as argument. Any device data allocated early w=
ill be
> >>> carried over to the normal probe.
> >>>
> >>> The architecture code is responsible for calling early_platform_start=
() in
> >>> which the early drivers will be registered and devices populated from=
 DT.
> >>
> >> Can we really do this in one spot for different devices (clk, timers,
> >> irq). The sequence is all very carefully crafted. Platform specific
> >> hooks is another thing to consider.
> >>
> >
> > This is why I added support for early probe deferral - so that we can
> > stop caring for the order as long as the drivers are aware of other
> > resources they need and we call early_platform_start() the moment the
> > earliest of the early devices is needed.
> =

> Deferred probe helps for inter-device dependencies, but I am more
> concerned about timing of trying to register clocksources, irqchips,
> etc. What happens if we probe drivers before the infrastructure is
> initialized?
> =

> Rob
