From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 04/24] PCI: Add busn_res operation functions
Date: Mon, 6 Feb 2012 12:45:15 -0800
Message-ID: <CAE9FiQXrFARy4+ynOTRyEuoyRxTc9qqzUaYJH8e19Wt3JRRxug@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
	<1328425088-6562-5-git-send-email-yinghai@kernel.org>
	<CAErSpo6=t1XtdUMBAn7Ag5XNLS3wKueybfrsUzmht6GL9XSGLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61563 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755314Ab2BFUpQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2012 15:45:16 -0500
In-Reply-To: <CAErSpo6=t1XtdUMBAn7Ag5XNLS3wKueybfrsUzmht6GL9XSGLQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, Feb 6, 2012 at 10:59 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Sat, Feb 4, 2012 at 10:57 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> will use them insert/update busn res in pci_bus
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>> =A0drivers/pci/probe.c | =A0 42 ++++++++++++++++++++++++++++++++++++=
++++++
>> =A0include/linux/pci.h | =A0 =A03 +++
>> =A02 files changed, 45 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index a114173..8d4de5e 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1622,6 +1622,48 @@ err_out:
>> =A0 =A0 =A0 =A0return NULL;
>> =A0}
>>
>> +void pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_ma=
x)
>> +{
>> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
>> + =A0 =A0 =A0 struct resource *parent_res =3D &iobusn_resource;
>> + =A0 =A0 =A0 int ret;
>> +
>> + =A0 =A0 =A0 res->start =3D busn(pci_domain_nr(b), bus);
>> + =A0 =A0 =A0 res->end =3D busn(pci_domain_nr(b), bus_max);
>> + =A0 =A0 =A0 res->flags =3D IORESOURCE_BUS;
>> +
>> + =A0 =A0 =A0 if (!pci_is_root_bus(b))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D &b->parent->busn_res;
>> +
>> + =A0 =A0 =A0 ret =3D insert_resource(parent_res, res);
>> +
>> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "busn_res: %pR %s inse=
rted under %pR\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 res, ret ? "can not be=
" : "is", parent_res);
>> +}
>> +
>> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
>> +{
>> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
>> + =A0 =A0 =A0 struct resource old_res =3D *res;
>> +
>> + =A0 =A0 =A0 res->end =3D busn_update_bus_nr(res->end, bus_max);
>
> I think this design is a mistake. =A0Here's what you're doing:
>
> =A0- initialize struct resource (keys are "start" and "end")
> =A0- insert into tree (placed in tree by kernel/resource.c based on
> "start" and "end")
> =A0- update "end"
>
> You "know" in this case that the update is safe because the caller ha=
s
> validated "bus_max." =A0But that still breaks the kernel/resource.c
> encapsulation. =A0If we change the kernel/resource.c implementation,
> this code might break.

the point is: I only want to reuse allocate_resource() to get right pos=
ition.
and the code does not depends to kernel/resource.c much.

>
> I think it would be better to remove the bus resource from the tree,
> change its "end," then re-insert it.

how about parent buses that have extended top?

Yinghai
