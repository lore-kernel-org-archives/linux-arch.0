From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 39/39] x86, PCI: kill busn in acpi pci_root_info
Date: Wed, 29 Feb 2012 16:32:30 -0700
Message-ID: <CAErSpo63hAtPMFdSEuVCcgw5ERMkiKx2Z8pREc2PdiCwmWpvkg@mail.gmail.com>
References: <1330556858-11768-1-git-send-email-yinghai@kernel.org> <1330556858-11768-40-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1330556858-11768-40-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Feb 29, 2012 at 4:07 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Bjorn thought that we should just use that in acpi_root.
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0arch/x86/pci/acpi.c | =A0 19 ++++++-------------
> =A01 files changed, 6 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
> index ff5243e..5178917 100644
> --- a/arch/x86/pci/acpi.c
> +++ b/arch/x86/pci/acpi.c
> @@ -12,7 +12,6 @@ struct pci_root_info {
> =A0 =A0 =A0 =A0char name[16];
> =A0 =A0 =A0 =A0unsigned int res_num;
> =A0 =A0 =A0 =A0struct resource *res;
> - =A0 =A0 =A0 struct resource busn;
> =A0 =A0 =A0 =A0struct pci_sysdata sd;
> =A0};
>
> @@ -283,9 +282,6 @@ static void add_resources(struct pci_root_info *i=
nfo,
> =A0 =A0 =A0 =A0int i;
> =A0 =A0 =A0 =A0struct resource *res, *root, *conflict;
>
> - =A0 =A0 =A0 if (info->busn.flags & IORESOURCE_BUS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(resources, &info->busn=
);
> -
> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_MEM);
> =A0 =A0 =A0 =A0coalesce_windows(info, IORESOURCE_IO);
>
> @@ -346,16 +342,12 @@ static void release_pci_root_info(struct pci_ho=
st_bridge *bridge)
>
> =A0static void
> =A0probe_pci_root_info(struct pci_root_info *info, struct acpi_device=
 *device,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int busnum, int busmax, int dom=
ain)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int busnum, int domain)
> =A0{
> =A0 =A0 =A0 =A0size_t size;
>
> =A0 =A0 =A0 =A0sprintf(info->name, "PCI Bus %04x:%02x", domain, busnu=
m);
> =A0 =A0 =A0 =A0info->bridge =3D device;
> - =A0 =A0 =A0 info->busn.name =3D info->name;
> - =A0 =A0 =A0 info->busn.start =3D busnum;
> - =A0 =A0 =A0 info->busn.end =3D busmax;
> - =A0 =A0 =A0 info->busn.flags =3D IORESOURCE_BUS;

You just *added* this stuff in a prior patch that hasn't been merged
yet.  Why can't you just fix that series rather than doing the
add/remove churn?

> =A0 =A0 =A0 =A0info->res_num =3D 0;
> =A0 =A0 =A0 =A0acpi_walk_resources(device->handle, METHOD_NAME__CRS, =
count_resource,
> @@ -379,7 +371,6 @@ struct pci_bus * __devinit pci_acpi_scan_root(str=
uct acpi_pci_root *root)
> =A0 =A0 =A0 =A0struct pci_root_info *info =3D NULL;
> =A0 =A0 =A0 =A0int domain =3D root->segment;
> =A0 =A0 =A0 =A0int busnum =3D root->secondary.start;
> - =A0 =A0 =A0 int busmax =3D root->secondary.end;
> =A0 =A0 =A0 =A0LIST_HEAD(resources);
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> =A0 =A0 =A0 =A0struct pci_sysdata *sd;
> @@ -432,15 +423,17 @@ struct pci_bus * __devinit pci_acpi_scan_root(s=
truct acpi_pci_root *root)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(bus->sysdata, sd, sizeof(*sd));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(info);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 probe_pci_root_info(info, device, busnu=
m, busmax, domain);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 probe_pci_root_info(info, device, busnu=
m, domain);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * _CRS with no apertures is normal, s=
o only fall back to
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * defaults or native bridge info if w=
e're ignoring _CRS.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_use_crs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_use_crs) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* insert busn res at f=
irst */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_add_resource(&resou=
rces, =A0&root->secondary);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0add_resources(info, &r=
esources);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_pci_root_info_res=
(info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x86_pci_root_bus_resou=
rces(busnum, &resources);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> --
> 1.7.7
>
