Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:54480 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761828Ab0GUBpn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Jul 2010 21:45:43 -0400
Date: Wed, 21 Jul 2010 10:44:37 +0900
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
 memory management
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100720221959.GC12250@codeaurora.org>
References: <20100715014148.GC2239@codeaurora.org>
	<20100719082213.GA7421@n2100.arm.linux.org.uk>
	<20100720221959.GC12250@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <20100721104356S.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: zpfeffer@codeaurora.org
Cc: linux@arm.linux.org.uk, fujita.tomonori@lab.ntt.co.jp, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20100721014437.EZPBp2lW1UgGNZu04oyyASRLFyWvju74g5d3VjCH44Q@z>

On Tue, 20 Jul 2010 15:20:01 -0700
Zach Pfeffer <zpfeffer@codeaurora.org> wrote:

> > I'm not saying that it's reasonable to pass (or even allocate) a 1MB
> > buffer via the DMA API.
> 
> But given a bunch of large chunks of memory, is there any API that can
> manage them (asked this on the other thread as well)?

What is the problem about mapping a 1MB buffer with the DMA API?

Possibly, an IOMMU can't find space for 1MB but it's not the problem
of the DMA API.
