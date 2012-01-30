From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 02/13] PCI: Add busn_res operation functions
Date: Mon, 30 Jan 2012 10:32:09 -0800
Message-ID: <CAE9FiQVDaA-aO6tFq0gmmDZRydUF6oLrAsARQWH6OOAEqFhRbQ@mail.gmail.com>
References: <1327718971-9598-1-git-send-email-yinghai@kernel.org>
	<1327718971-9598-3-git-send-email-yinghai@kernel.org>
	<CAErSpo7ji9R3azc7Xiu8K-=QXm26w=0oSWmcBh=j8dy=MttEvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo7ji9R3azc7Xiu8K-=QXm26w=0oSWmcBh=j8dy=MttEvg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2012 at 7:28 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Jan 27, 2012 at 6:49 PM, Yinghai Lu <yinghai@kernel.org> wrot=
e:
>> will use them insert/update busn res in pci_bus
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>> ---
>> =A0drivers/pci/probe.c | =A0 44 ++++++++++++++++++++++++++++++++++++=
++++++++
>> =A0include/linux/pci.h | =A0 =A03 +++
>> =A02 files changed, 47 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index a114173..71261da 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1622,6 +1622,50 @@ err_out:
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
>> + =A0 =A0 =A0 res->start =3D (pci_domain_nr(b) << 8) | bus;
>> + =A0 =A0 =A0 res->end =3D (pci_domain_nr(b) << 8) | bus_max;
>> + =A0 =A0 =A0 res->flags =3D IORESOURCE_BUS;
>> +
>> + =A0 =A0 =A0 if (!pci_is_root_bus(b))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_res =3D &b->parent->busn_res;
>> +
>> + =A0 =A0 =A0 ret =3D insert_resource(parent_res, res);
>> +
>> + =A0 =A0 =A0 dev_printk(KERN_DEBUG, &b->dev,
>> + =A0 =A0 =A0 =A0"busn_res: %06llx-%06llx %s inserted under %06llx-%=
06llx\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)re=
s->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)re=
s->end,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret ? "can not be" =
: "is",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)pa=
rent_res->start,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)pa=
rent_res->end);
>
> Please update the %pR implementation so you can use it instead of
> having to fiddle around with start/end separately and casts.

ok, will check that. to make it support extra domain number there.

>
>> +}
>> +
>> +void pci_bus_update_busn_res_end(struct pci_bus *b, int bus_max)
>> +{
>> + =A0 =A0 =A0 struct resource *res =3D &b->busn_res;
>> + =A0 =A0 =A0 unsigned long long old_end =3D res->end;
>> +
>> + =A0 =A0 =A0 res->end &=3D ~0xff;
>> + =A0 =A0 =A0 res->end |=3D bus_max;
>
> This updates a resource in place, without removing it from the
> resource tree and re-inserting it. =A0Doesn't this make it possible t=
o
> corrupt the resource tree? =A0For example, let's say you have this tr=
ee:
>
> =A0 =A000-3f : host bridge A
> =A0 =A0 =A000-1f : P2P bridge B
> =A0 =A040-7f : host bridge C
>
> Now you use pci_bus_update_busn_res_end() to update the resource for
> P2P bridge B, =A0setting its end to 5f. =A0I think the resource tree =
is
> now corrupted.

for expanding, We will make sure expanded range is safe and verified.

another use case is for unknown peer root buses that can not tell end
before scanning,
will assume we are handing those kind of peer root bus for low to high.

Yinghai
