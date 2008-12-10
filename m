From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 11/12] PCI: sh: use generic pci_swizzle_interrupt_pin()
Date: Wed, 10 Dec 2008 12:49:08 +0900
Message-ID: <20081210034908.GB27217@linux-sh.org>
References: <20081209231037.18153.86962.stgit@bob.kio> <20081209231232.18153.20376.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:10808 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754740AbYLJDva (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Dec 2008 22:51:30 -0500
Content-Disposition: inline
In-Reply-To: <20081209231232.18153.20376.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com

On Tue, Dec 09, 2008 at 04:12:32PM -0700, Bjorn Helgaas wrote:
> Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Looks good, thanks.

Acked-by: Paul Mundt <lethal@linux-sh.org>
