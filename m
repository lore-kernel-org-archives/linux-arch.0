From: Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Date: Tue, 23 Sep 2014 08:30:08 -0500
Message-ID: <CAL_JsqK3yH-uf++haBovWdX6er1PtzeiZ-2-yT1TRfYPxAjFow@mail.gmail.com>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <20140922093228.GA20256@rric.localhost> <20140922114317.GN1994@e106497-lin.cambridge.arm.com>
 <8687285.EH4RPBeOB5@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8687285.EH4RPBeOB5@wuerfel>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>, Robert Richter <rric-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Sunil Goutham <sunil.goutham@caviu>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 23, 2014 at 2:56 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Monday 22 September 2014 12:43:17 Liviu Dudau wrote:
>> >
>> > From e798af4fc2f664d1aff7e863489b8298f90e716e Mon Sep 17 00:00:00 2001
>> > From: Robert Richter <rrichter-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
>> > Date: Mon, 22 Sep 2014 10:46:01 +0200
>> > Subject: [PATCH] OF: PCI: Fix creation of mem-mapped pci host bridges
>> >
>> > The pci host bridge was not created if io_base was not set when
>> > calling of_pci_get_host_bridge_resources(). This is esp. the case for
>> > mem-mapped io (IORESOURCE_MEM). This patch fixes this. Function
>> > parameter io_base is optional now.
>>
>> I think the message is misleading. What you want to do is make io_base
>> optional for the case where the PCI host bridge only expects to have only
>> IORESOURCE_MEM ranges and doesn't care about IORESOURCE_IO ones.
>>
>> As I'm going to touch this area again to address a comment from Bjorn,
>> do you mind if I roll this patch into mine with your Signed-off-by and
>> the mention that you have made io_base optional?
>
> I think the best way to deal with this is to move the check for
> io_base down into the place where it is used: As long as the DT only
> specifies IORESOURCE_MEM windows, we don't need to look at io_base,
> but if the host controller driver does not support IORESOURCE_IO
> while the DT specifies it, I guess it would be nice to return an
> error.

The DT may specify it, but the h/w could be broken in some way so the
host driver chooses to ignore it. I don't think we should force the
host driver to provide a pointer in that case. Also, would we want it
added to the resource list if it is not going to be used?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
