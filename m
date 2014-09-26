From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v12 06/12] PCI: Create pci_host_bridge before its
 associated bus in pci_create_root_bus.
Date: Fri, 26 Sep 2014 15:58:54 +0100
Message-ID: <20140926145854.GS841@e106497-lin.cambridge.arm.com>
References: <1411498874-9864-1-git-send-email-Liviu.Dudau@arm.com>
 <1411498874-9864-7-git-send-email-Liviu.Dudau@arm.com>
 <CAE9FiQXuJZnj74dwTbKJCQNJ+OdEbjSB0fpwqh92+WZ_XGnrxQ@mail.gmail.com>
 <CAErSpo6eUEV81n1rFjjvRcFVmsFkeUxhdL6JauTmx_Et6XdBuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6eUEV81n1rFjjvRcFVmsFkeUxhdL6JauTmx_Et6XdBuQ@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 25, 2014 at 08:59:26PM +0100, Bjorn Helgaas wrote:
> On Thu, Sep 25, 2014 at 12:15 PM, Yinghai Lu <yinghai@kernel.org> wro=
te:
> > On Tue, Sep 23, 2014 at 12:01 PM, Liviu Dudau <Liviu.Dudau@arm.com>=
 wrote:
> >> Before commit 7b5436635800 the pci_host_bridge was created before =
the root bus.
> >> As that commit has added a needless dependency on the bus for pci_=
alloc_host_bridge()
> >> the creation order has been changed for no good reason. Revert the=
 order of
> >> creation as we are going to depend on the pci_host_bridge structur=
e to retrieve the
> >> domain number of the root bus.
> >>
> >> Cc: Bjorn Helgaas <bhelgaas@google.com>
> >> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> >> Acked-by: Grant Likely <grant.likely@linaro.org>
> >> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> >> Tested-by: Tanmay Inamdar <tinamdar@apm.com>
> >> ---
> >>  drivers/pci/probe.c | 32 +++++++++++++++++---------------
> >>  1 file changed, 17 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index e3cf8a2..5ff72ec 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -515,7 +515,7 @@ static void pci_release_host_bridge_dev(struct=
 device *dev)
