Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:42936 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265790AbUFRXdc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 18 Jun 2004 19:33:32 -0400
Date: Fri, 18 Jun 2004 16:32:43 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: Accessing memory remote across the bus in the same way as local
 memory
Message-Id: <20040618163243.26d9fcb3.davem@redhat.com>
In-Reply-To: <1087601198.2134.206.camel@mulgrave>
References: <1087601198.2134.206.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On 18 Jun 2004 18:26:37 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> The question is given the constraints, can we pull page table tricks on
> every platform to make this bus remote memory look like real memory?

There are three issues:

1) How to form the physical address (for a PCI device we have PCI device
   pointer and resource, stuff like that, we just need a translator
   interface or similar to pass that info in)

2) Whether such accesses are legal.  On Sparc64 one device cannot DMA
   to/from the MMIO of a device behind a _DIFFERENT_ PCI controller.

3) Some logic to get page table non-cacheable bits set etc. since this
   is to non-memory space.
