From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/12] PCI: unify P2P bridge INTx swizzling
Date: Tue, 16 Dec 2008 12:20:08 -0800
Message-ID: <200812161220.10630.jbarnes@virtuousgeek.org>
References: <20081209231037.18153.86962.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20081209231037.18153.86962.stgit@bob.kio>
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

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
