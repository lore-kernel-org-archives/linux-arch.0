From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 03/18] PCI: add struct pci_host_bridge_window with
 CPU/bus address offset
Date: Thu, 9 Feb 2012 20:37:52 -0800
Message-ID: <CAErSpo76wbkAUGR-S6iC1NBVM4xf8-=-t5KQWvr0jagh1nPpAg@mail.gmail.com>
References: <20120210023424.10311.82445.stgit@bhelgaas.mtv.corp.google.com>
 <20120210023636.10311.79110.stgit@bhelgaas.mtv.corp.google.com> <CAE9FiQXZqGHAQvrwiMsQsvtDM6ggV1+=uYztV0pNQHh_n8F0rQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61689 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758296Ab2BJEiN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Feb 2012 23:38:13 -0500
Received: by wics10 with SMTP id s10so1729551wic.19
        for <linux-arch@vger.kernel.org>; Thu, 09 Feb 2012 20:38:12 -0800 (PST)
In-Reply-To: <CAE9FiQXZqGHAQvrwiMsQsvtDM6ggV1+=uYztV0pNQHh_n8F0rQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org

On Thu, Feb 9, 2012 at 7:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Thu, Feb 9, 2012 at 6:36 PM, Bjorn Helgaas <bhelgaas@google.com> w=
rote:
>> Some PCI host bridges apply an address offset, so bus addresses on P=
CI are
>> different from CPU addresses. =A0This patch adds a way for architect=
ures to
>> tell the PCI core about this offset. =A0For example:
>>
>> =A0 =A0LIST_HEAD(resources);
>> =A0 =A0pci_add_resource_offset(&resources, host->io_space, host->io_=
offset);
>> =A0 =A0pci_add_resource_offset(&resources, host->mem_space, host->me=
m_offset);
>> =A0 =A0pci_scan_root_bus(parent, bus, ops, sysdata, &resources);
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0drivers/pci/bus.c =A0 | =A0 30 +++++++++++++++++++-----------
>> =A0drivers/pci/probe.c | =A0 32 +++++++++++++++++++++++---------
>> =A0include/linux/pci.h | =A0 =A09 +++++++++
>> =A03 files changed, 51 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
>> index 398f5d8..4ce5ef2 100644
>> --- a/drivers/pci/bus.c
>> +++ b/drivers/pci/bus.c
>> @@ -18,28 +18,36 @@
>>
>> =A0#include "pci.h"
>>
>> -void pci_add_resource(struct list_head *resources, struct resource =
*res)
>> +void pci_add_resource_offset(struct list_head *resources, struct re=
source *res,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_si=
ze_t offset)
>> =A0{
>> - =A0 =A0 =A0 struct pci_bus_resource *bus_res;
>> + =A0 =A0 =A0 struct pci_host_bridge_window *window;
>>
>> - =A0 =A0 =A0 bus_res =3D kzalloc(sizeof(struct pci_bus_resource), G=
=46P_KERNEL);
>> - =A0 =A0 =A0 if (!bus_res) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PCI: can't add bus re=
source %pR\n", res);
>> + =A0 =A0 =A0 window =3D kzalloc(sizeof(struct pci_host_bridge_windo=
w), GFP_KERNEL);
>> + =A0 =A0 =A0 if (!window) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "PCI: can't add host b=
ridge window %pR\n", res);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>> =A0 =A0 =A0 =A0}
>>
>> - =A0 =A0 =A0 bus_res->res =3D res;
>> - =A0 =A0 =A0 list_add_tail(&bus_res->list, resources);
>> + =A0 =A0 =A0 window->res =3D res;
>> + =A0 =A0 =A0 window->offset =3D offset;
>> + =A0 =A0 =A0 list_add_tail(&window->list, resources);
>> +}
>> +EXPORT_SYMBOL(pci_add_resource_offset);
>> +
>> +void pci_add_resource(struct list_head *resources, struct resource =
*res)
>> +{
>> + =A0 =A0 =A0 pci_add_resource_offset(resources, res, 0);
>> =A0}
>> =A0EXPORT_SYMBOL(pci_add_resource);
>>
>> =A0void pci_free_resource_list(struct list_head *resources)
>> =A0{
>> - =A0 =A0 =A0 struct pci_bus_resource *bus_res, *tmp;
>> + =A0 =A0 =A0 struct pci_host_bridge_window *window, *tmp;
>>
>> - =A0 =A0 =A0 list_for_each_entry_safe(bus_res, tmp, resources, list=
) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&bus_res->list);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(bus_res);
>> + =A0 =A0 =A0 list_for_each_entry_safe(window, tmp, resources, list)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&window->list);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(window);
>> =A0 =A0 =A0 =A0}
>> =A0}
>> =A0EXPORT_SYMBOL(pci_free_resource_list);
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index 2ffe8a3..69c1b11 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1544,12 +1544,15 @@ unsigned int __devinit pci_scan_child_bus(st=
ruct pci_bus *bus)
>> =A0struct pci_bus *pci_create_root_bus(struct device *parent, int bu=
s,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_ops *ops, void *sysdata, s=
truct list_head *resources)
>> =A0{
>> - =A0 =A0 =A0 int error, i;
>> + =A0 =A0 =A0 int error;
>> =A0 =A0 =A0 =A0struct pci_host_bridge *bridge;
>> =A0 =A0 =A0 =A0struct pci_bus *b, *b2;
>> =A0 =A0 =A0 =A0struct device *dev;
>> - =A0 =A0 =A0 struct pci_bus_resource *bus_res, *n;
>> + =A0 =A0 =A0 struct pci_host_bridge_window *window, *n;
>> =A0 =A0 =A0 =A0struct resource *res;
>> + =A0 =A0 =A0 resource_size_t offset;
>> + =A0 =A0 =A0 char bus_addr[64];
>> + =A0 =A0 =A0 char *fmt;
>>
>> =A0 =A0 =A0 =A0bridge =3D kzalloc(sizeof(*bridge), GFP_KERNEL);
>> =A0 =A0 =A0 =A0if (!bridge)
>> @@ -1599,19 +1602,30 @@ struct pci_bus *pci_create_root_bus(struct d=
evice *parent, int bus,
>> =A0 =A0 =A0 =A0b->number =3D b->secondary =3D bus;
>>
>> =A0 =A0 =A0 =A0bridge->bus =3D b;
>> -
>> - =A0 =A0 =A0 /* Add initial resources to the bus */
>> - =A0 =A0 =A0 list_for_each_entry_safe(bus_res, n, resources, list)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move_tail(&bus_res->list, &b->res=
ources);
>> + =A0 =A0 =A0 INIT_LIST_HEAD(&bridge->windows);
>>
>> =A0 =A0 =A0 =A0if (parent)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_info(parent, "PCI host bridge to =
bus %s\n", dev_name(&b->dev));
>> =A0 =A0 =A0 =A0else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_INFO "PCI host bridge to =
bus %s\n", dev_name(&b->dev));
>>
>> - =A0 =A0 =A0 pci_bus_for_each_resource(b, res, i) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&b->dev, "roo=
t bus resource %pR\n", res);
>> + =A0 =A0 =A0 /* Add initial resources to the bus */
>> + =A0 =A0 =A0 list_for_each_entry_safe(window, n, resources, list) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_move_tail(&window->list, &bridge-=
>windows);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D window->res;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 offset =3D window->offset;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_resource(b, res, 0);
>
> you put two copies of root resource list ?

The root bus has a list of resources, as it always has.

The host bridge also has a list that contains the same resources.  In
addition, this list contains the offset the host bridge applies to
each aperture.

So yes, there are two lists, but they are not the same.  I don't think
it makes sense to add the offset information to the resource list of
every bus, because the offset is always zero for P2P bridges.

Bjorn
