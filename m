From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 00/12] introduce support for early platform drivers
Date: Fri, 11 May 2018 15:13:35 -0500
Message-ID: <CAL_JsqL3CWFSpKEGoGwQDxCQ04g4uT1hiDTxXzjz4XTjPbfsoQ@mail.gmail.com>
References: <20180511162028.20616-1-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180511162028.20616-1-brgl@bgdev.pl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Rich Felker <dalias@libc.org>, Michael Turquette <mturquette@baylibre.com>, Sekhar Nori <nsekhar@ti.com>, Frank Rowand <frowand.list@gmail.com>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Kevin Hilman <khilman@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, David Lechner <david@lechnology.com>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Daniel Lezcano <daniel.lezcano@linar>
List-Id: linux-arch.vger.kernel.org

On Fri, May 11, 2018 at 11:20 AM, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> This series is a follow-up to the RFC[1] posted a couple days ago.
>
> NOTE: this series applies on top of my recent patches[2] that move the previous
> implementation of early platform devices to arch/sh.
>
> Problem:
>
> Certain class of devices, such as timers, certain clock drivers and irq chip
> drivers need to be probed early in the boot sequence. The currently preferred
> approach is using one of the OF_DECLARE() macros. This however does not create
> a platform device which has many drawbacks - such as not being able to use
> devres routines, dev_ log functions or no way of deferring the init OF function
> if some other resources are missing.

I skimmed though this and it doesn't look horrible (how's that for
positive feedback? ;) ). But before going into the details, I think
first there needs to be agreement this is the right direction.

The question does remain though as to whether this class of devices
should be platform drivers. They can't be modules. They can't be
hotplugged. Can they be runtime-pm enabled? So the advantage is ...

I assume that the clock maintainers had some reason to move clocks to
be platform drivers. It's just not clear to me what that was.

> For drivers that use both platform drivers and OF_DECLARE the situation is even
> more complicated as the code needs to take into account that there can possibly
> be no struct device present. For a specific use case that we're having problems
> with, please refer to the recent DaVinci common-clock conversion patches and
> the nasty workaround that this problem implies[3].

So devm_kzalloc will work with this solution? Why did we need
devm_kzalloc in the first place? The clocks can never be removed and
cleaning up on error paths is kind of pointless. The system would be
hosed, right?

> We also used to have an early platform drivers implementation but they were not
> integrated with the linux device model at all - they merely used the same data
> structures. The users could not use devres, defer probe and the early devices
> never became actual platform devices later on.
>
> Proposed solution:
>
> This series aims at solving this problem by (re-)introducing the concept of
> early platform drivers and devices - this time however in a way that seamlessly
> integrates with the existing platform drivers and also offers device-tree
> support.
>
> The idea is to provide a way for users to probe devices early, while already
> being able to use devres, devices resources and properties and also deferred
> probing.
>
> New structures are introduced: the early platform driver contains the
> early_probe callback which has the same signature as regular platform_device
> probe. This callback is called early on. The user can have both the early and
> regular probe speficied or only one of them and they both receive the same
> platform device object as argument. Any device data allocated early will be
> carried over to the normal probe.
>
> The architecture code is responsible for calling early_platform_start() in
> which the early drivers will be registered and devices populated from DT.

Can we really do this in one spot for different devices (clk, timers,
irq). The sequence is all very carefully crafted. Platform specific
hooks is another thing to consider.

> Once the device and kobject mechanisms are ready, all early drivers and devices
> will be converted into real platform drivers and devices. Also: if any of the
> early platform registration functions will be called once early initialization
> is done, these functions will work like regular platform_device/driver ones.

This could leave devices in a weird state. They've successfully probed
early, but then are on the deferred list for normal probe for example.

Rob
