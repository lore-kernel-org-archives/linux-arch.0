From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v13 10/12] PCI: Assign unassigned bus resources in
 pci_scan_root_bus()
Date: Tue, 30 Sep 2014 09:54:07 +0100
Message-ID: <20140930085407.GL841@e106497-lin.cambridge.arm.com>
References: <1412000971-9242-1-git-send-email-Liviu.Dudau@arm.com>
 <1412000971-9242-11-git-send-email-Liviu.Dudau@arm.com>
 <CAE9FiQXEUZvkuzwOrK+2zGVj0ywFaQsiWH7SHufZk9BRWnwddQ@mail.gmail.com>
 <CAE9FiQUkcPRMUEn01VJMyXz8aYvk6C5MBNZi5NCV2m3qkNabeg@mail.gmail.com>
 <1412024521.4285.98.camel@pasglop>
 <CAErSpo62ap1YkzvuZ6MCpXry9=VpLv+Skzrwr10h=+Lc4VfVgQ@mail.gmail.com>
 <1412029912.4285.110.camel@pasglop>
 <CAErSpo70t9TMdntjBt+GdTw3FVmMquACQePX8=SKkySPuG3F3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo70t9TMdntjBt+GdTw3FVmMquACQePX8=SKkySPuG3F3Q@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Yinghai Lu <yinghai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 30, 2014 at 12:08:49AM +0100, Bjorn Helgaas wrote:
> On Mon, Sep 29, 2014 at 4:31 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> > On Mon, 2014-09-29 at 15:33 -0600, Bjorn Helgaas wrote:
> >> > Right and on powerpc and others as well. We need to survey exist=
ing
> >> > resources. We also have a number of platform things that might n=
eed
> >> > to happen before we do the final re-assignment pass.
> >>
> >> That's true today.  But I don't know whether it *has* to be this w=
ay
> >> forever.  On x86, pcibios_resource_survey() throws in E820 informa=
tion
> >> (which we know long before we do any PCI enumeration) and some IO-=
APIC
> >> resources (it looks like we also know these before PCI enumeration=
).
> >> Powerpc has pcibios_reserve_legacy_regions(), but that looks like
> >> mostly stuff that could be done when we find the host bridge, befo=
re
> >> we enumerate PCI devices below it.
> >
> > Oh we can probably change that but it's going to be much more work =
than
> > just moving the assignment into pci_scan_root_bus().
>=20
> Agreed.  It's obvious that we can't apply Liviu's patch as-is.

Thanks everyone for the feedback!

Bjorn, you can drop this patch from the series if you want to add it to
your tree, and the host bridge drivers will have to reimplement pci_sca=
n_root_bus()
for now (most do it already as they need to add msi information as well=
).

Benjamin, I still have on my ToDo list to convert powerpc. I might not =
be
able to do it successfully on my own (as I don't understand a lot of th=
e
corner cases) but Bjorn is correct here in that pcibios_reserve_legacy_=
regions()
will move out of the scanning of the root bus.

>=20
> > There are also a
> > number of subtle and not-so-subtle bits of code that rely on side
> > effects of the current code such as anything that tests for bus->ad=
ded
> > or dev->added. Again, nothing we can't sort out eventually but the
> > transition might be a bit painful.
> >
> > We might need to introduce a new flag for platforms converted to th=
e
> > "new style" generalized resource assignment which we can deprecate =
once
> > everybody has moved over.
>=20
> There's definitely a lot of work here if we ever want to make this ha=
ppen.

I know :)

Best regards,
Liviu

>=20
> Bjorn
>=20

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
