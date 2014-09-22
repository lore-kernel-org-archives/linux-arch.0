From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Mon, 22 Sep 2014 12:05:22 +0100
Message-ID: <20140922110522.GK1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <20140919210313.GH19374@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20140919210313.GH19374@google.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 19, 2014 at 10:03:13PM +0100, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> > of a given device from DT. If the information is not present,
> > the function can be requested to allocate a new domain number.
>=20
> Is of_pci_get_domain_nr() used somewhere?  If the use is in some futu=
re
> series, please mention it explicitly.  I'm just trying to avoid mergi=
ng
> unused code.

It is used in the arm64 specific patch that I have dropped out of my
pull request. After discussions with Catalin I will add the patch back
into the tree that you've pulled from as he is OK with your tree carryi=
ng
the whole package.

I need to ask for some guidance here: for addressing some of your comme=
nts
and Rob's I can add more patches in my v11 branch and you can pull them
when you think they are ready. But one of your comments was requesting
splitting a patch into two blocks - one that moves of_pci_range_to_reso=
urce()
into drivers/of/address.c and one that fixes it's behaviour - and I don=
't
know how you would like that handled. Should I revert the original patc=
h
and add the new ones, or should I rebase the whole series into a differ=
ent
branch that you can pull from?

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
