From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
Date: Mon, 15 May 2017 15:26:42 +0100
Message-ID: <20170515142641.GU22219@n2100.armlinux.org.uk>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59774 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965193AbdEOO1A (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 10:27:00 -0400
Content-Disposition: inline
In-Reply-To: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>

On Mon, May 15, 2017 at 08:01:07AM -0500, Rob Herring wrote:
> I'd prefer not to mix things in scripts/dtc that aren't the import of
> dtc (yes, we do have a few other things already, but they are at least
> scripts). Couldn't this go in include/dt-bindings/ instead?

I don't think that works.

The include path used is "include", which means that we force people
to use:

#include <dt-bindings/foo.dtsi>

in their DT files.  This means that we'd need to populate $topdir/include
with per-architecture symlinks on top of the 26 or so directories already
there, so that:

#include <arch/foo.dtsi>

would work.  That's quite horrible, since $topdir/include is the main
include path for C headers.

I guess we could have symlinks inside include/dt-bindings, but that
makes the includes:

#include <dt-bindings/arch/foo.dtsi>

but that's rather absurd because these _aren't_ dt-binding definitions.

Maybe what we should do is:

mkdir include/dt
git mv include/dt-bindings include/dt
for arch in arch/*; do
  dts=$arch/boot/dts
  if [ -d $dts ]; then
     a=include/dt/$(basename $arch)
     ln -s $dts $a
     git add $a
  fi
done
... fixup scripts/Makefile.lib ...
git commit

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
