From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
Date: Sat, 13 May 2017 18:18:23 +0200
Message-ID: <5321739.niXTlG4pZX@phil>
References: <1494646471-24624-1-git-send-email-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1494646471-24624-1-git-send-email-olof@lixom.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Olof Johansson <olof@lixom.net>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Russell King <linux@armlinux.org.uk>, Mikael Starvik <starvik@axis.com>, Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch <linux-arch@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Olof,

Am Freitag, 12. Mai 2017, 20:34:31 CEST schrieb Olof Johansson:
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

change itself looks good to me and also works, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Heiko Stuebner <heiko@sntech.de>

But we also have an overlooked glitch in the new rk3399-gru devicetrees
that surfaces with this patch applied.

../arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts:47:57: fatal error: include/dt-bindings/input/linux-event-codes.h: File or directory not found
 #include <include/dt-bindings/input/linux-event-codes.h>

so need the patch from Ian Campbell 
"arm64: dts: rockchip: Drop explicit "include/" prefix from #include" [0]
in front to not cause other build breakage.

So if applicable, both patches should go in together, with the gru patch
in front and I've added my Reviewed-by there if someone else is doing it.


Heiko

[0] https://www.spinics.net/lists/arm-kernel/msg580835.html
