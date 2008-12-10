Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from h4.dl5rb.org.uk ([81.2.74.4]:42517 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752562AbYLJNhf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 Dec 2008 08:37:35 -0500
Date: Wed, 10 Dec 2008 13:35:13 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 08/12] PCI: mips: use generic
	pci_swizzle_interrupt_pin()
Message-ID: <20081210133513.GB4266@linux-mips.org>
References: <20081209231037.18153.86962.stgit@bob.kio> <20081209231217.18153.85615.stgit@bob.kio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20081209231217.18153.85615.stgit@bob.kio>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Russell King <rmk@arm.linux.org.uk>, Kyle McMartin <kyle@parisc-linux.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, hpa@zytor.com
Message-ID: <20081210133513.RS5oUlqWJkzcGztIhjmS9Va32YOSu1Hf8ZlFID2C8Is@z>

On Tue, Dec 09, 2008 at 04:12:17PM -0700, Bjorn Helgaas wrote:

> Use the generic pci_swizzle_interrupt_pin() instead of arch-specific code.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Looking good,

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
