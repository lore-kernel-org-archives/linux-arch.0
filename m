Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:14749 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S2992997AbWJUMz6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 21 Oct 2006 08:55:58 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: RFC: rewrite Documentation/pci.txt v3
Date: Sat, 21 Oct 2006 14:55:29 +0200
References: <20061021071436.GA29248@colo.lackof.org>
In-Reply-To: <20061021071436.GA29248@colo.lackof.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211455.29837.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>, linux-pci@atrey.karlin.mff.cuni.cz, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Saturday 21 October 2006 09:14, Grant Grundler wrote:

I think you should add a note somewhere that the driver
should be prepared to initialize the device from any
state it put it in before. That is important for kexec
which tries to reinit the drivers after a crash.

And add a reference to kerneldoc somewhere too? There
is some PCI documentation in there (although it probably
could need some overall editing) 

> 3.2 Set the DMA mask size
> ~~~~~~~~~~~~~~~~~~~~~~~~~
> [ If anything below doesn't make sense, it means you need to read
>   Documentation/DMA-API.txt. This section is just a reminder that
>   drivers need to indicate DMA capabilities of the device and is not
>   an authoritative source for DMA interfaces. ]
> 
> While all drivers should explictly indicate the DMA capability

I think it's ok to rely on the defaults if 0xffffffff is suitable

And perhaps one sentence what a consistent allocation is.

> 4  PCI device shutdown
> ~~~~~~~~~~~~~~~~~~~~~~
> When a PCI device driver is being unloaded, most of the follow 
> steps need to be performed:
> 
> 	disable the device from generating IRQs
> 	release the IRQ (free_irq())
> 	stop all DMA activity
> 	release DMA buffers (both streaming and consistent)
> 	unregister from other subsystems (e.g. scsi or netdev)
> 	Disable device from responding to MMIO/IO Port addresses
> 	release MMIO/IO Port resource(s)


put the pci_dev you got during explicit probing? For the normal
probing path the higher layer takes care of it I think.

 
>    If you don't have a struct pci_dev available, you can call
> pci_bus_(read|write)_config_(byte|word|dword) to access a given device
> and function on that bus.


This shouldn't happen in driver code right? I would remove it.

People who want to do such low level things can read the source
or kerneldoc.
 
>    If you access fields in the standard portion of the config header, please
> use symbolic names of locations and bits declared in <linux/pci.h>.
> 
>    If you need to access Extended PCI Capability registers, just call
> pci_find_capability() for the particular capability and it will find the
> corresponding register block for you.
> 
> 
> 6. Other interesting functions
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> pci_find_slot()			Find pci_dev corresponding to given bus and
> 				slot numbers.

Again i don't think that fits here.

> pci_set_power_state()		Set PCI Power Management state (0=D0 ... 3=D3)
> pci_find_capability()		Find specified capability in device's capability
> 				list.
> pci_module_init()		Inline helper function for ensuring correct
> 				pci_driver initialization and error handling.

Perhaps that should be described at the beginning?

> pci_resource_start()		Returns bus start address for a given PCI region
> pci_resource_end()		Returns bus end address for a given PCI region
> pci_resource_len()		Returns the byte length of a PCI region

And that in the section for resources?

-Andi
