Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:57573 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbaIVJcd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Sep 2014 05:32:33 -0400
Date: Mon, 22 Sep 2014 11:32:28 +0200
From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v11 08/10] OF: PCI: Add support for parsing PCI host
 bridge resources from DT
Message-ID: <20140922093228.GA20256@rric.localhost>
References: <1411003825-21521-1-git-send-email-Liviu.Dudau@arm.com>
 <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1411003825-21521-9-git-send-email-Liviu.Dudau@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>, Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, linux-pci <linux-pci@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tanmay Inamdar <tinamdar@apm.com>, Grant Likely <grant.likely@secretlab.ca>, Sinan Kaya <okaya@codeaurora.org>, Jingoo Han <jg1.han@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Suravee Suthikulanit <suravee.suthikulpanit@amd.com>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Device Tree ML <devicetree@vger.kernel.org>, LAKML <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@linaro.org>, Sunil Goutham <sunil.goutham@caviumnetworks.com>
Message-ID: <20140922093228.t3qW_MKaLcNjWyGhioYU8O73zA59hWMjpXXoUBOLQZE@z>

On 18.09.14 02:30:23, Liviu Dudau wrote:
> +int of_pci_get_host_bridge_resources(struct device_node *dev,
> +			unsigned char busno, unsigned char bus_max,
> +			struct list_head *resources, resource_size_t *io_base)
> +{
> +	struct resource *res;
> +	struct resource *bus_range;
> +	struct of_pci_range range;
> +	struct of_pci_range_parser parser;
> +	char range_type[4];
> +	int err;
> +
> +	if (!io_base)
> +		return -EINVAL;
> +	*io_base = OF_BAD_ADDR;

This breaks for mem-mapped pci host controllers. The patch below fixes
this.

This series was tested with the fix on top for Cavium Thunder.

Tested-by: Robert Richter <rrichter@cavium.com>

-Robert
