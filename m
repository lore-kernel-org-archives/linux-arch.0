Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outbound-mail-29.bluehost.com ([69.89.17.211]:41643 "HELO
	outbound-mail-29.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760389AbYLPU0x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 16 Dec 2008 15:26:53 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/12] PCI: unify P2P bridge INTx swizzling
Date: Tue, 16 Dec 2008 12:20:08 -0800
References: <20081209231037.18153.86962.stgit@bob.kio>
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200812161220.10630.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
Message-ID: <20081216202008.EBbSI3bqpa6g_mCdui845rPAF0uy3cP1b25kiGkuPFw@z>

On Tuesday, December 9, 2008 3:11 pm Bjorn Helgaas wrote:
> This series adds a pci_swizzle_interrupt_pin() function in the PCI
> core.  Most architectures currently implement this independently.
>
> After this series, many of the callers of pci_swizzle_interrupt_pin()
> follow a similar pattern.  I'd like to consolidate those callers, too,
> but I haven't started that yet.
>
> One strange thing I'd like to understand eventually is why the
> swizzle in acpi_pci_irq_derive() does something special for CardBus
> bridges, while no other architecture does.
>
> Comments welcome.

Applied the series to my linux-next branch, thanks a lot for unifying this.

Jesse
