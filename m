From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate directory
Date: Mon, 15 May 2017 08:01:07 -0500
Message-ID: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, May 12, 2017 at 10:34 PM, Olof Johansson <olof@lixom.net> wrote:
> We use a directory under arch/$ARCH/boot/dts as an include path
> that has links outside of the subtree to find dt-bindings from under
> include/dt-bindings. That's been working well, but new DT architectures
> haven't been adding them by default.
>
> Recently there's been a desire to share some of the DT material between
> arm and arm64, which originally caused developers to create symlinks or
> relative includes between the subtrees. This isn't ideal -- it breaks
> if the DT files aren't stored in the exact same hierarchy as the kernel
> tree, and generally it's just icky.
>
> As a somewhat cleaner solution we decided to add a $ARCH/ prefix link
> once, and allow DTS files to reference dtsi (and dts) files in other
> architectures that way.
>
> Original approach was to create these links under each architecture,
> but it lead to the problem of recursive symlinks.
>
> As a remedy, move the include link directories out of the architecture
> trees into a common location. At the same time, they can now share one
> directory and one dt-bindings/ link as well.
>
> Fixes: 4027494ae6e3 ('ARM: dts: add arm/arm64 include symlinks')
> Reported-by: Russell King <linux@armlinux.org.uk>
> Reported-by: Omar Sandoval <osandov@osandov.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: linux-arch <linux-arch@vger.kernel.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/boot/dts/include/arm             | 1 -
>  arch/arm/boot/dts/include/arm64           | 1 -
>  arch/arm/boot/dts/include/dt-bindings     | 1 -
>  arch/arm64/boot/dts/include/arm           | 1 -
>  arch/arm64/boot/dts/include/arm64         | 1 -
>  arch/arm64/boot/dts/include/dt-bindings   | 1 -
>  arch/cris/boot/dts/include/dt-bindings    | 1 -
>  arch/metag/boot/dts/include/dt-bindings   | 1 -
>  arch/mips/boot/dts/include/dt-bindings    | 1 -
>  arch/powerpc/boot/dts/include/dt-bindings | 1 -
>  scripts/Makefile.lib                      | 2 +-
>  scripts/dtc/include-prefixes/arc          | 1 +
>  scripts/dtc/include-prefixes/arm          | 1 +
>  scripts/dtc/include-prefixes/arm64        | 1 +
>  scripts/dtc/include-prefixes/c6x          | 1 +
>  scripts/dtc/include-prefixes/cris         | 1 +
>  scripts/dtc/include-prefixes/dt-bindings  | 1 +
>  scripts/dtc/include-prefixes/h8300        | 1 +
>  scripts/dtc/include-prefixes/metag        | 1 +
>  scripts/dtc/include-prefixes/microblaze   | 1 +
>  scripts/dtc/include-prefixes/mips         | 1 +
>  scripts/dtc/include-prefixes/nios2        | 1 +
>  scripts/dtc/include-prefixes/openrisc     | 1 +
>  scripts/dtc/include-prefixes/powerpc      | 1 +
>  scripts/dtc/include-prefixes/sh           | 1 +
>  scripts/dtc/include-prefixes/xtensa       | 1 +

I'd prefer not to mix things in scripts/dtc that aren't the import of
dtc (yes, we do have a few other things already, but they are at least
scripts). Couldn't this go in include/dt-bindings/ instead?

Rob
