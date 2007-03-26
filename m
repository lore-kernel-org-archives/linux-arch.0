Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:51644 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbXCZQVB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 26 Mar 2007 12:21:01 -0400
Date: Mon, 26 Mar 2007 09:21:19 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] remove pci_dac_dma_... APIs
Message-Id: <20070326092119.2abce07c.randy.dunlap@oracle.com>
In-Reply-To: <4607F0EF.76E4.0078.0@novell.com>
References: <4607F0EF.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 26 Mar 2007 15:12:31 +0100 Jan Beulich wrote:

> Based on replies to a respective query, remove the pci_dac_dma_...() APIs
> (except for pci_dac_dma_supported() on Alpha, where this function is used
> in non-DAC PCI DMA code).
> 
> Signed-off-by: Jan Beulich <jbeulich@novell.com>
> Cc: Andi Kleen <ak@suse.de>
> Cc: Jesse Barnes <jesse.barnes@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: David Miller <davem@davemloft.net>

meta-comment:  while diffstats are not required (by
Documentation/SubmittingPatches), they sure can be helpful
to reviewers.


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
