Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:41441 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755003AbYLKSQ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Dec 2008 13:16:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200812111103.10500.bjorn.helgaas@hp.com>
References: <200812111103.10500.bjorn.helgaas@hp.com> <200812110948.20563.bjorn.helgaas@hp.com> <23213.1229007624@redhat.com> <24742.1229016892@redhat.com>
Subject: Re: [PATCH 05/12] PCI: add pci_swizzle_interrupt_pin()
Date: Thu, 11 Dec 2008 18:14:55 +0000
Message-ID: <25771.1229019295@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: dhowells@redhat.com, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
Message-ID: <20081211181455.zqxr2fraWsuEKFF6zcVc1x8MCCzYnDcuHti4nyuPysQ@z>

Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> +/**
> + * pci_swizzle_interrupt_pin - swizzle INTx for device behind bridge
> + * @dev: the PCI device
> + * @pin: the INTx pin (1=INTA, 2=INTB, 3=INTD, 4=INTD)
> + *
> + * The PCI-to-PCI bridge specification, section 9.1, requires INTx swizzling
> + * for devices behind bridges on add-in cards.  This performs the swizzle
> + * for one level of bridge.
> + */

That's okay.  It might be better to put the what before the why, though:

 * Perform INTx swizzling for a device behind one level of bridge.  This is
 * required by section 9.1 of the PCI-to-PCI bridge specification for devices
 * behind bridges on add-in cards.

David
