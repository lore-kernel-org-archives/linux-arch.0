From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 06/29] x86/PCI: convert to pci_create_root_bus() and pci_scan_root_bus()
Date: Fri, 14 Oct 2011 14:32:49 -0600
Message-ID: <CAErSpo568q-KOk25RaaZ+=erLEEC4rsPwGNy0drCbqpCLKGybQ@mail.gmail.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
 <20111014042737.23504.46601.stgit@bhelgaas.mtv.corp.google.com> <4E97C8F0.7030108@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:47259 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab1JNUdL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 16:33:11 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id p9EKXBvA028486
	for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 13:33:11 -0700
Received: from yxk36 (yxk36.prod.google.com [10.190.3.164])
	by wpaz33.hot.corp.google.com with ESMTP id p9EKUYsa013613
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 13:33:10 -0700
Received: by yxk36 with SMTP id 36so1272140yxk.11
        for <linux-arch@vger.kernel.org>; Fri, 14 Oct 2011 13:33:10 -0700 (PDT)
In-Reply-To: <4E97C8F0.7030108@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On Thu, Oct 13, 2011 at 11:30 PM, Yinghai Lu <yinghai.lu@oracle.com> wr=
ote:
> On 10/13/2011 09:27 PM, Bjorn Helgaas wrote:
>
>> x86 has two kinds of PCI root bus scanning:
>>
>> (1) ACPI-based, using _CRS resources. =A0This used pci_create_bus() =
because
>> =A0 =A0 ACPI hotplug needed to split the pci_bus_add_devices() into =
a separate
>> =A0 =A0 .start() method.
>>
>> =A0 =A0 This patch parses the _CRS resources earlier, so we can buil=
d a list of
>> =A0 =A0 resources and pass it to pci_create_root_bus().
>>
>> =A0 =A0 Note that as before, we parse the _CRS even if we aren't goi=
ng to use
>> =A0 =A0 it so we can print it for debugging purposes.
>>
>> (2) All other, which used either default resources (ioport_resource =
and
>> =A0 =A0 iomem_resource) or information read from the hardware via am=
d_bus.c or
>> =A0 =A0 similar. =A0This used pci_scan_bus().
>>
>> =A0 =A0 This patch converts x86_pci_root_bus_res_quirks() (previousl=
y called
>> =A0 =A0 from pcibios_fixup_bus()) to x86_pci_root_bus_resources(), w=
hich builds
>> =A0 =A0 a list of resources before we call pci_scan_root_bus().
>>
>> =A0 =A0 We also use x86_pci_root_bus_resources() if we have ACPI but=
 are
>> =A0 =A0 ignoring _CRS.
>>
>> CC: Yinghai Lu <yinghai.lu@oracle.com>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>> =A0arch/x86/include/asm/topology.h | =A0 =A02 +-
>> =A0arch/x86/pci/acpi.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 31 ++++++++++++=
+++++--------------
>> =A0arch/x86/pci/bus_numa.c =A0 =A0 =A0 =A0 | =A0 31 ++++++++++++++++=
++-------------
>> =A0arch/x86/pci/common.c =A0 =A0 =A0 =A0 =A0 | =A0 21 ++++++++++++++=
-------
>> =A04 files changed, 50 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/=
topology.h
>> index c006924..5f83b13 100644
>> --- a/arch/x86/include/asm/topology.h
>> +++ b/arch/x86/include/asm/topology.h
>> @@ -174,7 +174,7 @@ static inline void arch_fix_phys_package_id(int =
num, u32 slot)
>> =A0}
>>
>> =A0struct pci_bus;
>> -void x86_pci_root_bus_res_quirks(struct pci_bus *b);
>> +void x86_pci_root_bus_resources(int bus, struct list_head *resource=
s);
>>
>> =A0#ifdef CONFIG_SMP
>> =A0#define mc_capable() ((boot_cpu_data.x86_max_cores > 1) && \
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index 039d913..77bb332 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -12,7 +12,7 @@ struct pci_root_info {
>> =A0 =A0 =A0 char *name;
>> =A0 =A0 =A0 unsigned int res_num;
>> =A0 =A0 =A0 struct resource *res;
>> - =A0 =A0 struct pci_bus *bus;
>> + =A0 =A0 struct list_head *resources;
>> =A0 =A0 =A0 int busnum;
>> =A0};
>>
>> @@ -250,23 +250,20 @@ static void add_resources(struct pci_root_info=
 *info)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"igno=
