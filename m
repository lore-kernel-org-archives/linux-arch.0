Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:36922 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeK2GaB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Nov 2018 01:30:01 -0500
Date: Wed, 28 Nov 2018 11:27:17 -0800 (PST)
Message-ID: <20181128.112717.149234960284639699.davem@davemloft.net>
Subject: Re: remove the ->mapping_error method from dma_map_ops V2
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
References: <CAHk-=wg5+rXK8dpjkSmK7tuz29VfxVWNEwmTVYB409mmyLkeew@mail.gmail.com>
        <20181128174545.GJ30658@n2100.armlinux.org.uk>
        <CAHk-=whnz4Kty6cas11bc2Gh=9zTzeeRS2k=dV9Hfc4B=xnHkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux@armlinux.org.uk, hch@lst.de, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, robin.murphy@arm.com, x86@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-alpha@vger.kernel.org, xen-devel@lists.xenproject.org, dwmw2@infradead.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20181128192717.FB0JRHCPnoCbgTarYgrdOO9iTHQceFxNNRA9SGy8Yoc@z>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Nov 2018 10:00:06 -0800

> Not all memory is accessible even to the kernel. If you have memory
> that shows up in the last page of phys_addr_t, you just mark it
> reserved at boot-time.

It's not the physical memory at the end that needs to be reserved.

It's the IOMMU mapping arena.

That basically requires changes to every IOMMU implementation in
the tree.  Not saying it's hard or impossible, but it is real
meticulous work that needs to be done in order to realize this.