> >>         kfree(bridge);
> >>  }
> >>
> >> -static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_b=
us *b)
> >> +static struct pci_host_bridge *pci_alloc_host_bridge(void)
> >>  {
> >>         struct pci_host_bridge *bridge;
> >>
> >> @@ -524,7 +524,8 @@ static struct pci_host_bridge *pci_alloc_host_=
bridge(struct pci_bus *b)
> >>                 return NULL;
> >>
> >>         INIT_LIST_HEAD(&bridge->windows);
> >> -       bridge->bus =3D b;
> >> +       bridge->dev.release =3D pci_release_host_bridge_dev;
> >> +
> >>         return bridge;
> >>  }
> >>
> >> @@ -1761,9 +1762,15 @@ struct pci_bus *pci_create_root_bus(struct =
device *parent, int bus,
> >>         char bus_addr[64];
> >>         char *fmt;
> >>
> >> +       bridge =3D pci_alloc_host_bridge();
> >> +       if (!bridge)
> >> +               return NULL;
> >> +
> >> +       bridge->dev.parent =3D parent;
> >> +
> >>         b =3D pci_alloc_bus();
> >>         if (!b)
> >> -               return NULL;
> >> +               goto err_out;
> >>
> >>         b->sysdata =3D sysdata;
> >>         b->ops =3D ops;
> >> @@ -1772,26 +1779,19 @@ struct pci_bus *pci_create_root_bus(struct=
 device *parent, int bus,
> >>         if (b2) {
> >>                 /* If we already got to this bus through a differe=
nt bridge, ignore it */
> >>                 dev_dbg(&b2->dev, "bus already known\n");
> >> -               goto err_out;
> >> +               goto err_bus_out;
> >>         }
> >>
> >> -       bridge =3D pci_alloc_host_bridge(b);
> >> -       if (!bridge)
> >> -               goto err_out;
> >> -
> >> -       bridge->dev.parent =3D parent;
> >> -       bridge->dev.release =3D pci_release_host_bridge_dev;
> >> +       bridge->bus =3D b;
> >>         dev_set_name(&bridge->dev, "pci%04x:%02x", pci_domain_nr(b=
), bus);
> >>         error =3D pcibios_root_bridge_prepare(bridge);
> >> -       if (error) {
> >> -               kfree(bridge);
> >> +       if (error)
> >>                 goto err_out;
> >> -       }
> >>
> >>         error =3D device_register(&bridge->dev);
> >>         if (error) {
> >>                 put_device(&bridge->dev);
> >> -               goto err_out;
> >> +               goto err_bus_out;
> >>         }
> >>         b->bridge =3D get_device(&bridge->dev);
> >>         device_enable_async_suspend(b->bridge);
> >> @@ -1848,8 +1848,10 @@ struct pci_bus *pci_create_root_bus(struct =
device *parent, int bus,
> >>  class_dev_reg_err:
> >>         put_device(&bridge->dev);
> >>         device_unregister(&bridge->dev);
> >> -err_out:
> >> +err_bus_out:
> >>         kfree(b);
> >> +err_out:
> >> +       kfree(bridge);
> >>         return NULL;
> >>  }
> >
> > Hi Bjorn,
> >
> > Noticed that you put this one into pci/next.
> >
> > This patch has problem for the class_dev_reg_err path.
> > as device_unregister(&bridge->dev) will trigger pci_release_host_br=
idge_dev.
> > So will have double free for bridge or else.
> >
> > Please drop this patch from pci/next.
> >
> > Also looks strange that the patch have long CC list, but just omit =
me
> > and Jiang Liu that
> > touched those code before.
>=20
> Thanks for noticing that.  I was concerned, but couldn't remember the=
 details.
>=20
> I dropped this patch and the subsequent ones from pci/host and rebase=
d
> my "next" branch.
>=20
> Sorry I didn't notice you weren't on the CC list.
>=20
> Bjorn
>=20

Bjorn,

I have refreshed/rebuilt the series from what was on 25th in linux-next=
 and I have
dropped this patch. I have pushed the series into=20

git://linux-arm.org/linux-ld.git for-upstream/pci-next

I hope that I've carried all your Sign-off-bys correctly, but I would l=
ike to ask you
to double check that I haven't screwed up things.

This patch dates from the times I was trying to add the domain number i=
nformation
into the pci_host_bridge structure. Now, with Catalin's patch that adds=
 the data in
the pci_bus structure, this is not needed, so it is safe to drop. I did=
 try to fix
the patch but I've realised how intricately linked pci_host_bridge and =
root bus are,
which to my opinion is a strong hint that the creation of the two shoul=
d be split
into separate functions.

I can send an official v13 patchset to the mailing list if you want, bu=
t if not, here
is the changelog:

- updated "[PATCH 01/12] asm-generic/io.h: Fix ioport_map() for !CONFIG=
_GENERIC_IOMAP" to match
  the patch that Thierry Reding has submitted through the asm-generic b=
ranch. If his
  series lands first upstream this patch will be skipped.
- updated "[PATCH 03/12] ARM: Define PCI_IOBASE as the base of virtual =
PCI IO space" to
  cast the PCI_IOBASE value to (void __iomem *) as is the case with mos=
t #defined versions
- dropped the patch that was changing the order of initialisation betwe=
en pci_host_bridge
  and root bus in pci_create_root_bus()
- fixed "[PATCH 07/12] PCI: Add generic domain handling" to account for=
 the previous patch
  being removed
- fixed the title of commit 08/12 to reflect the name of the functions =
that are actually
  added (s/of_pci_get_domain_nr/pci_get_new_domain_nr/)

I've compiled tested the series on sparc, microblaze (no)mmu_defconfig,=
 arm omap2plus_defconfig
and multi_v7_defconfig and arm64. I've also tested the series on my Jun=
o (arm64) board.

Sorry for causing this amount of churn! And to Yinghai Lu and Jiang Liu=
: appologies for not
including you in the Cc list, I'm still getting the grip on the whole s=
ubmission process.

Best regards,
Liviu

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF
