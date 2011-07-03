From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 02/19] OpenRISC: Device tree
Date: Sun, 3 Jul 2011 14:51:10 -0600
Message-ID: <CACxGe6tFX=EQjaL-4EjSXquY5eh+bca29=d=cE5-YAVCUVRCvA@mail.gmail.com>
References: <1309641352-18714-1-git-send-email-jonas@southpole.se> <1309641352-18714-3-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44153 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1GCUvd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 3 Jul 2011 16:51:33 -0400
In-Reply-To: <1309641352-18714-3-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Sat, Jul 2, 2011 at 3:15 PM, Jonas Bonn <jonas@southpole.se> wrote:
>
> The OpenRISC architecture uses the device tree infrastructure for the
> platform description. =A0This is currently limited to having a device=
 tree
> built into the kernel, but work is underway within the OpenRISC proje=
ct
> to define how this device tree blob should be passed into the kernel =
from
> an external resource.
>
> Signed-off-by: Jonas Bonn <jonas@southpole.se>
> Cc: devicetree-discuss@lists.ozlabs.org
> ---
> =A0arch/openrisc/boot/dts/atlys.dts =A0 | =A0 78 ++++++++++++++++++++=
+++++
> =A0arch/openrisc/boot/dts/or1ksim.dts | =A0 73 ++++++++++++++++++++++=
++
> =A0arch/openrisc/include/asm/prom.h =A0 | =A0 92 ++++++++++++++++++++=
++++++++++
> =A0arch/openrisc/kernel/prom.c =A0 =A0 =A0 =A0| =A0109 ++++++++++++++=
++++++++++++++++++++++
> =A0arch/openrisc/kernel/setup.c =A0 =A0 =A0 | =A0 =A03 +-
> =A05 files changed, 353 insertions(+), 2 deletions(-)
> =A0create mode 100644 arch/openrisc/boot/dts/atlys.dts
> =A0create mode 100644 arch/openrisc/boot/dts/or1ksim.dts
> =A0create mode 100644 arch/openrisc/include/asm/prom.h
> =A0create mode 100644 arch/openrisc/kernel/prom.c
>
> diff --git a/arch/openrisc/boot/dts/atlys.dts b/arch/openrisc/boot/dt=
s/atlys.dts
> new file mode 100644
> index 0000000..cd028b9
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/atlys.dts
> @@ -0,0 +1,78 @@
> +/dts-v1/;
> +/ {
> + =A0 =A0 =A0 compatible =3D "digilent,atlys";
> + =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 #address-cells =3D <1>;
> +
> + =A0 =A0 =A0 chosen {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootargs =3D "console=3Dtty0 console=3D=
uart,mmio,0x90000000,115200 debug video=3Docfb:640x480-16@60";
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory {

memory@0

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x8000000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,openrisc-1200";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <50=
000000>;

As Segher metioned, the cpus node should have #address/size-cells and
the cpu@0 node should have "reg =3D <0>;".

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* The "soc" node */
> +
> + =A0 =A0 =A0 soc {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Every node with children must specif=
y address-cells and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size-cells; they are not inherit=
ed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";

Drop device type.  device_type only makes sense for systems with real
OpenFirmware.  Always use a 'compatible' property to identify a
device.  In this case you probably want the compatible list to include
the name of the bus bridge plus "simple-bus".

Does it really make sense to have an SoC node for this board?  I
assume this is for a soft CPU system on a Diligent FPGA board.  It is
best if the device tree structure matches the actual bus layout of the
chip and/or FPGA design.  If the devices are directly on the CPU bus,
then it is better to do without an soc node entirely and just put
everything at the root.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This is also a 1:1 mapping but limit=
s size of mappable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0region to 0x40000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x80000000 0x80000000 0x400=
00000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* An alternative is to specify an empt=
y ranges here to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indicates 1:1 mapping of SOC add=
resses (device addresses)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to CPU addresses */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*ranges;*/

ranges is a well documented property.  You can drop the commented out
empty ranges, and the comments attached to it.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This SOC has only a single, implicit=
 PIC, so define it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0early and put the interrupt-pare=
nt property in the 'soc'
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node so that it's inherited by a=
ll the children using
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>;

Put this at the root of the tree so that every node inherits it
(unless explicitly overridden).  You may very well end up with devices
at the root of the tree which are not children of the SoC node.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Devices with interrupts need a 'pare=
nt', so we need to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0define a controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pic: pic@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,or1k-pic";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial0: serial@90000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: device_type i=
s still needed here...
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should remove re=
quirement from of_serial driver */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "serial=
";

device_type should not be necessary at all any more in the current
kernel.  You can remove this now.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,uart", "ns16550a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x90000000 0x1=
00>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <50=
000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enet0: ethoc@92000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,ethoc", "ethoc";

"ethoc" is too generic.  Drop it.  Also, since this represents a soft
IP core, "opencores,ethoc" should probably include some indication of
which version of the core is instantiated (same goes for the other
"opencores,..." values in this file.

=46inally, every new "compatible" value that is used in this device tre=
e
needs to be documented.  Look in Documentation/devicetree/bindings.
The documentation is used to guard against "binding drift" where the
meaning of a compatible property is interpreted differently by
different people.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x92000000 0x5=
3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [=
02 de ad be ef 02];

Don't do this.  If you don't have a valid Ethernet address, it is
probably better to leave the property out entirely, and let the kernel
randomly generate one.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fb0: ocfb@97000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,ocfb", "ocfb";

"ocfb" too generic.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x97000000 0x1=
000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +};
> diff --git a/arch/openrisc/boot/dts/or1ksim.dts b/arch/openrisc/boot/=
dts/or1ksim.dts
> new file mode 100644
> index 0000000..6a025ea
> --- /dev/null
> +++ b/arch/openrisc/boot/dts/or1ksim.dts
> @@ -0,0 +1,73 @@
> +/dts-v1/;
> +/ {
> + =A0 =A0 =A0 compatible =3D "opencores,or1ksim";
> + =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 #address-cells =3D <1>;
> +
> + =A0 =A0 =A0 chosen {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bootargs =3D "console=3Duart,mmio,0x900=
00000,115200 debug";
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 memory {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "memory";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x00000000 0x2000000>;
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 cpus {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,openrisc-1200";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <20=
000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 /* The "soc" node */
> +
> + =A0 =A0 =A0 soc {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Every node with children must specif=
y address-cells and
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size-cells; they are not inherit=
ed */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #address-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 #size-cells =3D <1>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "soc";

Drop device_type, blah blah blah...  Most of my comments on the
previous file apply here too.

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This is also a 1:1 mapping but limit=
s size of mappable
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0region to 0x40000000 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ranges =3D <0x80000000 0x80000000 0x400=
00000>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* An alternative is to specify an empt=
y ranges here to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0indicates 1:1 mapping of SOC add=
resses (device addresses)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0to CPU addresses */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*ranges;*/
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* This SOC has only a single, implicit=
 PIC, so define it
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0early and put the interrupt-pare=
nt property in the 'soc'
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0node so that it's inherited by a=
ll the children using
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D <&pic>;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Devices with interrupts need a 'pare=
nt', so we need to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0define a controller */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pic: pic@0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,or1k-pic";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 #interrupt-cells =3D <1=
>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-controller;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 serial0: serial@90000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: device_type i=
s still needed here...
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0should remove re=
quirement from of_serial driver */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_type =3D "serial=
";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,uart", "ns16550a";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x90000000 0x1=
00>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <2>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock-frequency =3D <20=
000000>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 enet0: ethoc@92000000 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatible =3D "opencor=
es,ethoc", "ethoc";
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <0x92000000 0x5=
3>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupts =3D <4>;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 local-mac-address =3D [=
02 de ad be ef 02];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 };
> +};
> diff --git a/arch/openrisc/include/asm/prom.h b/arch/openrisc/include=
/asm/prom.h
> new file mode 100644
> index 0000000..3818902
> --- /dev/null
> +++ b/arch/openrisc/include/asm/prom.h
> @@ -0,0 +1,92 @@
> +/*
> + * OpenRISC Linux
> + *
> + * Linux architectural port borrowing liberally from similar works o=
f
> + * others. =A0All original copyrights apply as per the original sour=
ce
> + * declaration.
> + *
> + * OpenRISC implementation:
> + * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
> + * et al.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License as published=
 by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/of.h> =A0/* linux/of.h gets to determine #include or=
dering */
> +
> +#ifndef _ASM_OPENRISC_PROM_H
> +#define _ASM_OPENRISC_PROM_H
> +#ifdef __KERNEL__
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +#include <asm/irq.h>
> +#include <asm/atomic.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_address.h>
> +#include <linux/proc_fs.h>
> +#include <linux/platform_device.h>
> +#define HAVE_ARCH_DEVTREE_FIXUPS
> +
> +/* Other Prototypes */
> +extern int early_uartlite_console(void);
> +
> +#ifdef CONFIG_PCI
> +/*
> + * PCI <-> OF matching functions
> + * (XXX should these be here?)
> + */
> +struct pci_bus;
> +struct pci_dev;
> +extern int pci_device_from_OF_node(struct device_node *node,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 u8 *bus, u8 *devfn);
> +extern struct device_node *pci_busdev_to_OF_node(struct pci_bus *bus=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int devfn);
> +extern struct device_node *pci_device_to_OF_node(struct pci_dev *dev=
);
> +extern void pci_create_OF_bus_map(void);
> +#endif
> +
> +/* Parse the ibm,dma-window property of an OF node into the busno, p=
hys and
> + * size parameters.
> + */
> +void of_parse_dma_window(struct device_node *dn, const void *dma_win=
dow_prop,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *busno, unsigned long *ph=
ys, unsigned long *size);
> +
> +extern void kdump_move_device_tree(void);
> +
> +/* CPU OF node matching */
> +struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
> +
> +/* Get the MAC address */
> +extern const void *of_get_mac_address(struct device_node *np);
> +
> +/**
> + * of_irq_map_pci - Resolve the interrupt for a PCI device
> + * @pdev: =A0 =A0 =A0the device whose interrupt is to be resolved
> + * @out_irq: =A0 structure of_irq filled by this function
> + *
> + * This function resolves the PCI interrupt for a given PCI device. =
If a
> + * device-node exists for a given pci_dev, it will use normal OF tre=
e
> + * walking. If not, it will implement standard swizzling and walk up=
 the
> + * PCI tree until an device-node is found, at which point it will fi=
nish
> + * resolving using the OF tree walking.
> + */
> +struct pci_dev;
> +extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_i=
rq);
> +
> +/* This routine is here to provide compatibility with how powerpc
> + * handles IRQ mapping for OF device nodes. =A0We precompute and per=
manently
> + * register them in the platform_device objects, whereas powerpc com=
putes them
> + * on request.
> + */
> +static inline void irq_dispose_mapping(unsigned int virq)
> +{
> +}

The need for this should hopefully go away in Linux v3.1 when I get
the irq_domain stuff merged.

> +
> +#endif /* __ASSEMBLY__ */
> +#endif /* __KERNEL__ */
> +#endif /* _ASM_OPENRISC_PROM_H */
> diff --git a/arch/openrisc/kernel/prom.c b/arch/openrisc/kernel/prom.=
c
> new file mode 100644
> index 0000000..2bb5a8c
> --- /dev/null
> +++ b/arch/openrisc/kernel/prom.c
> @@ -0,0 +1,109 @@
> +/*
> + * OpenRISC prom.c
> + *
> + * Linux architectural port borrowing liberally from similar works o=
f
> + * others. =A0All original copyrights apply as per the original sour=
ce
> + * declaration.
> + *
> + * Modifications for the OpenRISC architecture:
> + * Copyright (C) 2010-2011 Jonas Bonn <jonas@southpole.se>
> + *
> + * =A0 =A0 =A0This program is free software; you can redistribute it=
 and/or
> + * =A0 =A0 =A0modify it under the terms of the GNU General Public Li=
cense
> + * =A0 =A0 =A0as published by the Free Software Foundation; either v=
ersion
> + * =A0 =A0 =A02 of the License, or (at your option) any later versio=
n.
> + *
> + * Architecture specific procedures for creating, accessing and
> + * interpreting the device tree.
> + *
> + */
> +
> +#include <stdarg.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/init.h>
> +#include <linux/threads.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/pci.h>
> +#include <linux/stringify.h>
> +#include <linux/delay.h>
> +#include <linux/initrd.h>
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/kexec.h>
> +#include <linux/debugfs.h>
> +#include <linux/irq.h>
> +#include <linux/memblock.h>
> +#include <linux/of_fdt.h>
> +
> +#include <asm/prom.h>
> +#include <asm/page.h>
> +#include <asm/processor.h>
> +#include <asm/irq.h>
> +#include <linux/io.h>
> +#include <asm/system.h>
> +#include <asm/mmu.h>
> +#include <asm/pgtable.h>
> +#include <asm/sections.h>
> +#include <asm/setup.h>
> +
> +extern char cmd_line[COMMAND_LINE_SIZE];
> +
> +void __init early_init_dt_add_memory_arch(u64 base, u64 size)
> +{
> + =A0 =A0 =A0 size &=3D PAGE_MASK;
> + =A0 =A0 =A0 memblock_add(base, size);
> +}
> +
> +void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
> +{
> + =A0 =A0 =A0 return __va(memblock_alloc(size, align));
> +}
> +
> +void __init early_init_devtree(void *params)
> +{
> + =A0 =A0 =A0 u8 *alloc;
> +
> + =A0 =A0 =A0 /* Setup flat device-tree pointer */
> + =A0 =A0 =A0 initial_boot_params =3D params;
> +
> +
> + =A0 =A0 =A0 /* Retrieve various informations from the /chosen node =
of the
> + =A0 =A0 =A0 =A0* device-tree, including the platform type, initrd l=
ocation and
> + =A0 =A0 =A0 =A0* size, TCE reserve, and more ...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 of_scan_flat_dt(early_init_dt_scan_chosen, cmd_line);
> +
> + =A0 =A0 =A0 /* Scan memory nodes and rebuild MEMBLOCKs */
> + =A0 =A0 =A0 memblock_init();
> + =A0 =A0 =A0 of_scan_flat_dt(early_init_dt_scan_root, NULL);
> + =A0 =A0 =A0 of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> +
> + =A0 =A0 =A0 /* Save command line for /proc/cmdline and then parse p=
arameters */
> + =A0 =A0 =A0 strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE)=
;
> +// =A0 =A0 parse_early_param();

This should just be removed?

> +
> + =A0 =A0 =A0 memblock_analyze();
> +
> + =A0 =A0 =A0 /* We must copy the flattend device tree from init memo=
ry to regular
> + =A0 =A0 =A0 =A0* memory because the device tree references the stri=
ngs in it
> + =A0 =A0 =A0 =A0* directly.
> + =A0 =A0 =A0 =A0*/
> +
> + =A0 =A0 =A0 alloc =3D __va(memblock_alloc(initial_boot_params->tota=
lsize, PAGE_SIZE));
> +
> + =A0 =A0 =A0 memcpy(alloc, initial_boot_params, initial_boot_params-=
>totalsize);
> +
> + =A0 =A0 =A0 initial_boot_params =3D (void *) alloc;

If alloc gets declared as a 'void*', then this cast can be removed.

> +}
> +
> +#ifdef CONFIG_BLK_DEV_INITRD
> +void __init early_init_dt_setup_initrd_arch(unsigned long start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long end)
> +{
> + =A0 =A0 =A0 initrd_start =3D (unsigned long)__va(start);
> + =A0 =A0 =A0 initrd_end =3D (unsigned long)__va(end);
> + =A0 =A0 =A0 initrd_below_start_ok =3D 1;
> +}
> +#endif
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setu=
p.c
> index 49342e9..6ce6583 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -173,8 +173,7 @@ void __init setup_cpuinfo(void)
> =A0 =A0 =A0 =A0unsigned long iccfgr,dccfgr;
> =A0 =A0 =A0 =A0unsigned long cache_set_size, cache_ways;;
>
> - =A0 =A0 =A0 cpu =3D (struct device_node *) of_find_compatible_node(=
NULL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 NULL, "opencores,openrisc-1200");
> + =A0 =A0 =A0 cpu =3D of_find_compatible_node(NULL, NULL, "opencores,=
openrisc-1200");

This looks odd.  Is it a stale hunk from a previous patch version?

> =A0 =A0 =A0 =A0if (!cpu) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0panic("No compatible CPU found in devi=
ce tree...\n");
> =A0 =A0 =A0 =A0}
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
