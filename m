From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for
 remapping PCI I/O bus resources into CPU space
Date: Wed, 13 Aug 2014 11:33:11 +0100
Message-ID: <20140813103311.GQ25761@e106497-lin.cambridge.arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com>
 <20140813100118.GC18495@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140813100118.GC18495@arm.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 13, 2014 at 11:01:18AM +0100, Catalin Marinas wrote:
> On Tue, Aug 12, 2014 at 05:25:25PM +0100, Liviu Dudau wrote:
> > Introduce a default implementation for remapping PCI bus I/O resour=
ces
> > onto the CPU address space. Architectures with special needs may
> > provide their own version, but most should be able to use this one.
> >=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>=20
> I guess you could have added the generic pgprot_device definition to
> this patch and the arm64 specific one in the separate arm64 PCIe supp=
ort
> (and one less patch in total). But not a big issue either way.

I went by the established history on that file, where a new interface g=
ets
introduced together with its use. I guess it makes backing out the chan=
ge
much easier?

Best regards,
Liviu

>=20
> --=20
> Catalin

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
