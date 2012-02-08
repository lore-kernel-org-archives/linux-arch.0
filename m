From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 06/24] PCI: Add busn_res tracking in core
Date: Wed, 8 Feb 2012 09:26:52 -0800
Message-ID: <CAE9FiQWBLpK-Tzmvf1dHeub4Yy2ziRBpnzYuEdBvdJASnbDqYw@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
	<1328425088-6562-7-git-send-email-yinghai@kernel.org>
	<CAErSpo4cd2TR4207RUk53B+jDK_DONduo8pU8EWWOgdGeg7CeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo4cd2TR4207RUk53B+jDK_DONduo8pU8EWWOgdGeg7CeQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 8, 2012 at 8:08 AM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> update pci_scan_root_bus, and pci_scan_bus to insert root bus busn i=
nto
>> iobusn_resource tree.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>> =A0drivers/pci/probe.c =A0| =A0 30 ++++++++++++++++++++++++++----
>> =A0drivers/pci/remove.c | =A0 =A01 +
>> =A0include/linux/pci.h =A0| =A0 =A04 ++++
>> =A03 files changed, 31 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index fabf9d0..cdd6e83 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1667,8 +1667,9 @@ void pci_bus_release_busn_res(struct pci_bus *=
b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res, ret ? "can not b=
e" : "is");
>> =A0}
>>
>> -struct pci_bus * __devinit pci_scan_root_bus(struct device *parent,=
 int bus,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata, st=
ruct list_head *resources)
>> +struct pci_bus * __devinit pci_scan_root_bus_max(struct device *par=
ent, int bus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int bus_max, struct pci_ops *ops, void=
 *sysdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct list_head *resources)
>> =A0{
>> =A0 =A0 =A0 =A0struct pci_bus *b;
>>
>> @@ -1676,10 +1677,26 @@ struct pci_bus * __devinit pci_scan_root_bus=
(struct device *parent, int bus,
>> =A0 =A0 =A0 =A0if (!b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
>>
>> + =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, bus_max);
>> =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus(b);
>> =A0 =A0 =A0 =A0pci_bus_add_devices(b);
>> =A0 =A0 =A0 =A0return b;
>> =A0}
>> +EXPORT_SYMBOL(pci_scan_root_bus_max);
>> +
>> +struct pci_bus * __devinit pci_scan_root_bus(struct device *parent,=
 int bus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct list_head *resources)
>> +{
>> + =A0 =A0 =A0 struct pci_bus *b;
>> +
>> + =A0 =A0 =A0 b =3D pci_scan_root_bus_max(parent, bus, 255, ops, sys=
data, resources);
>> +
>> + =A0 =A0 =A0 if (b)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subo=
rdinate);
>> +
>> + =A0 =A0 =A0 return b;
>> +}
>> =A0EXPORT_SYMBOL(pci_scan_root_bus);
>>
>> =A0/* Deprecated; use pci_scan_root_bus() instead */
>> @@ -1692,9 +1709,11 @@ struct pci_bus * __devinit pci_scan_bus_paren=
ted(struct device *parent,
>> =A0 =A0 =A0 =A0pci_add_resource(&resources, &ioport_resource);
>> =A0 =A0 =A0 =A0pci_add_resource(&resources, &iomem_resource);
>> =A0 =A0 =A0 =A0b =3D pci_create_root_bus(parent, bus, ops, sysdata, =
&resources);
>> - =A0 =A0 =A0 if (b)
>> + =A0 =A0 =A0 if (b) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, 255);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus=
(b);
>> - =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subo=
rdinate);
>> + =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_free_resource_list(&resources);
>> =A0 =A0 =A0 =A0return b;
>> =A0}
>> @@ -1710,7 +1729,10 @@ struct pci_bus * __devinit pci_scan_bus(int b=
us, struct pci_ops *ops,
>> =A0 =A0 =A0 =A0pci_add_resource(&resources, &iomem_resource);
>> =A0 =A0 =A0 =A0b =3D pci_create_root_bus(NULL, bus, ops, sysdata, &r=
esources);
>> =A0 =A0 =A0 =A0if (b) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_insert_busn_res(b, bus, 255);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0b->subordinate =3D pci_scan_child_bus=
(b);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(b, b->subo=
rdinate);
>> +
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_bus_add_devices(b);
>> =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_free_resource_list(&resources);
>> diff --git a/drivers/pci/remove.c b/drivers/pci/remove.c
>> index 82f8ae5..5b679d2 100644
>> --- a/drivers/pci/remove.c
>> +++ b/drivers/pci/remove.c
>> @@ -68,6 +68,7 @@ void pci_remove_bus(struct pci_bus *pci_bus)
>>
>> =A0 =A0 =A0 =A0down_write(&pci_bus_sem);
>> =A0 =A0 =A0 =A0list_del(&pci_bus->node);
>> + =A0 =A0 =A0 pci_bus_release_busn_res(pci_bus);
>> =A0 =A0 =A0 =A0up_write(&pci_bus_sem);
>> =A0 =A0 =A0 =A0if (!pci_bus->is_added)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 3da935c..d5b6786 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -668,6 +668,10 @@ struct pci_bus *pci_create_root_bus(struct devi=
ce *parent, int bus,
>> =A0void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int busm=
ax);
>> =A0void pci_bus_update_busn_res_end(struct pci_bus *b, int busmax);
>> =A0void pci_bus_release_busn_res(struct pci_bus *b);
>> +struct pci_bus * __devinit pci_scan_root_bus_max(struct device *par=
ent, int bus,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0int busmax, struct pci_ops *ops,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0void *sysdata,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0struct list_head *resources);
>> =A0struct pci_bus * __devinit pci_scan_root_bus(struct device *paren=
t, int bus,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct pci_ops *ops, void *sysdata,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 struct list_head *resources);
>
> Now we have both pci_bus_insert_busn_res() and
> pci_scan_root_bus_max(). =A0Why do we need both? =A0I think it's too =
much
> of a burden on architectures to expect them to understand both.
>
> Maybe some sample pseudo-code using both interfaces would help me
> understand what you expect a typical architecture to do.

We need to call pci_bus_insert_busn_res for root bus:
1. after that bus is allocated (...) : that busn_res is in the bus stru=
ct.
2. before pci_scan_child_bus

Yinghai
