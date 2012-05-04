From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v11 00/30] PCI: allocate pci bus num range for unassigned
 bridge busn
Date: Fri, 4 May 2012 13:07:35 -0700
Message-ID: <CAE9FiQU7s2Qt1VEASsaMOXWm+1_Hv=LDaOLeECTUwTPjKHiAZw@mail.gmail.com>
References: <1332135781-13695-1-git-send-email-yinghai@kernel.org>
	<CAErSpo7RNLdP4sRfg_3NE78rbvKM5HyRrApmLSLJOA8ggX=VvQ@mail.gmail.com>
	<CAE9FiQWEdsB4YEs+oueyGm99Umi0p4jYaEDEnwsHi5mgYGXBJA@mail.gmail.com>
	<CAErSpo6Mtt2E=3Uc5CO9oxqsVL-EALAsWq5wv-wT8ei6ZXrX3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6Mtt2E=3Uc5CO9oxqsVL-EALAsWq5wv-wT8ei6ZXrX3w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tony Luck <tony.luck@intel.com>, David Miller <davem@davemloft.net>, x86 <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, May 3, 2012 at 4:47 PM, Bjorn Helgaas <bhelgaas@google.com> wro=
te:
>
>> It could detect the conflicts. later could add code to resolve the c=
onflicts.
>
> This is in "Add busn_res operation functions". =A0I think this makes
> sense, too. =A0If you look at the branch I started merging
> (topic/yinghai-busn-alloc), I tweaked it to print the conflicting
> resource when the insertion fails. =A0That information is almost alwa=
ys
> useful when debugging, so it'd be nice if you picked that up, too.

ok, will check that branch and put that change in.

>
>>> =A0- In some of the arches (sparc, powerpc), you added a bus number
>>> resource right next to existing first_busno, last_busno fields. =A0=
So
>>> now that data lives two places, which will bite us later.
>>
>> then later we should kill first_busno and last_busno in those arches=
=2E
>
> I want to be sensitive to the arch maintainers by doing our homework,
> minimizing the number of patches we ask them to review, and grouping
> related changes all at one time. =A0I propose the following, using
> powerpc as an example:
>
> =A0- Add "struct resource busn_res" to struct pci_bus.
> =A0- powerpc: Replace pci_controller.first_busno/last_busno by "struc=
t
> resource busno" everywhere. =A0This will touch many places, but shoul=
d
> be completely mechanical and obvious.
> =A0- powerpc: Replace all pci_bus.secondary/subordinate references wi=
th
> busn_res. =A0This also be only obvious changes.
> =A0- powerpc: Add the pci_add_resource() and pci_bus_update_busn_res_=
end() calls.
> =A0- powerpc: Add pci_bus_insert_busn_res() call in
> of_scan_pci_bridge(). =A0(This is currently buried in the "Remove
> secondary/subordinate in pci_bus" patch, but it doesn't fit there.)
> =A0- Replace all non-arch pci_bus.secondary/subordinate references wi=
th
> busn_res. =A0Obvious changes only.
> =A0- Remove secondary/subordinate from struct pci_bus.
> =A0- Add pci_bus_insert_busn_res() calls. =A0Again, this is logically
> separate from "Remove secondary/subordinate in pci_bus".
>
> I would split up the "Remove secondary/subordinate in pci_bus" patch,
> which currently touches 30 files across 11 arches, so an arch
> maintainer doesn't have to read the whole patch.

could split that a little. not sure if it is worth it.

1. core update subordinate and busn_res.end at same time.
2. update subordinate and busn_res.end at same time
2. remove using secondary/subordinate in arch
3. remove using secondary/suborindate in core

>
> Ben, Dave, feel free to chime in if I'm going astray.
>
> I did a fair amount of work updating changelogs and tweaking the code
> in my topic/yinghai-busn-alloc branch. =A0I know I'm currently a
> bottleneck here, and it's worse because I'm a bit obsessive. =A0It wo=
uld
> save me time if you picked up those tweaks so I don't have to re-do
> them.

ok, will pick them up.

>
> You have over 100 patches outstanding, and I'm having a hard time
> making forward progress. =A0I think we need to focus on just replacin=
g
> secondary/subordinate with busn_res, doing the corresponding
> arch-specific replacements, and adding the insert_resource() stuff to
> build the resource trees for bus numbers. =A0I'm not going to merge t=
he
> probe_resource() stuff, so let's defer that and the resource
> assignment stuff for later. =A0Also defer the unrelated
> pci_hp_add_bridge() stuff that crept into your for-pci-busn-alloc
> branch. =A0If you defer all that stuff and split out the arch stuff,
> that should leave us with around 30 patches that deal *only* with
> adding busn_res and building the resource trees. =A0I don't think thi=
s
> will fix any bugs or add any new functionality, but at least it's a
> manageable step towards getting the infrastructure in place, so it's
> reasonable to consider merging it.

let me check if i change to that order.

>
> These patches need to appear on the mailing list. =A0In general, peop=
le
> aren't going to pull your git tree and review them as I've been doing=
=2E
> =A0But *only* post the stuff mentioned above (busn_res and related
> things). =A0I'm not ready to consider the rest yet, so they would onl=
y
> confuse things.

ok.

Yinghai