ring host bridge window %pR (conflicts with %s %pR)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0res, =
conflict->name, conflict);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_resource(info-=
>bus, res, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(info->res=
ources, res);
>> =A0 =A0 =A0 }
>> =A0}
>>
>> =A0static void
>> =A0get_current_resources(struct acpi_device *device, int busnum,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int domain, struct pci_bus=
 *bus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int domain, struct list_head *=
resources)
>> =A0{
>> =A0 =A0 =A0 struct pci_root_info info;
>> =A0 =A0 =A0 size_t size;
>>
>> - =A0 =A0 if (pci_use_crs)
>> - =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_remove_resources(bus);
>> -
>> =A0 =A0 =A0 info.bridge =3D device;
>> - =A0 =A0 info.bus =3D bus;
>> =A0 =A0 =A0 info.res_num =3D 0;
>> + =A0 =A0 info.resources =3D resources;
>> =A0 =A0 =A0 acpi_walk_resources(device->handle, METHOD_NAME__CRS, co=
unt_resource,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &info);
>> =A0 =A0 =A0 if (!info.res_num)
>> @@ -275,7 +272,7 @@ get_current_resources(struct acpi_device *device=
, int busnum,
>> =A0 =A0 =A0 size =3D sizeof(*info.res) * info.res_num;
>> =A0 =A0 =A0 info.res =3D kmalloc(size, GFP_KERNEL);
>> =A0 =A0 =A0 if (!info.res)
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto res_alloc_fail;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> =A0 =A0 =A0 info.name =3D kasprintf(GFP_KERNEL, "PCI Bus %04x:%02x",=
 domain, busnum);
>> =A0 =A0 =A0 if (!info.name)
>> @@ -290,8 +287,6 @@ get_current_resources(struct acpi_device *device=
, int busnum,
>>
>> =A0name_alloc_fail:
>> =A0 =A0 =A0 kfree(info.res);
>> -res_alloc_fail:
>> - =A0 =A0 return;
>> =A0}
>>
>> =A0struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_roo=
t *root)
>> @@ -299,6 +294,7 @@ struct pci_bus * __devinit pci_acpi_scan_root(st=
ruct acpi_pci_root *root)
>> =A0 =A0 =A0 struct acpi_device *device =3D root->device;
>> =A0 =A0 =A0 int domain =3D root->segment;
>> =A0 =A0 =A0 int busnum =3D root->secondary.start;
>> + =A0 =A0 struct list_head resources;
>> =A0 =A0 =A0 struct pci_bus *bus;
>> =A0 =A0 =A0 struct pci_sysdata *sd;
>> =A0 =A0 =A0 int node;
>> @@ -353,11 +349,18 @@ struct pci_bus * __devinit pci_acpi_scan_root(=
struct acpi_pci_root *root)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(bus->sysdata, sd, sizeof(*sd));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(sd);
>> =A0 =A0 =A0 } else {
>> - =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_create_bus(NULL, busnum, &pci_=
root_ops, sd);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bus) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_current_resources(devi=
ce, busnum, domain, bus);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->subordinate =3D pci_s=
can_child_bus(bus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&resources);
>> + =A0 =A0 =A0 =A0 =A0 =A0 get_current_resources(device, busnum, doma=
in, &resources);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pci_use_crs) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&re=
sources);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x86_pci_root_bus_resources=
(busnum, &resources);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
>
> You may need to update get_current_resources() to return status about=
 handling _CRS...
> and check that status insteaf of !pci_use_crs.

Is the current patch broken here?  I don't think it will be simpler to
have get_current_resources() return a status and check that.  But if
something's actually broken, I want to fix it, of course.

