Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:56541 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965052AbWJWTWG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Oct 2006 15:22:06 -0400
Date: Mon, 23 Oct 2006 12:20:23 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Message-Id: <20061023122023.b1087266.randy.dunlap@oracle.com>
In-Reply-To: <20061021071436.GA29248@colo.lackof.org>
References: <20061021071436.GA29248@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Sat, 21 Oct 2006 01:14:36 -0600 Grant Grundler wrote:

> 0. Structure of PCI drivers
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> PCI drivers "discover" PCI devices in a system via pci_register_driver().
> Actually, it's the other way around. The PCI generic code will notify the
> driver at every the PCI device which match a "description" advertised
         whenever ?

> by the driver. Details on this below.
> 
> 1. pci_register_driver() call
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> New-style drivers call pci_register_driver() during their
> initialization with a pointer to a structure describing the driver
> (struct pci_driver):

Could/would you add all of this to include/linux/pci.h as
kernel-doc?
although that would require that _all_ struct fields be described.

> 	field name	Description
> 	----------	------------------------------------------------------

> 			(Please see Documentation/power/pci.txt for descriptions
> 			of PCI Power Management and the related functions)

end with .)


> The ID table is an array of struct pci_device_id ending with an all-zero entry.
                                                  ^entries ?

> Once added, the driver probe routine will be invoked for any unclaimed
> PCI devices listed in it's (newly updated) pci_ids list.
*                       its

> Tips on marks:
> 	o The module_init()/module_exit() functions (and all initialization
>           functions called _only_ from these) should be marked __init/exit.
> 
> 	o The struct pci_driver shouldn't be marked with any of these tags.
> 
> 	o The ID table array should be marked __devinitdata.
> 
> 	o The probe() and remove() functions (and all initialization
> 	  functions called only from these) should be marked __devinit/exit.
> 
> 	o If the driver is not a hotplug driver then use only 
> 	  __init/exit and __initdata/exitdata.

I'd prefer to see exit, exitdata, etc., spelled with leading __.

>         o Pointers to functions marked as __devexit must be created using
>           __devexit_p(function_name).  That will generate the function
>           name or NULL if the __devexit function will be discarded.

> 3. Device Initialization Steps
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> As noted in introduction, most PCI drivers need the following steps
*            ^the

> for device initialization:

> 3.1 Request MMIO/IOP resources
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Memory (MMIO), and I/O port addresses numbers should NOT be read directly

not both addresses and numbers...

> from the PCI device config space. Use the values in the pci_dev structure
> as the PCI "bus address" might have been remapped to a "host physical"
> address by the kernel.
> 

> 3.2 Enable the PCI device
> ~~~~~~~~~~~~~~~~~~~~~~~~~
>    Before touching any device registers, you need to enable the PCI device
s/you need/the driver needs/

> by calling pci_enable_device(). This will:
> 	o wakes up the device if it was in suspended state,
*         wake
> 	o enable I/O and memory regions of the device,
> 	o allocates an IRQ (if BIOS did not),
*         allocate
+ s/,/./

> NOTE: pci_enable_device() can fail! Check the return value.
> 
>    pci_set_master() will enable DMA by setting the bus master bit
> in PCI_COMMAND register. It also fixes the latency timer value if
*   ^the

> it's set to something bogus by the BIOS.
> 

> 3.2 Set the DMA mask size
> ~~~~~~~~~~~~~~~~~~~~~~~~~

> Similarly, drivers must also "register" this capability if the device
> can directly address "consistent" in System RAM above 4G physical address.
* "consistent" <what> ?

> Drivers for PCI-X and PCIe compliant devices should also call
> pci_set_consistent_dma_mask().

> 3.5 register IRQ handler
> ~~~~~~~~~~~~~~~~~~~~~~~~
> While calling request_irq() is the the last step describe here,
> this is often just another intermediate step to initializing a device.
> This step can often be deferred until the device is opened for use.
> 
> All interrupt handlers should be registered with IRQF_SHARED and use the
> devid to map IRQs to devices (remember that all PCI interrupts are shared).
* (excluding MSI)

> If your PCI device supports both, try to enable MSI-X first.
> Only one can be enabled at a time.  Many architectures, chipsets,
> or BIOSs do NOT support MSI or MSI-X and the call to pci_enable_msi/msix
* BIOSes ?

> will fail. This is important to note since many drivers have
> two (or more) interrupt handlers: one for MSI/MSI-X and another for IRQs.
> They choose which handler to register with request_irq() based on the
> return value from pci_enable_msi/msix().
> 
> There are (at least) two really good reasons for using MSI:
> 1) MSI is an exclusive interrupt vector by definition.
>    This means the interrupt handler doesn't have to verify that
>    it's device caused the interrupt.
*    its

> 4  PCI device shutdown
  4.

> ~~~~~~~~~~~~~~~~~~~~~~

> 4.1 Stop IRQs on the device
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> How to do this is chip/device specific. If it's not done, it opens
> the possibility of a "screaming interrupt" if (and only if)
> the IRQ is shared with another device.
> 
> When the shared IRQ handler is "unhoooked", the remaining devices
> using the same IIRQ still need the IRQ enabled. Thus if the "unhooked"

 IIRQ ?

> device asserts IRQ signal, the system wil respond assuming it was one
> of the remaining devices asserted the IRQ line. Since none of the other
> devices will handle the IRQ, the system will "hang" until it decides
> the IRQ isn't going to get handled and masks the IRQ (100,000 iterations
> later). Once the shared IRQ is masked, the remaining devices will
> stop functioning properly. Not a nice situation.
> 

> 4.4 release DMA buffers
> ~~~~~~~~~~~~~~~~~~~~~~~
> Once DMA is stopped, clean up streaming DMA first.
> ie. unmap data buffers and return buffers to "upstream"

  i.e.

> owners if there is one.
> 
> 4.6 Disable device from responding to MMIO/IO Port addresses
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> This is just a call to pci_disable_device().
> This is the symetric opposite of pci_enable_device().

              symmetric

> Do not do anything with the device after calling pci_disable_device().

HTH.
---
~Randy
