From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 39/39] x86, PCI: kill busn in acpi pci_root_info
Date: Wed, 29 Feb 2012 15:37:53 -0800
Message-ID: <CAE9FiQUeRno4ZCy37XQ+cwrFYG-XoDq7q=XjKrOVy5E85bS-ig@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org>
	<1330556858-11768-40-git-send-email-yinghai@kernel.org>
	<CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 29, 2012 at 3:32 PM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> Bjorn thought that we should just use that in acpi_root.
>>
>> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>> =A0arch/x86/pci/acpi.c | =A0 19 ++++++-------------
>> =A01 files changed, 6 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
>> index ff5243e..5178917 100644
>> --- a/arch/x86/pci/acpi.c
>> +++ b/arch/x86/pci/acpi.c
>> @@ -12,7 +12,6 @@ struct pci_root_info {
>> =A0 =A0 =A0 =A0char name[16];
>> =A0 =A0 =A0 =A0unsigned int res_num;
>> =A0 =A0 =A0 =A0struct resource *res;
>> - =A0 =A0 =A0 struct resource busn;
>> =A0 =A0 =A0 =A0struct pci_sysdata sd;
>> =A0};
>>
>> @@ -283,9 +282,6 @@ static void add_resources(struct pci_root_info *=
info,
>> =A0 =A0 =A0 =A0int i;
>> =A0 =A0 =A0 =A0struct resource *res, *root, *conflict;
>>
>> - =A0 =A0 =A0 if (info->busn.flags & IORESOURCE_BUS)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(resources, &info->bus=
n);
>> -
>> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_MEM);
>> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_IO);
>>
>> @@ -346,16 +342,12 @@ static void release_pci_root_info(struct pci_h=
ost_bridge *bridge)
>>
>> =A0static void
>> =A0probe_pci_root_info(struct pci_root_info *info, struct acpi_devic=
e *device,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int busnum, int busmax, int do=
main)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int busnum, int domain)
>> =A0{
>> =A0 =A0 =A0 =A0size_t size;
>>
>> =A0 =A0 =A0 =A0sprintf(info->name, "PCI Bus %04x:%02x", domain, busn=
um);
>> =A0 =A0 =A0 =A0info->bridge =3D device;
>> - =A0 =A0 =A0 info->busn.name =3D info->name;
>> - =A0 =A0 =A0 info->busn.start =3D busnum;
>> - =A0 =A0 =A0 info->busn.end =3D busmax;
>> - =A0 =A0 =A0 info->busn.flags =3D IORESOURCE_BUS;
>
> You just *added* this stuff in a prior patch that hasn't been merged
> yet. =A0Why can't you just fix that series rather than doing the
> add/remove churn?

as i said before, I'm not quite sure about the life cycle about that ob=
ject.

still need to wait some months to verify that on system that does
support pci root bus hot plug etc.

or we can just this patch for now.

Yinghai
