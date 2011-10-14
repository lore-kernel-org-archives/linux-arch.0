From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 06/29] x86/PCI: convert to pci_create_root_bus() and pci_scan_root_bus()
Date: Fri, 14 Oct 2011 14:54:46 -0600
Message-ID: <CAErSpo4629XKU=TNp0cb6Cxc+Jm_dQcD4244eTna2TC49_EtTw@mail.gmail.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com>
 <20111014042737.23504.46601.stgit@bhelgaas.mtv.corp.google.com>
 <4E97C8F0.7030108@oracle.com> <CAErSpo568q-KOk25RaaZ+=erLEEC4rsPwGNy0drCbqpCLKGybQ@mail.gmail.com>
 <4E989E07.6030404@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <4E989E07.6030404@oracle.com>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai.lu@oracle.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 14, 2011 at 2:39 PM, Yinghai Lu <yinghai.lu@oracle.com> wro=
te:
> On 10/14/2011 01:32 PM, Bjorn Helgaas wrote:
>
>
>>>> =A0 =A0 =A0 int node;
>>>> @@ -353,11 +349,18 @@ struct pci_bus * __devinit pci_acpi_scan_roo=
t(struct acpi_pci_root *root)
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(bus->sysdata, sd, sizeof(*sd));
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(sd);
>>>> =A0 =A0 =A0 } else {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_create_bus(NULL, busnum, &pc=
i_root_ops, sd);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 if (bus) {
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_current_resources(de=
vice, busnum, domain, bus);
>>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->subordinate =3D pci=
_scan_child_bus(bus);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 INIT_LIST_HEAD(&resources);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 get_current_resources(device, busnum, do=
main, &resources);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pci_use_crs) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&=
resources);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x86_pci_root_bus_resourc=
es(busnum, &resources);
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>
>>>
>>> You may need to update get_current_resources() to return status abo=
ut handling _CRS...
>>> and check that status insteaf of !pci_use_crs.
>>
>> Is the current patch broken here? =A0I don't think it will be simple=
r to
>> have get_current_resources() return a status and check that. =A0But =
if
>> something's actually broken, I want to fix it, of course.
>>
>
>
> yes. if for some reason, _CRS is not handled right, that root bus res=
ources will not get set to default res.
>
> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D get_current_resources(device, bu=
snum, domain, &resources);
> + =A0 =A0 =A0 =A0 =A0 =A0 if (status) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_free_resource_list(&res=
ources);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 x86_pci_root_bus_resources(=
busnum, &resources);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> get_current_resources() will not return 0 if _CRS is not really used.

OK.  I think it was that way before, too.  We created the bus with
default resources, but the first thing get_current_resources() did was
clear them all out.  If there was a problem parsing _CRS, we never
went back and put the defaults back in.

But I think this will do what you suggest and is nicer than what I had =
before:

                INIT_LIST_HEAD(&resources);
                get_current_resources(device, busnum, domain, &resource=
s);
                if (list_empty(&resources))
                        x86_pci_root_bus_resources(busnum, &resources);
