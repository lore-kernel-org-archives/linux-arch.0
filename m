From: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the
 PCI device.
Date: Fri, 15 Aug 2014 11:30:52 +0100
Message-ID: <20140815103052.GD27553@e106497-lin.cambridge.arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-3-git-send-email-Liviu.Dudau@arm.com>
 <20140814145804.GA5586@richard>
 <20140814154959.GG25761@e106497-lin.cambridge.arm.com>
 <20140815085632.GA4954@richard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140815085632.GA4954@richard>
Content-Disposition: inline
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yang <weiyang-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 15, 2014 at 09:56:32AM +0100, Wei Yang wrote:
> On Thu, Aug 14, 2014 at 04:49:59PM +0100, Liviu Dudau wrote:
> >On Thu, Aug 14, 2014 at 03:58:04PM +0100, Wei Yang wrote:
> >> On Tue, Aug 12, 2014 at 05:25:15PM +0100, Liviu Dudau wrote:
> >> >Enhance the default implementation of pcibios_add_device() to
> >> >parse and map the IRQ of the device if a DT binding is available.
> >> >
> >> >Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >> >Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> >Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> >Signed-off-by: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
> >> >---
> >> > drivers/pci/pci.c | 3 +++
> >> > 1 file changed, 3 insertions(+)
> >> >
> >> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> >> >index 1c8592b..29d1775 100644
> >> >--- a/drivers/pci/pci.c
> >> >+++ b/drivers/pci/pci.c
> >> >@@ -17,6 +17,7 @@
> >> > #include <linux/spinlock.h>
> >> > #include <linux/string.h>
> >> > #include <linux/log2.h>
> >> >+#include <linux/of_pci.h>
> >> > #include <linux/pci-aspm.h>
> >> > #include <linux/pm_wakeup.h>
> >> > #include <linux/interrupt.h>
> >> >@@ -1453,6 +1454,8 @@ EXPORT_SYMBOL(pcim_pin_device);
> >> >  */
> >> > int __weak pcibios_add_device(struct pci_dev *dev)
> >> > {
> >> >+	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
> >> >+
> >> > 	return 0;
> >> > }
> >>=20
> >> Liviu,
> >>=20
> >> For this, my suggestion is to add arch dependent function to setup=
 the irq
> >> line for pci devices. I can't find an obvious reason this won't wo=
rk on other
> >> archs, but maybe this will hurt some of them?
> >
> >Hi Wei,
> >
> >I'm not sure I understand your point. Architectures that support OF =
will obviously
> >benefit from this common approach, and for the other ones the functi=
on is empty
> >so it will not change existing behaviour. If you are suggesting that=
 I should
> >create a new API that each architecture could go and implement for s=
etting up the
> >IRQ line then I would agree that it would be nice to have that, but =
the question
> >is how many architectures are outside OF that need this?
>=20
> My suggestion is to define the pcibios_add_device() for arm arch, lik=
e the one
> in arch/powerpc/kernel/pci-common.c. If my understanding is correct, =
this
> patch set address the pci bus setup mostly on arm arch.

And also arm64 at the least.

>=20
> For those archs not support OF, this function is empty and has no eff=
ect. I
> agree on this one.
>=20
> For those archs rely on OF, we still have two cases:
>     1. they would have implement this function like powerpc

Actually, powerpc seems to be the only OF platform reimplementing this =
function.
s390 and x86 are not OF platforms.

>     2. have other way to fix it up,  otherwise how it works now?

Don't forget that my patchset aims to replace existing house-made code =
with a more
generic version. When architectures and platforms switch to my code the=
y will have
to add this back in their code if it's needed.

> If my assumption is correct, this change will either have no effect, =
or fix up
> the irq line the second time. Not harmful, but not necessary.

Well, it will become necessary as old code gets dismantled and converte=
d towards
this patchset. To give you an example that I'm familiar with, for arch/=
arm the
host bridge drivers have moved into drivers/pci/host, but they still de=
pend/use
the bios32 infrastructure that takes care of setting up the irq. When t=
hey switch
to my version they would have to go and debug the "irq not being assign=
ed" issue
and it is quite likely that some of the people doing the conversion wil=
l complain
about my code rather than understanding the issue. What I'm trying to d=
o is to
make switching to my patchset as painless as possible, with a cleanup t=
o remove
redundant operations coming after the switchover.

Does that sound like a reasonable plan?

Best regards,
Liviu

>=20
> I am not familiar with other arch, so the second case is my deduction=
=2E If this
> is not correct, please let me know.
>=20
> >
> >If I understood you correctly, it is a nice idea but slightly outsid=
e the scope
> >of my current patchset.
> >
> >Best regards,
> >Liviu
> >
> >>=20
> >> >
> >> >--=20
> >> >2.0.4
> >> >
> >> >--
> >> >To unsubscribe from this list: send the line "unsubscribe linux-p=
ci" in
> >> >the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> >More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >>=20
> >> --=20
> >> Richard Yang
> >> Help you, Help me
> >>=20
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-pc=
i" in
> >> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>=20
> >
>=20
> --=20
> Richard Yang
> Help you, Help me
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
