From: Kyle McMartin <kyle@infradead.org>
Subject: Re: [PATCH 09/12] PCI: parisc: use generic
	pci_swizzle_interrupt_pin()
Date: Tue, 9 Dec 2008 18:26:10 -0500
Message-ID: <20081209232610.GC7015@bombadil.infradead.org>
References: <20081209231037.18153.86962.stgit@bob.kio> <20081209231222.18153.28604.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081209231222.18153.28604.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 09, 2008 at 04:12:22PM -0700, Bjorn Helgaas wrote:
> Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

cool, ack.