>> + =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_create_root_bus(NULL, busnum, =
&pci_root_ops, sd,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 &resources);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (bus)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->subordinate =3D pci_s=
can_child_bus(bus);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&re=
sources);
>> =A0 =A0 =A0 }
>
>>
>
>> =A0 =A0 =A0 /* After the PCI-E bus has been walked and all devices d=
iscovered,
>> diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
>> index 64a1228..fd3f655 100644
>> --- a/arch/x86/pci/bus_numa.c
>> +++ b/arch/x86/pci/bus_numa.c
>> @@ -7,45 +7,50 @@
>> =A0int pci_root_num;
>> =A0struct pci_root_info pci_root_info[PCI_ROOT_NR];
>>
>> -void x86_pci_root_bus_res_quirks(struct pci_bus *b)
>> +void x86_pci_root_bus_resources(int bus, struct list_head *resource=
s)
>> =A0{
>> =A0 =A0 =A0 int i;
>> =A0 =A0 =A0 int j;
>> =A0 =A0 =A0 struct pci_root_info *info;
>>
>> - =A0 =A0 /* don't go for it if _CRS is used already */
>> - =A0 =A0 if (b->resource[0] !=3D &ioport_resource ||
>> - =A0 =A0 =A0 =A0 b->resource[1] !=3D &iomem_resource)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> -
>> =A0 =A0 =A0 if (!pci_root_num)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto default_resources;
>>
>> =A0 =A0 =A0 for (i =3D 0; i < pci_root_num; i++) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (pci_root_info[i].bus_min =3D=3D b->num=
ber)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pci_root_info[i].bus_min =3D=3D bus)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (i =3D=3D pci_root_num)
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto default_resources;
>>
>> - =A0 =A0 printk(KERN_DEBUG "PCI: peer root bus %02x res updated fro=
m pci conf\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 b->number);
>> + =A0 =A0 printk(KERN_DEBUG "PCI: root bus %02x: hardware-probed res=
ources\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0bus);
>>
>> - =A0 =A0 pci_bus_remove_resources(b);
>> =A0 =A0 =A0 info =3D &pci_root_info[i];
>> =A0 =A0 =A0 for (j =3D 0; j < info->res_num; j++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *res;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct resource *root;
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 res =3D &info->res[j];
>> - =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_add_resource(b, res, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(resources, res);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (res->flags & IORESOURCE_IO)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root =3D &ioport_resourc=
e;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 root =3D &iomem_resource=
;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 insert_resource(root, res);
>> =A0 =A0 =A0 }
>> + =A0 =A0 return;
>> +
>> +default_resources:
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* We don't have any host bridge aperture information fr=
om the
>> + =A0 =A0 =A0* "native host bridge drivers," e.g., amd_bus or broadc=
om_bus,
>> + =A0 =A0 =A0* so fall back to the defaults historically used by pci=
_create_bus().
>> + =A0 =A0 =A0*/
>> + =A0 =A0 printk(KERN_DEBUG "PCI: root bus %02x: using default resou=
rces\n", bus);
>> + =A0 =A0 pci_add_resource(resources, &ioport_resource);
>> + =A0 =A0 pci_add_resource(resources, &iomem_resource);
>> =A0}
>>
>> =A0void __devinit update_res(struct pci_root_info *info, resource_si=
ze_t start,
>> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
>> index b389a2d..7f595cc 100644
>> --- a/arch/x86/pci/common.c
>> +++ b/arch/x86/pci/common.c
>> @@ -164,9 +164,6 @@ void __devinit pcibios_fixup_bus(struct pci_bus =
*b)
>> =A0{
>> =A0 =A0 =A0 struct pci_dev *dev;
>>
>> - =A0 =A0 /* root bus? */
>> - =A0 =A0 if (!b->parent)
>> - =A0 =A0 =A0 =A0 =A0 =A0 x86_pci_root_bus_res_quirks(b);
>> =A0 =A0 =A0 pci_read_bridge_bases(b);
>> =A0 =A0 =A0 list_for_each_entry(dev, &b->devices, bus_list)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pcibios_fixup_device_resources(dev);
>> @@ -433,6 +430,7 @@ void __init dmi_check_pciprobe(void)
>>
>> =A0struct pci_bus * __devinit pcibios_scan_root(int busnum)
>> =A0{
>> + =A0 =A0 struct list_head resources;
>> =A0 =A0 =A0 struct pci_bus *bus =3D NULL;
>> =A0 =A0 =A0 struct pci_sysdata *sd;
>>
>> @@ -456,9 +454,13 @@ struct pci_bus * __devinit pcibios_scan_root(in=
t busnum)
>> =A0 =A0 =A0 sd->node =3D get_mp_bus_to_node(busnum);
>>
>> =A0 =A0 =A0 printk(KERN_DEBUG "PCI: Probing PCI hardware (bus %02x)\=
n", busnum);
>> - =A0 =A0 bus =3D pci_scan_bus(busnum, &pci_root_ops, sd);
>> - =A0 =A0 if (!bus)
>> + =A0 =A0 INIT_LIST_HEAD(&resources);
>> + =A0 =A0 x86_pci_root_bus_resources(busnum, &resources);
>> + =A0 =A0 bus =3D pci_scan_root_bus(NULL, busnum, &pci_root_ops, sd,=
 &resources);
>> + =A0 =A0 if (!bus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&resources);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(sd);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return bus;
>> =A0}
>> @@ -639,6 +641,7 @@ int pci_ext_cfg_avail(struct pci_dev *dev)
>>
>> =A0struct pci_bus * __devinit pci_scan_bus_on_node(int busno, struct=
 pci_ops *ops, int node)
>> =A0{
>> + =A0 =A0 struct list_head resources;
>> =A0 =A0 =A0 struct pci_bus *bus =3D NULL;
>> =A0 =A0 =A0 struct pci_sysdata *sd;
>>
>> @@ -653,9 +656,13 @@ struct pci_bus * __devinit pci_scan_bus_on_node=
(int busno, struct pci_ops *ops,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 sd->node =3D node;
>> - =A0 =A0 bus =3D pci_scan_bus(busno, ops, sd);
>> - =A0 =A0 if (!bus)
>> + =A0 =A0 INIT_LIST_HEAD(&resources);
>> + =A0 =A0 x86_pci_root_bus_resources(busno, &resources);
>> + =A0 =A0 bus =3D pci_scan_root_bus(NULL, busno, ops, sd, &resources=
);
>> + =A0 =A0 if (!bus) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&resources);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(sd);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 return bus;
>> =A0}
>>
>
>
> well, that will break
> arch/x86/pci/broadcom_bus.c
>
> it is using
>
> DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERV=
ERWORKS_LE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cnb20le_res);

Oooh, you're right!  Thanks for pointing that out.  I added another
patch to read the CNB20LE info early.  I'll see if I can get Ira to
test it.

Bjorn
