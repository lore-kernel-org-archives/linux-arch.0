From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
 memory management
Date: Wed, 21 Jul 2010 10:44:37 +0900
Message-ID: <20100721104356S.fujita.tomonori@lab.ntt.co.jp>
References: <20100715014148.GC2239@codeaurora.org>
	<20100719082213.GA7421@n2100.arm.linux.org.uk>
	<20100720221959.GC12250@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20100720221959.GC12250@codeaurora.org>
Sender: owner-linux-mm@kvack.org
To: zpfeffer@codeaurora.org
Cc: linux@arm.linux.org.uk, fujita.tomonori@lab.ntt.co.jp, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
