From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v10 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Tue, 9 Sep 2014 09:46:21 +0100
Message-ID: <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
 <1410184472-17630-8-git-send-email-Liviu.Dudau@arm.com>
 <CAL_JsqJi8k1Goc3UmXhuxf9v7=4gJrYG_Di7v574PxS8TsJaXw@mail.gmail.com>
 <20140908145459.GO27864@e106497-lin.cambridge.arm.com>
 <CAL_JsqJdGKDVwJOpPp19OkVPGzR7Zqv3nh+ONHHaYnPLYTYoYg@mail.gmail.com>
 <20140908155931.GP27864@e106497-lin.cambridge.arm.com>
 <540E960D.7080408@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:38403 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756071AbaIIIq2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Sep 2014 04:46:28 -0400
In-Reply-To: <540E960D.7080408@huawei.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Rob Herring <robherring2@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>"grant.likely@linaro.org" <gran>

On Tue, Sep 09, 2014 at 06:54:21AM +0100, Yijing Wang wrote:
> >>> on new requests. This function gets called quite a lot and I'm tr=
ying not to
> >>> make it too heavy weight.
> >>
> >> Generally, nothing should be accessing the same DT value frequentl=
y.
> >> It should get cached somewhere.
> >>
> >=20
> > The problem appears for DTs that don't have the pci-domain info. Th=
en the cached
> > value is left at the default non-valid value and attempts to rescan=
 the DT will
> > be made every time the function is called.
> >=20
> >> I don't really understand how domains are used so it's hard to pro=
vide
> >> a recommendation here. Do domains even belong in the DT?
> >=20
> > ACPI calls them segments and the way Bjorn explained it to me at so=
me moment was
> > that it was an attempt to split up a bus in different groups (or al=
ternatively,
> > merge a few busses together). To be honest I haven't seen systems w=
here the domain
> > is anything other than zero, but JasonG (or maybe Benjamin) were fl=
oating an
> > idea of using the domain number to identify physical slots.
>=20
> PCI domain(or named segment) is provided by firmware, in ACPI system,=
 we evaluated it
> by method "_SEG". in IA64 with ACPI, PCI hostbridge driver retrieves =
the domain from ACPI,
> if it's absent, the default domain is zero. So I wonder why in DTS, i=
f it's absent, we get
> a auto increment domain value.

Because you can have more than one hostbridge (rare, but not impossible=
) and unless you
want to join the two segments, you might want to give it a different do=
main.

Best regards,
Liviu

>=20
> PCI get domain by ACPI "_SEG" in IA64(drivers/acpi/pci_root.c)
> ......
> 	status =3D acpi_evaluate_integer(handle, METHOD_NAME__SEG, NULL,
> 				       &segment);
> 	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
> 		dev_err(&device->dev,  "can't evaluate _SEG\n");
> 		result =3D -ENODEV;
> 		goto end;
> 	}
> .......
>=20
> Thanks!
> Yijing.
>=20
> >=20
> >> This function
> >> is just a weird mixture of data retrieval and allocation. I think =
you
> >> need to separate it into 2 functions.
> >=20
> > It is meant to do allocation with the retrieval being a short-cut (=
or fine
> > control if you want).
> >=20
> > I need to think a bit more for a better solution.
> >=20
> > Best regards,
> > Liviu
> >=20
> >>
> >> Rob
> >>
> >=20
>=20
>=20
> --=20
> Thanks!
> Yijing
>=20
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
