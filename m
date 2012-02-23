From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 09/24] PCI, powerpc: Register busn_res for root buses
Date: Thu, 23 Feb 2012 12:51:30 -0800
Message-ID: <CAErSpo7_WGjitDZz4XH+77f65Uz1ynd5_USN+D17D09Eux1iQQ@mail.gmail.com>
References: <1328425088-6562-1-git-send-email-yinghai@kernel.org>
 <1328425088-6562-10-git-send-email-yinghai@kernel.org> <CAErSpo6BwznWf3rq4J2Ao+rrgR4yWqQ0mQGygkd2KmBuA1OD8g@mail.gmail.com>
 <1328738567.2903.45.camel@pasglop> <CAErSpo7ekGn-+Mnyz7KL=fVFH3Ed19AeE3MKkZWJ4bd0Jo7kCw@mail.gmail.com>
 <1328823358.2903.77.camel@pasglop> <20120223122536.6a2a7a6b@jbarnes-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20120223122536.6a2a7a6b@jbarnes-desktop>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Yinghai Lu <yinghai@kernel.org>, Tony Luck <tony.luck@intel.com>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 23, 2012 at 12:25 PM, Jesse Barnes <jbarnes@virtuousgeek.or=
g> wrote:
> On Fri, 10 Feb 2012 08:35:58 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
>> On Thu, 2012-02-09 at 11:24 -0800, Bjorn Helgaas wrote:
>> > My point is that the interface between the arch and the PCI core
>> > should be simply the arch telling the core "this is the range of b=
us
>> > numbers you can use." =A0If the firmware doesn't give you the HW l=
imits,
>> > that's the arch's problem. =A0If you want to assume 0..255 are
>> > available, again, that's the arch's decision.
>> >
>> > But the answer to the question "what bus numbers are available to =
me"
>> > depends only on the host bridge HW configuration. =A0It does not d=
epend
>> > on what pci_scan_child_bus() found. =A0Therefore, I think we can c=
ome up
>> > with a design where pci_bus_update_busn_res_end() is unnecessary.
>>
>> In an ideal world yes. In a world where there are reverse engineered
>> platforms on which we aren't 100% sure how thing actually work under=
 the
>> hood and have the code just adapt on "what's there" (and try to fix =
it
>> up -sometimes-), thinks can get a bit murky :-)
>>
>> But yes, I see your point. As for what is the "correct" setting that
>> needs to be done so that the patch doesn't end up a regression for u=
s,
>> I'll have to dig into some ancient HW to dbl check a few things. I h=
ope
>> 0...255 will just work but I can't guarantee it.
>>
>> What I'll probably do is constraint the core to the values in
>> hose->min/max, and update selected platforms to put 0..255 in there =
when
>> I know for sure they can cope.
>
> But I think the point is, can't we intiialize the busn resource after
> the first & last bus numbers have been determined? =A0E.g. rather tha=
n
> Yinghai's current:
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->l=
ast_busno);
> +
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_con=
troller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL)
> + =A0 =A0 =A0 if (mode =3D=3D PCI_PROBE_NORMAL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, 255);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =
=3D pci_scan_child_bus(bus);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_bus_update_busn_res_end(bus, bus->s=
ubordinate);
> + =A0 =A0 =A0 }
>
> we'd have something more like:
>
> =A0 =A0 =A0 =A0/* Get probe mode and perform scan */
> =A0 =A0 =A0 =A0mode =3D PCI_PROBE_NORMAL;
> =A0 =A0 =A0 =A0if (node && ppc_md.pci_probe_mode)
> @@ -1742,8 +1744,11 @@ void __devinit pcibios_scan_phb(struct pci_con=
troller *hose)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_scan_bus(node, bus);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (mode =3D=3D PCI_PROBE_NORMAL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hose->last_busno =3D bus->subordinate =
=3D pci_scan_child_bus(bus);
>
> + =A0 =A0 =A0 pci_bus_insert_busn_res(bus, hose->first_busno, hose->l=
ast_busno);
>
> since we should have the final bus range by then? =A0Setting the end =
to
> 255 and then changing it again doesn't make sense; and definitely mak=
es
> the code hard to follow.

I have two issues here:

1) hose->last_busno is currently the highest bus number found by
pci_scan_child_bus().  If I understand correctly,
pci_bus_insert_busn_res() is supposed to update the core's idea of the
host bridge's bus number aperture.  (Actually, I guess it just updates
the *end* of the aperture, since we supply the start directly to
pci_scan_root_bus()).  The aperture and the highest bus number we
found are not related, except that we should have:

    hose->first_busno <=3D bus->subordinate <=3D hose->last_busno

If we set the aperture to [first_busno - last_busno], we artificially
prevent some hotplug.

2) We already have a way to add resources to a root bus: the
pci_add_resource() used to add I/O port and MMIO apertures.  I think
it'd be a lot simpler to just use that same interface for the bus
number aperture, e.g.,

    pci_add_resource(&resources, hose->io_space);
    pci_add_resource(&resources, hose->mem_space);
    pci_add_resource(&resources, hose->busnr_space);
    bus =3D pci_scan_root_bus(dev, next_busno, pci_ops, sysdata, &resou=
rces);

This is actually a bit redundant, since "next_busno" should be the
same as hose->busnr_space->start.  So if we adopted this approach, we
might want to eventually drop the "next_busno" argument.

 Bjorn
