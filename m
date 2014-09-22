From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Mon, 22 Sep 2014 16:20:48 +0100
Message-ID: <20140922152048.GZ1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <201409200424.20538.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <201409200424.20538.arnd@arndb.de>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 20, 2014 at 03:24:20AM +0100, Arnd Bergmann wrote:
> On Thursday 18 September 2014, Liviu Dudau wrote:
> >=20
> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> > of a given device from DT. If the information is not present,
> > the function can be requested to allocate a new domain number.
> >=20
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Grant Likely <grant.likely@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>=20
> This is more elaborate than I remember it, and while the simpler
> version (which potentially resulted in a conflict for inconsistent
> DTs) was fine, this one also seems ok.
>=20
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd!

Best regards,
Liviu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
