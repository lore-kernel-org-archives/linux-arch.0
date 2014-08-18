From: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the
 PCI device.
Date: Mon, 18 Aug 2014 22:26:59 +0100
Message-ID: <20140818212659.GA13147@bart.dudau.co.uk>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-3-git-send-email-Liviu.Dudau@arm.com>
 <20140814145804.GA5586@richard>
 <20140814154959.GG25761@e106497-lin.cambridge.arm.com>
 <20140815085632.GA4954@richard>
 <20140815103052.GD27553@e106497-lin.cambridge.arm.com>
 <20140818014404.GA11354@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from dliviu.plus.com ([80.229.23.120]:51236 "EHLO smtp.dudau.co.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752151AbaHRV12 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Aug 2014 17:27:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.dudau.co.uk (Postfix) with SMTP id 26191FFD97
	for <linux-arch@vger.kernel.org>; Mon, 18 Aug 2014 22:27:27 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140818014404.GA11354@richard>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 18, 2014 at 09:44:04AM +0800, Wei Yang wrote:
> On Fri, Aug 15, 2014 at 11:30:52AM +0100, Liviu Dudau wrote:
> >On Fri, Aug 15, 2014 at 09:56:32AM +0100, Wei Yang wrote:
> >> On Thu, Aug 14, 2014 at 04:49:59PM +0100, Liviu Dudau wrote:
> >> >On Thu, Aug 14, 2014 at 03:58:04PM +0100, Wei Yang wrote:
> >> >> On Tue, Aug 12, 2014 at 05:25:15PM +0100, Liviu Dudau wrote:
> >> >> >Enhance the default implementation of pcibios_add_device() to
> >> >> >parse and map the IRQ of the device if a DT binding is availab=
le.
> >> >> >
> >> >> >Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> >> >Cc: Grant Likely <grant.likely@linaro.org>
> >> >> >Cc: Rob Herring <robh+dt@kernel.org>
> >> >> >Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >> >> >---
> >> >> > drivers/pci/pci.c | 3 +++
> >> >> > 1 file changed, 3 insertions(+)
> >> >> >
> >> >> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> >> >index 1c8592b..29d1775 100644
> >> >> >--- a/drivers/pci/pci.c
> >> >> >+++ b/drivers/pci/pci.c
> >> >> >@@ -17,6 +17,7 @@
> >> >> > #include <linux/spinlock.h>
> >> >> > #include <linux/string.h>
> >> >> > #include <linux/log2.h>
> >> >> >+#include <linux/of_pci.h>
> >> >> > #include <linux/pci-aspm.h>
> >> >> > #include <linux/pm_wakeup.h>
> >> >> > #include <linux/interrupt.h>
> >> >> >@@ -1453,6 +1454,8 @@ EXPORT_SYMBOL(pcim_pin_device);
> >> >> >  */
> >> >> > int __weak pcibios_add_device(struct pci_dev *dev)
> >> >> > {
> >> >> >+	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
> >> >> >+
> >> >> > 	return 0;
> >> >> > }
> >> >>=20
> >> >> Liviu,
> >> >>=20
> >> >> For this, my suggestion is to add arch dependent function to se=
tup the irq
> >> >> line for pci devices. I can't find an obvious reason this won't=
 work on other
> >> >> archs, but maybe this will hurt some of them?
> >> >
> >> >Hi Wei,
> >> >
> >> >I'm not sure I understand your point. Architectures that support =
OF will obviously
> >> >benefit from this common approach, and for the other ones the fun=
ction is empty
> >> >so it will not change existing behaviour. If you are suggesting t=
hat I should
> >> >create a new API that each architecture could go and implement fo=
r setting up the
> >> >IRQ line then I would agree that it would be nice to have that, b=
ut the question
> >> >is how many architectures are outside OF that need this?
> >>=20
> >> My suggestion is to define the pcibios_add_device() for arm arch, =
like the one
> >> in arch/powerpc/kernel/pci-common.c. If my understanding is correc=
t, this
> >> patch set address the pci bus setup mostly on arm arch.
> >
> >And also arm64 at the least.
> >
> >>=20
> >> For those archs not support OF, this function is empty and has no =
effect. I
> >> agree on this one.
> >>=20
> >> For those archs rely on OF, we still have two cases:
> >>     1. they would have implement this function like powerpc
> >
> >Actually, powerpc seems to be the only OF platform reimplementing th=
is function.
> >s390 and x86 are not OF platforms.
> >
> >>     2. have other way to fix it up,  otherwise how it works now?
> >
> >Don't forget that my patchset aims to replace existing house-made co=
de with a more
> >generic version. When architectures and platforms switch to my code =
they will have
> >to add this back in their code if it's needed.
> >
> >> If my assumption is correct, this change will either have no effec=
t, or fix up
> >> the irq line the second time. Not harmful, but not necessary.
> >
> >Well, it will become necessary as old code gets dismantled and conve=
rted towards
> >this patchset. To give you an example that I'm familiar with, for ar=
ch/arm the
> >host bridge drivers have moved into drivers/pci/host, but they still=
 depend/use
> >the bios32 infrastructure that takes care of setting up the irq. Whe=
n they switch
> >to my version they would have to go and debug the "irq not being ass=
igned" issue
> >and it is quite likely that some of the people doing the conversion =
will complain
> >about my code rather than understanding the issue. What I'm trying t=
o do is to
> >make switching to my patchset as painless as possible, with a cleanu=
p to remove
> >redundant operations coming after the switchover.
> >
>=20
> This means this is a temporary version for the switchover period and =
will be
> reverted after switchover?

At least one of the redundant operations will be removed. Most likely t=
he one
in the arch code or in the driver. Do you have any concerns with that i=
dea?

Best regards,
Liviu

>=20
> >Does that sound like a reasonable plan?
> >
> >Best regards,
> >Liviu
> >
> >>=20
> >> I am not familiar with other arch, so the second case is my deduct=
ion. If this
> >> is not correct, please let me know.
> >>=20
> >> >
> >> >If I understood you correctly, it is a nice idea but slightly out=
side the scope
> >> >of my current patchset.
> >> >
> >> >Best regards,
> >> >Liviu
> >> >
> >> >>=20
> >> >> >
> >> >> >--=20
> >> >> >2.0.4
> >> >> >
> >> >> >--
> >> >> >To unsubscribe from this list: send the line "unsubscribe linu=
x-pci" in
> >> >> >the body of a message to majordomo@vger.kernel.org
> >> >> >More majordomo info at  http://vger.kernel.org/majordomo-info.=
html
> >> >>=20
> >> >> --=20
> >> >> Richard Yang
> >> >> Help you, Help me
> >> >>=20
> >> >> --
> >> >> To unsubscribe from this list: send the line "unsubscribe linux=
-pci" in
> >> >> the body of a message to majordomo@vger.kernel.org
> >> >> More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> >> >>=20
> >> >
> >>=20
> >> --=20
> >> Richard Yang
> >> Help you, Help me
> >>=20
> >>=20
> >
> >--=20
> >=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >| I would like to |
> >| fix the world,  |
> >| but they're not |
> >| giving me the   |
> > \ source code!  /
> >  ---------------
> >    =C2=AF\_(=E3=83=84)_/=C2=AF
>=20
> --=20
> Richard Yang
> Help you, Help me
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...
