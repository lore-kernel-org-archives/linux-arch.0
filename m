From: Zach Pfeffer <zpfeffer@codeaurora.org>
Subject: Re: [RFC 1/3 v3] mm: iommu: An API to unify IOMMU, CPU and device
 memory management
Date: Wed, 14 Jul 2010 18:29:58 -0700
Message-ID: <20100715012958.GB2239@codeaurora.org>
References: <4C3C0032.5020702@codeaurora.org>
 <20100713150311B.fujita.tomonori@lab.ntt.co.jp>
 <20100713121420.GB4263@codeaurora.org>
 <20100714104353B.fujita.tomonori@lab.ntt.co.jp>
 <20100714201149.GA14008@codeaurora.org>
 <20100714220536.GE18138@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100714220536.GE18138@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>, ebiederm@xmission.com, linux-arch@vger.kernel.org, dwalker@codeaurora.org, mel@csn.ul.ie, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, andi@firstfloor.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 14, 2010 at 11:05:36PM +0100, Russell King - ARM Linux wrote:
> On Wed, Jul 14, 2010 at 01:11:49PM -0700, Zach Pfeffer wrote:
> > If the DMA-API contained functions to allocate virtual space separate
> > from physical space and reworked how chained buffers functioned it
> > would probably work - but then things start to look like the VCM API
> > which does graph based map management.
> 
> Every additional virtual mapping of a physical buffer results in
> additional cache aliases on aliasing caches, and more workload for
> developers to sort out the cache aliasing issues.
> 
> What does VCM to do mitigate that?

The VCM ensures that all mappings that map a given physical buffer:
IOMMU mappings, CPU mappings and one-to-one device mappings all map
that buffer using the same (or compatible) attributes. At this point
the only attribute that users can pass is CACHED. In the absence of
CACHED all accesses go straight through to the physical memory.

The architecture of the VCM allows these sorts of consistency checks
to be made since all mappers of a given physical resource are
tracked. This is feasible because the physical resources we're
tracking are typically large.
