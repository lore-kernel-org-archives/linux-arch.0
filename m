From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 17:34:52 +0000
Message-ID: <24742.1229016892@redhat.com>
References: <200812110948.20563.bjorn.helgaas@hp.com> <20081209231202.18153.60227.stgit@bob.kio> <20081209231037.18153.86962.stgit@bob.kio> <23213.1229007624@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:50579 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755435AbYLKRgZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Dec 2008 12:36:25 -0500
In-Reply-To: <200812110948.20563.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> +/**
> + * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> + * @dev: the PCI device
> + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> + *
> + * The PCI-to-PCI bridge specification requires INTx swizzling for
> + * devices behind bridges on add-in cards.  This performs the swizzle
> + * for one level of bridge.
> + */

Better.

> +u8 pci_swizzle_interrupt_pin(struct pci_dev *dev, u8 pin)
> +{
> +	/* This implements Table 9-1 of the PCI-to-PCI bridge spec */

I'd recommend merging this comment into the banner.

> +	return (((pin - 1) + PCI_SLOT(dev->devfn)) % 4) + 1;
> +}
> +

David
