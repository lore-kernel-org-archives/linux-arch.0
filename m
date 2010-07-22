From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
	memory management
Date: Thu, 22 Jul 2010 08:39:17 +0100
Message-ID: <20100722073917.GC6802@n2100.arm.linux.org.uk>
References: <20100715014148.GC2239@codeaurora.org> <20100719082213.GA7421@n2100.arm.linux.org.uk> <20100720221959.GC12250@codeaurora.org> <20100721104356S.fujita.tomonori@lab.ntt.co.jp> <20100722043034.GC22559@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34546 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab0GVHjw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jul 2010 03:39:52 -0400
Content-Disposition: inline
In-Reply-To: <20100722043034.GC22559@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Zach Pfeffer <zpfeffer@codeaurora.org>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jul 21, 2010 at 09:30:34PM -0700, Zach Pfeffer wrote:
> This goes to the nub of the issue. We need a lot of 1 MB physically
> contiguous chunks. The system is going to fragment and we'll never get
> our 12 1 MB chunks that we'll need, since the DMA API allocator uses
> the system pool it will never succeed.

By the "DMA API allocator" I assume you mean the coherent DMA interface,
The DMA coherent API and DMA streaming APIs are two separate sub-interfaces
of the DMA API and are not dependent on each other.
