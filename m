From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v11 00/30] PCI: allocate pci bus num range for unassigned
 bridge busn
Date: Thu, 3 May 2012 02:08:29 -0700
Message-ID: <CAE9FiQWEdsB4YEs+oueyGm99Umi0p4jYaEDEnwsHi5mgYGXBJA@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
	<CAErSpo7RNLdP4sRfg_3NE78rbvKM5HyRrApmLSLJOA8ggX=VvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37125 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756616Ab2ECJIa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2012 05:08:30 -0400
In-Reply-To: <CAErSpo7RNLdP4sRfg_3NE78rbvKM5HyRrApmLSLJOA8ggX=VvQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wed, May 2, 2012 at 2:22 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
> On Sun, Mar 18, 2012 at 11:42 PM, Yinghai Lu <yinghai@kernel.org> wro=
te:
>> Set up iobusn_resource tree, and register bus number range to it.
>> Later when need to find bus range, will try to allocate from the tre=
e
>>
>> Need to test on arches other than x86. esp for ia64 and powerpc that=
 support
>> =A0more than on peer root buses.
>>
>> The patches need to apply to linux v3.3 + pci-next and
>> =A0 =A0 =A0 =A0[PATCH -v3] PCI: pci_host_bridge related cleanup
>>
>> could be found at:
>> =A0 =A0 =A0 =A0git://git.kernel.org/pub/scm/linux/kernel/git/yinghai=
/linux-yinghai.git for-pci-busn-alloc
>
> I started merging this series, but I didn't get very far. =A0I stoppe=
d
> at the "resources: Add probe_resource()" patch because I don't think
> that interface makes sense yet. =A0My work-in-progress is at
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git on the
> topic/yinghai-busn-alloc branch.
>
> I *could* merge that branch, but I don't think they fix anything (tha=
t
> would come in the later patches), and there are still some issues in
> my mind.
>
> =A0- I think we really want a [bus 00-ff] resource for each *domain*,
> with each host bridge in the domain requesting part of that range. =A0=
I
> think these patches only track bus number usage within each host
> bridge, and I'm not sure there's any place we would detect conflicts
> between host bridges.

I updated the patch set a bit. now it have domain busn_res.

It could detect the conflicts. later could add code to resolve the conf=
licts.

int pci_bus_insert_busn_res(struct pci_bus *b, int bus, int bus_max)
{
        struct resource *res =3D &b->busn_res;
        struct resource *parent_res;
        int ret;

        res->start =3D bus;
        res->end =3D bus_max;
        res->flags =3D IORESOURCE_BUS;

        if (!pci_is_root_bus(b))
                parent_res =3D &b->parent->busn_res;
        else {
                parent_res =3D get_pci_domain_busn_res(pci_domain_nr(b)=
);
                res->flags |=3D IORESOURCE_PCI_FIXED;
        }

        ret =3D insert_resource(parent_res, res);

        dev_printk(KERN_DEBUG, &b->dev,
                        "busn_res: %pR %s inserted under %s %pR\n",
                        res, ret ? "can not be" : "is",
                        pci_is_root_bus(b) ? "domain":"", parent_res);

        return ret;
}


>
> =A0- I think I made a mistake in the pci_create_root_bus() and
> pci_scan_root_bus() interfaces. =A0They currently take a bus number a=
nd
> a list of resources, and we expect the arch to include the bus number
> aperture in the list. =A0The bus number argument should have been
> replaced with a bus number aperture resource. =A0The bus number apert=
ure
> is essential, while the MMIO/IO aperture list may be empty. =A0And it=
's
> stupid to pass both the starting bus number and a bus resource that
> contains the starting bus number. =A0Fixing this would make some of
> these patches quite a bit simpler.

Yes, could try to address that later to make it more clean.

> =A0- In some of the arches (sparc, powerpc), you added a bus number
> resource right next to existing first_busno, last_busno fields. =A0So
> now that data lives two places, which will bite us later.

then later we should kill first_busno and last_busno in those arches.

Yinghai
