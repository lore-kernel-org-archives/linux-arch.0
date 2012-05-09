From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 19/21] tile/PCI: Use pci_scan_root_bus instead pci_scan_bus
Date: Wed, 9 May 2012 12:45:50 -0700
Message-ID: <CAE9FiQXLriREi1m==3-yXrQja3Qi+HNfnvvq_0Sr7Rpiu_JKTg@mail.gmail.com>
References: <1336422606-4244-1-git-send-email-yinghai@kernel.org>
	<1336422606-4244-20-git-send-email-yinghai@kernel.org>
	<4FAAC652.4060502@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56864 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718Ab2EITpv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2012 15:45:51 -0400
In-Reply-To: <4FAAC652.4060502@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, May 9, 2012 at 12:32 PM, Chris Metcalf <cmetcalf@tilera.com> wr=
ote:
> On 5/7/2012 4:30 PM, Yinghai Lu wrote:
>> It will update busn_res accordingly, so we get that for last_busno.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> Cc: Chris Metcalf <cmetcalf@tilera.com>
>> ---
>> =A0arch/tile/kernel/pci.c | =A0 =A05 ++++-
>> =A01 files changed, 4 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/tile/kernel/pci.c b/arch/tile/kernel/pci.c
>> index 7aa2743..4a951b87 100644
>> --- a/arch/tile/kernel/pci.c
>> +++ b/arch/tile/kernel/pci.c
>> @@ -310,6 +310,7 @@ int __devinit pcibios_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_scan_flags[i] =3D=3D 0 && contro=
llers[i].ops !=3D NULL) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_controller *c=
ontroller =3D &controllers[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_bus *bus;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LIST_HEAD(resources);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (tile_init_irqs(i, co=
ntroller)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("=
PCI: Could not initialize IRQs\n");
>> @@ -327,7 +328,9 @@ int __devinit pcibios_init(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is inlined in =
linux/pci.h and calls into
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* pci_scan_bus_parent=
ed() in probe.c.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_scan_bus(0, co=
ntroller->ops, controller);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resource=
s, &ioport_resource);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resource=
s, &iomem_resource);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_scan_root_bus(=
NULL, 0, controller->ops, controller, &resources);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 controller->root_bus =3D=
 bus;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 controller->last_busno =3D=
 bus->busn_res.end;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> We don't want ioport_resource on tilepro, since we don't support acce=
ssing
> I/O port space.
>
> With that one line removed:
>
> Acked-by: Chris Metcalf <cmetcalf@tilera.com>

Thanks.

>
> Or, I can queue this change to take through the tile tree when the me=
rge
> window opens. =A0Which would you prefer?

have to go through pci-next tree. because other change like

 controller->last_busno =3D bus->busn_res.end;

is in pci-next.

Yinghai
