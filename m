From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 09/13] PCI: Probe safe range that we can use for
 unassigned bridge.
Date: Mon, 30 Jan 2012 07:59:57 -0800
Message-ID: <CAErSpo5QYvx6dtL4NqW4Pu29HXbS-kcTq-GKvpJO8AJ6vRYeBw@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org> <1327718971-9598-10-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36549 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab2A3QAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2012 11:00:19 -0500
Received: by wgbed3 with SMTP id ed3so4801840wgb.1
        for <linux-arch@vger.kernel.org>; Mon, 30 Jan 2012 08:00:18 -0800 (PST)
In-Reply-To: <1327718971-9598-10-git-send-email-yinghai@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> Try to allocate from parent bus busn_res. if can not find any big eno=
ugh, will try
> to extend parent bus top. even the extending is through allocating, a=
fter allocating
> will pad the range to parent buses top.
>
> When extending happens, We will record the parent_res, so could use i=
t as stopper
> for really extend/shrink top later.
>
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> ---
> =A0drivers/pci/probe.c | =A0117 +++++++++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 117 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3e62f45..83df3fb 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -674,6 +674,123 @@ static void __devinit pci_bus_shrink_top(struct=
 pci_bus *parent,
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static resource_size_t __devinit find_res_top_free_size(struct resou=
rce *res)

I think what this does is "find the largest available area in 'res'."
That *sounds* sort of useful (and like something that could go
somewhere more generic than drivers/pci/probe.c), but there's no
locking, so we don't have any assurance that the area we find will
*remain* available.

Since the caller should deal with failure anyway (if the largest
available area is no longer available by the time it gets around to
allocating it), it seems like it'd be better to fold this into the
caller somehow.

> +{
> + =A0 =A0 =A0 int ret =3D -ENOMEM;
> + =A0 =A0 =A0 resource_size_t n_size;
> + =A0 =A0 =A0 struct resource tmp_res;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* =A0 find out number below res->end, that we can us=
e at first
> + =A0 =A0 =A0 =A0* =A0 =A0 =A0res->start can not be used.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 n_size =3D resource_size(res) - 1;
> + =A0 =A0 =A0 memset(&tmp_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 while (n_size > 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D allocate_resource(res, &tmp_res=
, n_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res->end - n_size + 1, =
res->end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, NULL, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* release busn_res */

Comments like this that repeat exactly what the next line of code does
without adding any useful information are unnecessary and distracting.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(&tmp_r=
es);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return n_size;
> +}
> +
> +static int __devinit pci_bridge_probe_busn_res(struct pci_bus *bus,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_dev *dev,=
 struct resource *busn_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0resource_size_t need=
ed_size, struct resource **p)
> +{
> + =A0 =A0 =A0 int ret =3D -ENOMEM;
> + =A0 =A0 =A0 resource_size_t n_size;
> + =A0 =A0 =A0 struct pci_bus *parent;
> + =A0 =A0 =A0 struct resource *parent_res;
> + =A0 =A0 =A0 resource_size_t tmp =3D bus->busn_res.end + 1;
> + =A0 =A0 =A0 int free_sz =3D -1;
> +
> + =A0 =A0 =A0 parent_res =3D NULL;
> +
> +again:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* find bigest range in bus->busn_res that we can use=
 in the middle
> + =A0 =A0 =A0 =A0* =A0and we can not use bus->busn_res.start.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 n_size =3D resource_size(&bus->busn_res) - 1;
> + =A0 =A0 =A0 memset(busn_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "find free busn in busn=
_res: %06llx-%06llx\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)bus=
->busn_res.start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)bus=
->busn_res.end);
> + =A0 =A0 =A0 while (n_size >=3D needed_size) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D allocate_resource(&bus->busn_re=
s, busn_res, n_size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus->bu=
sn_res.start + 1, bus->busn_res.end,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, NULL=
, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* release res */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 release_resource(busn_r=
es);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 n_size--;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* try extend the top of parent buss */
> + =A0 =A0 =A0 if (free_sz < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_sz =3D find_res_top_free_size(&bus=
->busn_res);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_printk(KERN_DEBUG, &dev->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "found free busn %d in =
busn_res: %06llx-%06llx top\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_sz=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)bus->busn_res.start,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsign=
ed long long)bus->busn_res.end);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 n_size =3D free_sz;
> +
> + =A0 =A0 =A0 /* check if extend could cross domain boundary */
> + =A0 =A0 =A0 if ((bus->busn_res.end & 0xff) =3D=3D 0xff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto reduce_needed_size;
> + =A0 =A0 =A0 if ((0x100 - (tmp & 0xff)) < (needed_size - n_size))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto reduce_needed_size;
> +
> + =A0 =A0 =A0 /* find exteded range */
> + =A0 =A0 =A0 memset(busn_res, 0, sizeof(struct resource));
> + =A0 =A0 =A0 parent =3D bus->parent;
> + =A0 =A0 =A0 while (parent) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D allocate_resource(&parent->busn=
_res, busn_res,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0needed_size - n_size=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp, tmp + needed_si=
ze - n_size - 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01, NULL, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent =3D parent->parent;
> + =A0 =A0 =A0 }
> +
> +reduce_needed_size:
> + =A0 =A0 =A0 if (ret !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 needed_size--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!needed_size)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto again;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* save parent_res, we need it as stopper later */
> + =A0 =A0 =A0 parent_res =3D busn_res->parent;
> + =A0 =A0 =A0 /* release busn_res */
> + =A0 =A0 =A0 release_resource(busn_res);
> + =A0 =A0 =A0 busn_res->start -=3D n_size;
> +
> + =A0 =A0 =A0 /* extend parent bus top*/
> + =A0 =A0 =A0 pci_bus_extend_top(bus, needed_size - n_size, parent_re=
s);
> +
> + =A0 =A0 =A0 *p =3D parent_res;
> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> =A0/*
> =A0* If it's a bridge, configure it and scan the bus behind it.
> =A0* For CardBus bridges, we don't scan behind as the devices will
> --
> 1.7.7
>
