From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v9 12/12] PCI: Introduce pci_remap_iospace() for
 remapping PCI I/O bus resources into CPU space
Date: Wed, 13 Aug 2014 11:01:18 +0100
Message-ID: <20140813100118.GC18495@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
 <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:54658 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751118AbaHMKBq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Aug 2014 06:01:46 -0400
Content-Disposition: inline
In-Reply-To: <1407860725-25202-13-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Will Deacon <Will.Deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Russell King <linux@arm.linux.org.uk>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-pci <linux-pci@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>

On Tue, Aug 12, 2014 at 05:25:25PM +0100, Liviu Dudau wrote:
> Introduce a default implementation for remapping PCI bus I/O resources
> onto the CPU address space. Architectures with special needs may
> provide their own version, but most should be able to use this one.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>

I guess you could have added the generic pgprot_device definition to
this patch and the arm64 specific one in the separate arm64 PCIe support
(and one less patch in total). But not a big issue either way.

-- 
Catalin
