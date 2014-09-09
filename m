From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v10 07/10] OF: Introduce helper function for getting PCI domain_nr
Date: Tue, 09 Sep 2014 11:16:04 +0200
Message-ID: <3780051.0eHpCN6UC9@wuerfel>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com> <540E960D.7080408@huawei.com> <20140909084621.GS27864@e106497-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140909084621.GS27864-2JSQmVVBSi7ZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 09 September 2014 09:46:21 Liviu Dudau wrote:
> On Tue, Sep 09, 2014 at 06:54:21AM +0100, Yijing Wang wrote:
> > >>> on new requests. This function gets called quite a lot and I'm trying not to
> > >>> make it too heavy weight.
> > >>
> > >> Generally, nothing should be accessing the same DT value frequently.
> > >> It should get cached somewhere.
> > >>
> > > 
> > > The problem appears for DTs that don't have the pci-domain info. Then the cached
> > > value is left at the default non-valid value and attempts to rescan the DT will
> > > be made every time the function is called.
> > > 
> > >> I don't really understand how domains are used so it's hard to provide
> > >> a recommendation here. Do domains even belong in the DT?
> > > 
> > > ACPI calls them segments and the way Bjorn explained it to me at some moment was
> > > that it was an attempt to split up a bus in different groups (or alternatively,
> > > merge a few busses together). To be honest I haven't seen systems where the domain
> > > is anything other than zero, but JasonG (or maybe Benjamin) were floating an
> > > idea of using the domain number to identify physical slots.
> > 
> > PCI domain(or named segment) is provided by firmware, in ACPI system, we evaluated it
> > by method "_SEG". in IA64 with ACPI, PCI hostbridge driver retrieves the domain from ACPI,
> > if it's absent, the default domain is zero. So I wonder why in DTS, if it's absent, we get
> > a auto increment domain value.
> 
> Because you can have more than one hostbridge (rare, but not impossible) and unless you
> want to join the two segments, you might want to give it a different domain.

I think you misunderstood the question. The difference is that in ACPI you
are required to specify the domain, while in DT it is optional with your
implementation.

I think in general it would be nice if we could mandate that in DT you also
have to always provide a domain number, however the problem is that we can't
change the existing DTB files that people are using that do not specify a
domain.

We could possibly make this an architecture specific setting though and
mandate that all ARM64 platforms have to set it, while ARM32 does not need
it.

	Arnd

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
