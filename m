From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the
 PCI device.
Date: Thu, 14 Aug 2014 16:49:59 +0100
Message-ID: <20140814154959.GG25761@e106497-lin.cambridge.arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-3-git-send-email-Liviu.Dudau@arm.com>
 <20140814145804.GA5586@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140814145804.GA5586@richard>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 14, 2014 at 03:58:04PM +0100, Wei Yang wrote:
> On Tue, Aug 12, 2014 at 05:25:15PM +0100, Liviu Dudau wrote:
> >Enhance the default implementation of pcibios_add_device() to
> >parse and map the IRQ of the device if a DT binding is available.
> >
> >Cc: Bjorn Helgaas <bhelgaas@google.com>
> >Cc: Grant Likely <grant.likely@linaro.org>
> >Cc: Rob Herring <robh+dt@kernel.org>
> >Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >---
> > drivers/pci/pci.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >index 1c8592b..29d1775 100644
> >--- a/drivers/pci/pci.c
> >+++ b/drivers/pci/pci.c
> >@@ -17,6 +17,7 @@
> > #include <linux/spinlock.h>
> > #include <linux/string.h>
> > #include <linux/log2.h>
> >+#include <linux/of_pci.h>
> > #include <linux/pci-aspm.h>
> > #include <linux/pm_wakeup.h>
> > #include <linux/interrupt.h>
> >@@ -1453,6 +1454,8 @@ EXPORT_SYMBOL(pcim_pin_device);
> >  */
> > int __weak pcibios_add_device(struct pci_dev *dev)
> > {
> >+	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
> >+
> > 	return 0;
> > }
>=20
> Liviu,
>=20
> For this, my suggestion is to add arch dependent function to setup th=
e irq
> line for pci devices. I can't find an obvious reason this won't work =
on other
> archs, but maybe this will hurt some of them?

Hi Wei,

I'm not sure I understand your point. Architectures that support OF wil=
l obviously
benefit from this common approach, and for the other ones the function =
is empty
so it will not change existing behaviour. If you are suggesting that I =
should
create a new API that each architecture could go and implement for sett=
ing up the
IRQ line then I would agree that it would be nice to have that, but the=
 question
is how many architectures are outside OF that need this?

If I understood you correctly, it is a nice idea but slightly outside t=
he scope
of my current patchset.

Best regards,
Liviu

>=20
> >
> >--=20
> >2.0.4
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe linux-pci"=
 in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
