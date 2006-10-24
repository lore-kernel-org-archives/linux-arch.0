Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:29630 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1752101AbWJXHdp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Oct 2006 03:33:45 -0400
Date: Tue, 24 Oct 2006 01:33:41 -0600
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Message-ID: <20061024073341.GA30702@colo.lackof.org>
References: <20061021071436.GA29248@colo.lackof.org> <20061023122023.b1087266.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023122023.b1087266.randy.dunlap@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

Randy,
many thanks for the thorough review...lots of silly grammar things
that I should have but just didn't see.

On Mon, Oct 23, 2006 at 12:20:23PM -0700, Randy Dunlap wrote:
> On Sat, 21 Oct 2006 01:14:36 -0600 Grant Grundler wrote:
> 
> > 0. Structure of PCI drivers
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > PCI drivers "discover" PCI devices in a system via pci_register_driver().
> > Actually, it's the other way around. The PCI generic code will notify the
> > driver at every the PCI device which match a "description" advertised
>          whenever ?

Yes. :)
I've rephrased that sentence to be a bit clearer:
	When the PCI generic code discovers a new device, the driver
	with a matching "description" will be notified.

Remember, this document is an introduction, not a complete reference.

> > by the driver. Details on this below.
> > 
> > 1. pci_register_driver() call
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > New-style drivers call pci_register_driver() during their
> > initialization with a pointer to a structure describing the driver
> > (struct pci_driver):
> 
> Could/would you add all of this to include/linux/pci.h as
> kernel-doc?

Hrm...that's a good idea. I could work on that as time permits
but I've got several other equally important things queued up.

This would also be a good "intern" project if a kernel newbie is
looking for something useful to do. I'd be happy to advise/review
results as needed.

> although that would require that _all_ struct fields be described.
> 
> > 	field name	Description
> > 	----------	------------------------------------------------------
> 
> > 			(Please see Documentation/power/pci.txt for descriptions
> > 			of PCI Power Management and the related functions)
> 
> end with .)

fixed 

> > The ID table is an array of struct pci_device_id ending with an all-zero entry.
>                                                   ^entries ?

fixed

> > Once added, the driver probe routine will be invoked for any unclaimed
> > PCI devices listed in it's (newly updated) pci_ids list.
> *                       its

fixed (*ugh* Jes, can I borrow some brown paper bags from you? ;)

> > 	o If the driver is not a hotplug driver then use only 
> > 	  __init/exit and __initdata/exitdata.
> 
> I'd prefer to see exit, exitdata, etc., spelled with leading __.

I agree. Fixed several of those in than section. I think I got them all.

> 
> >         o Pointers to functions marked as __devexit must be created using
> >           __devexit_p(function_name).  That will generate the function
> >           name or NULL if the __devexit function will be discarded.
> 
> > 3. Device Initialization Steps
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > As noted in introduction, most PCI drivers need the following steps
> *            ^the
> 
> > for device initialization:
> 
> > 3.1 Request MMIO/IOP resources
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Memory (MMIO), and I/O port addresses numbers should NOT be read directly
> 
> not both addresses and numbers...

Correct...just addresses.

> > from the PCI device config space. Use the values in the pci_dev structure
> > as the PCI "bus address" might have been remapped to a "host physical"
> > address by the kernel.
> > 
> 
> > 3.2 Enable the PCI device
> > ~~~~~~~~~~~~~~~~~~~~~~~~~
> >    Before touching any device registers, you need to enable the PCI device
> s/you need/the driver needs/
> 
> > by calling pci_enable_device(). This will:
> > 	o wakes up the device if it was in suspended state,
> *         wake
> > 	o enable I/O and memory regions of the device,
> > 	o allocates an IRQ (if BIOS did not),
> *         allocate
> + s/,/./

thanks - all three fixed

> > NOTE: pci_enable_device() can fail! Check the return value.
> > 
> >    pci_set_master() will enable DMA by setting the bus master bit
> > in PCI_COMMAND register. It also fixes the latency timer value if
> *   ^the

fixed

> 
> > it's set to something bogus by the BIOS.
> > 
> 
> > 3.2 Set the DMA mask size
> > ~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> > Similarly, drivers must also "register" this capability if the device
> > can directly address "consistent" in System RAM above 4G physical address.
> * "consistent" <what> ?

ah sorry: consistent memory.

> > Drivers for PCI-X and PCIe compliant devices should also call
> > pci_set_consistent_dma_mask().
> 
> > 3.5 register IRQ handler
> > ~~~~~~~~~~~~~~~~~~~~~~~~
> > While calling request_irq() is the the last step describe here,
> > this is often just another intermediate step to initializing a device.
> > This step can often be deferred until the device is opened for use.
> > 
> > All interrupt handlers should be registered with IRQF_SHARED and use the
> > devid to map IRQs to devices (remember that all PCI interrupts are shared).
> * (excluding MSI)

good catch. I believe this is part of the original text that
predates all the MSI support.

New text now reads:
	All interrupt handlers for IRQ lines should be registered with
	IRQF_SHAREDand use the devid to map IRQs to devices (remember
	that all PCI IRQ linescan be shared).

> 
> > If your PCI device supports both, try to enable MSI-X first.
> > Only one can be enabled at a time.  Many architectures, chipsets,
> > or BIOSs do NOT support MSI or MSI-X and the call to pci_enable_msi/msix
> * BIOSes ?

I don't know. I'll use BIOSes.

> 
> > will fail. This is important to note since many drivers have
> > two (or more) interrupt handlers: one for MSI/MSI-X and another for IRQs.
> > They choose which handler to register with request_irq() based on the
> > return value from pci_enable_msi/msix().
> > 
> > There are (at least) two really good reasons for using MSI:
> > 1) MSI is an exclusive interrupt vector by definition.
> >    This means the interrupt handler doesn't have to verify that
> >    it's device caused the interrupt.
> *    its
> 
> > 4  PCI device shutdown
>   4.

Both fixed - thanks

> > ~~~~~~~~~~~~~~~~~~~~~~
> 
> > 4.1 Stop IRQs on the device
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > How to do this is chip/device specific. If it's not done, it opens
> > the possibility of a "screaming interrupt" if (and only if)
> > the IRQ is shared with another device.
> > 
> > When the shared IRQ handler is "unhoooked", the remaining devices
> > using the same IIRQ still need the IRQ enabled. Thus if the "unhooked"
> 
>  IIRQ ?

IRQ - fixed.

> 
> > device asserts IRQ signal, the system wil respond assuming it was one
> > of the remaining devices asserted the IRQ line. Since none of the other
> > devices will handle the IRQ, the system will "hang" until it decides
> > the IRQ isn't going to get handled and masks the IRQ (100,000 iterations
> > later). Once the shared IRQ is masked, the remaining devices will
> > stop functioning properly. Not a nice situation.
> > 
> 
> > 4.4 release DMA buffers
> > ~~~~~~~~~~~~~~~~~~~~~~~
> > Once DMA is stopped, clean up streaming DMA first.
> > ie. unmap data buffers and return buffers to "upstream"
> 
>   i.e.
> 
> > owners if there is one.
> > 
> > 4.6 Disable device from responding to MMIO/IO Port addresses
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > This is just a call to pci_disable_device().
> > This is the symetric opposite of pci_enable_device().
> 
>               symmetric

thanks - I just mispelled it...I will run this through ispell before
submitting it again for review.

> 
> > Do not do anything with the device after calling pci_disable_device().
> 
> HTH.

yes - it did help.

many thanks,
grant
