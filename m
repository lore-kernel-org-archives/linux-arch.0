Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60584 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbdEOP13 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 11:27:29 -0400
Date: Mon, 15 May 2017 16:27:14 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
Message-ID: <20170515152713.GV22219@n2100.armlinux.org.uk>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
 <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20170515152714.3ni1Udzn85U7EnJQqdJW9zChsCl3snZKmDKmlV-hDF4@z>

On Mon, May 15, 2017 at 09:47:40AM -0500, Rob Herring wrote:
> On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Maybe what we should do is:
> >
> > mkdir include/dt
> > git mv include/dt-bindings include/dt
> > for arch in arch/*; do
> >   dts=$arch/boot/dts
> >   if [ -d $dts ]; then
> >      a=include/dt/$(basename $arch)
> >      ln -s $dts $a
> >      git add $a
> >   fi
> > done
> > ... fixup scripts/Makefile.lib ...
> > git commit
> 
> That would just break every existing include in dts files.

Are you sure about that - the existing:

#include <dt-bindings/foo.dtsi>

would still work.  Maybe you haven't parsed the shell code properly...

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
