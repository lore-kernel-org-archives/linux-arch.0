From: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 02/12] PCI: OF: Parse and map the IRQ when adding the
 PCI device.
Date: Mon, 18 Aug 2014 09:44:04 +0800
Message-ID: <20140818014404.GA11354@richard>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-3-git-send-email-Liviu.Dudau@arm.com>
 <20140814145804.GA5586@richard>
 <20140814154959.GG25761@e106497-lin.cambridge.arm.com>
 <20140815085632.GA4954@richard>
 <20140815103052.GD27553@e106497-lin.cambridge.arm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140815103052.GD27553@e106497-lin.cambridge.arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Aug 15, 2014 at 11:30:52AM +0100, Liviu Dudau wrote:
>On Fri, Aug 15, 2014 at 09:56:32AM +0100, Wei Yang wrote:
>> On Thu, Aug 14, 2014 at 04:49:59PM +0100, Liviu Dudau wrote:
>> >On Thu, Aug 14, 2014 at 03:58:04PM +0100, Wei Yang wrote:
>> >> On Tue, Aug 12, 2014 at 05:25:15PM +0100, Liviu Dudau wrote:
>> >> >Enhance the default implementation of pcibios_add_device() to
>> >> >parse and map the IRQ of the device if a DT binding is available=
=2E
>> >> >
>> >> >Cc: Bjorn Helgaas <bhelgaas@google.com>
>> >> >Cc: Grant Likely <grant.likely@linaro.org>
>> >> >Cc: Rob Herring <robh+dt@kernel.org>
>> >> >Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
>> >> >---
>> >> > drivers/pci/pci.c | 3 +++
>> >> > 1 file changed, 3 insertions(+)
>> >> >
>> >> >diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> >> >index 1c8592b..29d1775 100644
>> >> >--- a/drivers/pci/pci.c
>> >> >+++ b/drivers/pci/pci.c
>> >> >@@ -17,6 +17,7 @@
>> >> > #include <linux/spinlock.h>
>> >> > #include <linux/string.h>
>> >> > #include <linux/log2.h>
>> >> >+#include <linux/of_pci.h>
>> >> > #include <linux/pci-aspm.h>
>> >> > #include <linux/pm_wakeup.h>
>> >> > #include <linux/interrupt.h>
>> >> >@@ -1453,6 +1454,8 @@ EXPORT_SYMBOL(pcim_pin_device);
>> >> >  */
>> >> > int __weak pcibios_add_device(struct pci_dev *dev)
>> >> > {
>> >> >+	dev->irq =3D of_irq_parse_and_map_pci(dev, 0, 0);
>> >> >+
>> >> > 	return 0;
>> >> > }
>> >>=20
>> >> Liviu,
>> >>=20
>> >> For this, my suggestion is to add arch dependent function to setu=
p the irq
>> >> line for pci devices. I can't find an obvious reason this won't w=
ork on other
>> >> archs, but maybe this will hurt some of them?
>> >
>> >Hi Wei,
>> >
>> >I'm not sure I understand your point. Architectures that support OF=
 will obviously
>> >benefit from this common approach, and for the other ones the funct=
ion is empty
>> >so it will not change existing behaviour. If you are suggesting tha=
t I should
>> >create a new API that each architecture could go and implement for =
setting up the
>> >IRQ line then I would agree that it would be nice to have that, but=
 the question
>> >is how many architectures are outside OF that need this?
>>=20
>> My suggestion is to define the pcibios_add_device() for arm arch, li=
ke the one
>> in arch/powerpc/kernel/pci-common.c. If my understanding is correct,=
 this
>> patch set address the pci bus setup mostly on arm arch.
>
>And also arm64 at the least.
>
>>=20
>> For those archs not support OF, this function is empty and has no ef=
fect. I
>> agree on this one.
>>=20
>> For those archs rely on OF, we still have two cases:
>>     1. they would have implement this function like powerpc
>
>Actually, powerpc seems to be the only OF platform reimplementing this=
 function.
>s390 and x86 are not OF platforms.
>
>>     2. have other way to fix it up,  otherwise how it works now?
>
>Don't forget that my patchset aims to replace existing house-made code=
 with a more
>generic version. When architectures and platforms switch to my code th=
ey will have
>to add this back in their code if it's needed.
>
>> If my assumption is correct, this change will either have no effect,=
 or fix up
>> the irq line the second time. Not harmful, but not necessary.
>
>Well, it will become necessary as old code gets dismantled and convert=
ed towards
>this patchset. To give you an example that I'm familiar with, for arch=
/arm the
>host bridge drivers have moved into drivers/pci/host, but they still d=
epend/use
>the bios32 infrastructure that takes care of setting up the irq. When =
they switch
>to my version they would have to go and debug the "irq not being assig=
ned" issue
>and it is quite likely that some of the people doing the conversion wi=
ll complain
>about my code rather than understanding the issue. What I'm trying to =
do is to
>make switching to my patchset as painless as possible, with a cleanup =
to remove
>redundant operations coming after the switchover.
>

This means this is a temporary version for the switchover period and wi=
ll be
reverted after switchover?

>Does that sound like a reasonable plan?
>
>Best regards,
>Liviu
>
>>=20
>> I am not familiar with other arch, so the second case is my deductio=
n. If this
>> is not correct, please let me know.
>>=20
>> >
>> >If I understood you correctly, it is a nice idea but slightly outsi=
de the scope
>> >of my current patchset.
>> >
>> >Best regards,
>> >Liviu
>> >
>> >>=20
>> >> >
>> >> >--=20
>> >> >2.0.4
>> >> >
>> >> >--
>> >> >To unsubscribe from this list: send the line "unsubscribe linux-=
pci" in
>> >> >the body of a message to majordomo@vger.kernel.org
>> >> >More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>> >>=20
>> >> --=20
>> >> Richard Yang
>> >> Help you, Help me
>> >>=20
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe linux-p=
ci" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>> >>=20
>> >
>>=20
>> --=20
>> Richard Yang
>> Help you, Help me
>>=20
>>=20
>
>--=20
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>| I would like to |
>| fix the world,  |
>| but they're not |
>| giving me the   |
> \ source code!  /
>  ---------------
>    =C2=AF\_(=E3=83=84)_/=C2=AF

--=20
Richard Yang
Help you, Help me
