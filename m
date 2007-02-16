Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63114 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946083AbXBPTqH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Feb 2007 14:46:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] killing the NR_IRQS arrays.
Date: Fri, 16 Feb 2007 20:45:58 +0100
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200702162045.58857.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

On Friday 16 February 2007 13:10, Eric W. Biederman wrote:
> To do this I believe will require a s/unsigned int irq/struct irq_desc *irq/
> throughout the entire kernel.  Getting the arch specific code and the
> generic kernel infrastructure fixed and ready for that change looks
> like a pain but pretty doable.

We did something like this a few years back on the s390 architecture, which
happens to be lucky enough not to share any interrupt based drivers with
any of the other architectures.

It helped a lot on s390, and I think the change will be beneficial on others
as well, e.g. powerpc already uses 'virtual' interrupt numbers to collapse
the large (sparse) range of interrupt numbers into 512 unique numbers. This
could easily be avoided if there was simply an array of irq_desc structures
per interrupt controller.

However, I also think we should maintain the old interface, and introduce
a new one to deal only with those cases that benefit from it (MSI, Xen,
powerpc VIO, ...). This means one subsystem can be converted at a time.

I don't think there is a point converting the legacy ISA interrupts to
a different interface, as the concept of IRQ numbers is part of the 
subsystem itself (if you want to call ISA a subsystem...).

For PCI, it makes a lot more sense to use something else, considering
that PCI interrupts are defined as 'pins' instead of 'lines', and
while an interrupt pin is defined per slot, while the line is per
bus, in a system with multiple PCI buses, the line is still not
necessarily unique.

One interface I could imagine for PCI devices would be

/* generic functions */
int request_irq_desc(struct irq_desc *desc, irq_handler_t handler,
		unsigned long irqflags, const char *devname, void *dev_id);
int free_irq_desc(struct irq_desc *desc, void *dev_id);

/* legacy functions */
int request_irq(int irq, irq_handler_t handler,
		unsigned long irqflags, const char *devname, void *dev_id)
{
	return request_irq_desc(lookup_irq_desc(irq), handler, irqflags,
					devname, dev_id);
}
int free_irq(int irq, void *dev_id)
{
	return free_irq_desc(lookup_irq_desc(irq), dev_id);
}

/* pci specific */
struct irq_desc *pci_request_irq(struct pci_device *dev, int pin,
				 irq_handler_t handler)
{
	struct irq_desc *desc = pci_lookup_irq(dev, pin);
	int ret;

	if (!desc)
		return NULL;

	ret = request_irq_desc(desc, handler, IRQF_SHARED,
			&dev->dev.bus_id, dev);
	if (ret < 0)
		return NULL;
	return desc;
}
int pci_free_irq(struct pci_device *dev, int pin)
{
	return free_irq_desc(pci_lookup_irq(dev, pin), dev);
}

Now I don't know enough about MSI yet, but I could imagine
that something along these lines would work as well, and we
could simply require all drivers that want to support MSI
to use the new interfaces.

	Arnd <><
