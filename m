From: Liviu Dudau <liviu-I3yL/QOVVjH10XsdtD+oqA@public.gmane.org>
Subject: Re: [PATCH v10 00/10] Support for creating generic PCI host bridges
 from DT
Date: Mon, 8 Sep 2014 17:07:50 +0100
Message-ID: <20140908160749.GC1296@bart.dudau.co.uk>
References: <1410184472-17630-1-git-send-email-Liviu.Dudau@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1410184472-17630-1-git-send-email-Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Liviu Dudau <Liviu.Dudau-5wv7dgnIgG8@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pci <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tanmay Inamdar <tinamdar-qTEPVZfXA3Y@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Suravee Suthikulanit <suravee.suthikulpanit-5C7GfCeVMHo@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Device Tree ML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAKML <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 08, 2014 at 02:54:22PM +0100, Liviu Dudau wrote:
> This is my version 10 of the attempt at adding support for generic PCI host
> bridge controllers that make use of device tree information to
> configure themselves. This version reverses v9's attempt to create one function
> to drive the whole process of extracting the host bridge ranges, setup the
> host bridge driver and then scan the root bus behind the host bridge. While it
> would've been quite user friendly, I agree that it would've caused a lot of pain
> in the future.
> 
> I would like to get ACKs for the remaining patches as I would like to integrate
> this into -next in the following week.
> 
> This version marks an implementation break with the previous versions as
> of_create_pci_host_bridge() is now gone. It gets replaced by
> of_pci_get_host_bridge_resources() that only parses the DT and extracts the
> relevant ranges and converts them to resources. The updated host bridge drivers
> will have to follow the guidelines in this example code:
> 
> static int foohb_probe(struct platform_device *pdev)
> {
> 	struct device_node *dn = pdev->dev.of_node;
> 	struct foohb_drv *drv;
> 	resource_size_t io_base = 0;  /* phys address for start of IO */
> 	struct pci_bus *bus;
> 	int err = 0;
> 	LIST_HEAD(res);
> 
> 	.....
> 	err = of_pci_get_host_bridge_resources(dn, 0, 255, &res, &io_base);
> 	if (err)
> 		goto err_handling;
> 	err = foohb_setup(drv, ...., &res, &io_base);
> 	if (err)
> 		goto err_handling;
> 	.....
> 	pci_add_flags(....);
> 	bus = pci_scan_root_bus(&pdev->dev, 0, &foohb_ops, drv, &res);
> 	if (!bus)
> 		goto err_handling;
> 	....
> 	return 0;
> 
> err_handling:
> 	......
> 	return err;
> }

Forgot to mention: the git tree containing the code can be found here:

git://linux-arm.org/linux-ld.git for-upstream/pci_v10

Best regards,
Liviu

> 
> Changes from v9:
>  - Moved the DT parsing and assigning of IRQ patch from this series into arm64
>    specific patch. This keeps existing pcibios_add_device() unchanged and adds
>    an arch-specific version that can later be expanded to cater for dma_ops.
>  - Incorporated the fix for users of of_pci_range_to_resources() into the patch
>    that changes the behaviour for easier bisection.
>  - Added fixes for tegra and rcar host drivers in their usage of
>    of_pci_range_to_resources()
>  - Broke up of_create_pci_host_bridge() to remove the callback function. The
>    function left has been renamed into of_pci_get_host_bridge_resources(). The
>    added benefit of that is that the architectural hook for fixing up host bridge
>    resources now dissappears.
>  - Reshuffled the way pgprot_device gets introduced. It is now part of the patch
>    that adds pci_remap_iospace() function. The arm64 specific override is moved
>    into the arm64 patchset.
>  - Added a patch to pci_scan_root_bus() to assign unassigned resources if PCI
>    flags are not PCI_PROBE_ONLY
> 
> v9 thread here, with links to previous threads: https://lkml.org/lkml/2014/8/12/361
> 
> Best regards,
> Liviu
> 
> Liviu Dudau (10):
>   Fix ioport_map() for !CONFIG_GENERIC_IOMAP cases.
>   PCI: Introduce helper functions to deal with PCI I/O ranges.
>   ARM: Define PCI_IOBASE as the base of virtual PCI IO space.
>   PCI: OF: Fix the conversion of IO ranges into IO resources.
>   PCI: Create pci_host_bridge before its associated bus in
>     pci_create_root_bus.
>   PCI: Introduce generic domain handling for PCI busses.
>   OF: Introduce helper function for getting PCI domain_nr
>   OF: PCI: Add support for parsing PCI host bridge resources from DT
>   PCI: Assign unassigned bus resources in pci_scan_root_bus()
>   PCI: Introduce pci_remap_iospace() for remapping PCI I/O bus resources
>     into CPU space
> 
>  arch/arm/include/asm/io.h         |   1 +
>  arch/arm/mach-integrator/pci_v3.c |  23 +++---
>  drivers/of/address.c              | 146 ++++++++++++++++++++++++++++++++++++++
>  drivers/of/of_pci.c               | 136 +++++++++++++++++++++++++++++++++++
>  drivers/pci/host/pci-tegra.c      |  10 ++-
>  drivers/pci/host/pcie-rcar.c      |  21 ++++--
>  drivers/pci/pci.c                 |  33 +++++++++
>  drivers/pci/probe.c               |  46 +++++++-----
>  include/asm-generic/io.h          |   2 +-
>  include/asm-generic/pgtable.h     |   4 ++
>  include/linux/of_address.h        |  15 ++--
>  include/linux/of_pci.h            |  18 +++++
>  include/linux/pci.h               |  24 +++++++
>  13 files changed, 429 insertions(+), 50 deletions(-)
> 
> -- 
> 2.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
-------------------
   .oooO
   (   )
    \ (  Oooo.
     \_) (   )
          ) /
         (_/

 One small step
   for me ...

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
