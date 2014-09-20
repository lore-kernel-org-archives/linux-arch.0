Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:50701 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbaITCVh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 19 Sep 2014 22:21:37 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 10/10] PCI: Introduce pci_remap_iospace() for remapping PCI I/O bus resources into CPU space
Date: Sat, 20 Sep 2014 04:20:31 +0200
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com> <1411003825-21521-11-git-send-email-Liviu.Dudau@arm.com> <20140919215400.GA30239@google.com>
In-Reply-To: <20140919215400.GA30239@google.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201409200420.31433.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Liviu Dudau <Liviu.Dudau@arm.com>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>
Message-ID: <20140920022031.NNTuNmhXrn_chu0m6z07t27x39jC_Y5VjRCuqP_fzBw@z>

On Friday 19 September 2014, Bjorn Helgaas wrote:
> On Thu, Sep 18, 2014 at 02:30:25AM +0100, Liviu Dudau wrote:

> PCI_IOBASE is a virtual address.  So PCI_IOBASE + res->start is also a
> virtual address (only for IORESOURCE_IO).
> 
> Since res->start is normally a *physical* address, I think it would be less
> confusing to do something like this:
> 
>     vaddr = PCI_IOBASE + res->start;
>     ioremap_page_range(vaddr, vaddr + resource_size(res), ...);
> 
> so we have a hint that the first two ioremap_page_range() parameters are
> virtual addresses.  It's also confusing that it uses "unsigned long" for
> the virtual addresses, when we usually use "void *".  But that's out of
> scope for this patch.

Good idea. I think it will have to be (unsigned long)PCI_IOBASE above then,
since ioremap_page_range takes a 'unsigned long' virtual address and PCI_IOBASE
should really remain an __iomem pointer.

	Arnd
