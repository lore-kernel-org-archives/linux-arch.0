From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
Date: Mon, 15 May 2017 16:48:45 +0100
Message-ID: <20170515154845.GW22219@n2100.armlinux.org.uk>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
 <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Heiko Stuebner <heiko@sntech.de>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frank Rowand <frowand.list@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 15, 2017 at 08:27:54AM -0700, Olof Johansson wrote:
> On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt@kernel.org> wrote:
> > On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> >> Maybe what we should do is:
> >>
> >> mkdir include/dt
> >> git mv include/dt-bindings include/dt
> >> for arch in arch/*; do
> >>   dts=$arch/boot/dts
> >>   if [ -d $dts ]; then
> >>      a=include/dt/$(basename $arch)
> >>      ln -s $dts $a
> >>      git add $a
> >>   fi
> >> done
> >> ... fixup scripts/Makefile.lib ...
> >> git commit
> >
> > That would just break every existing include in dts files.
> 
> It doesn't break dts includes if done together with a change in -I,
> but it might break includes from the driver side (or needs another -I
> there).

Good point.

We could leave include/dt-bindings where it is, and just do the rest of
it for the cross-arch includes.  Slightly less tidy but should have a
lower impact.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
