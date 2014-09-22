From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v11 07/10] OF: Introduce helper function for getting PCI
 domain_nr
Date: Mon, 22 Sep 2014 16:33:12 +0100
Message-ID: <20140922153311.GB1994@e106497-lin.cambridge.arm.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-8-git-send-email-Liviu.Dudau@arm.com>
 <20140919210313.GH19374@google.com>
 <20140922110522.GK1994@e106497-lin.cambridge.arm.com>
 <CAErSpo7bnOFo4-uZmVsMqNpVQS+dQaMNedjmJ=sH_d9Kp2fGPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo7bnOFo4-uZmVsMqNpVQS+dQaMNedjmJ=sH_d9Kp2fGPg@mail.gmail.com>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 22, 2014 at 04:25:13PM +0100, Bjorn Helgaas wrote:
> On Mon, Sep 22, 2014 at 5:05 AM, Liviu Dudau <Liviu.Dudau@arm.com> wr=
ote:
> > On Fri, Sep 19, 2014 at 10:03:13PM +0100, Bjorn Helgaas wrote:
> >> On Thu, Sep 18, 2014 at 02:30:22AM +0100, Liviu Dudau wrote:
> >> > Add of_pci_get_domain_nr() to retrieve the PCI domain number
> >> > of a given device from DT. If the information is not present,
> >> > the function can be requested to allocate a new domain number.
> >>
> >> Is of_pci_get_domain_nr() used somewhere?  If the use is in some f=
uture
> >> series, please mention it explicitly.  I'm just trying to avoid me=
rging
> >> unused code.
> >
> > It is used in the arm64 specific patch that I have dropped out of m=
y
> > pull request. After discussions with Catalin I will add the patch b=
ack
> > into the tree that you've pulled from as he is OK with your tree ca=
rrying
> > the whole package.
> >
> > I need to ask for some guidance here: for addressing some of your c=
omments
> > and Rob's I can add more patches in my v11 branch and you can pull =
them
> > when you think they are ready. But one of your comments was request=
ing
> > splitting a patch into two blocks - one that moves of_pci_range_to_=
resource()
> > into drivers/of/address.c and one that fixes it's behaviour - and I=
 don't
> > know how you would like that handled. Should I revert the original =
patch
> > and add the new ones, or should I rebase the whole series into a di=
fferent
> > branch that you can pull from?
>=20
> I guess the easiest thing is probably just to send a v12 series.  I
> was hoping we were close enough for me to just hand-integrate minor
> tweaks into my branch, but I think that will just create more
> confusion.

OK, I will send v12 then with all the acquired ACKs and fixes.

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
