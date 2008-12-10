From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 08/12] PCI: mips: use generic
	pci_swizzle_interrupt_pin()
Date: Wed, 10 Dec 2008 13:35:13 +0000
Message-ID: <20081210133513.GB4266@linux-mips.org>
References: <20081209231037.18153.86962.stgit@bob.kio> <20081209231217.18153.85615.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081209231217.18153.85615.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Tue, Dec 09, 2008 at 04:12:17PM -0700, Bjorn Helgaas wrote:

> Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Looking good,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
