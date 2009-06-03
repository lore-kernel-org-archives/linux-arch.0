From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [Ksummit-2009-discuss] Representing Embedded Architectures at
	the Kernel Summit
Date: Wed, 03 Jun 2009 14:04:46 +0100
Message-ID: <1244034286.24482.84.camel@pc1117.cambridge.arm.com>
References: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:38473 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753668AbZFCNEz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jun 2009 09:04:55 -0400
In-Reply-To: <1243956140.4229.25.camel@mulgrave.int.hansenpartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: ksummit-2009-discuss@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-embedded@vger.kernel.org

Hi,

On Tue, 2009-06-02 at 15:22 +0000, James Bottomley wrote:
> So what we're looking for is a proposal to discuss the issues
> most affecting embedded architectures, or preview any features affecting
> the main kernel which embedded architectures might need ... or any other
> topics from embedded architectures which might need discussion or
> debate.

Some issues that come up on embedded systems (and not only):

      * Multiple coherency domains for devices - the system may have
        multiple bus levels, coherency ports, cache levels etc. Some
        devices in the system (but not all) may be able to "see" various
        cache levels but the DMA API (at least on ARM) cannot handle
        this. It may be useful to discuss how other embedded
        architectures handle this and come up with a unified solution

      * Better support for coherent DMA mask - currently ZONE_DMA is
        assumed to be in the bottom part of the memory which isn't
        always the case. Enabling NUMA may help but it is overkill for
        some systems. As above, a more unified solution across
        architectures would help

      * PIO block devices and non-coherent hardware - code like mpage.c
        assumes that the either the hardware is coherent or the device
        driver performs the cache flushing. The latter is true for
        DMA-capable device but not for PIO. The issue becomes visible
        with write-allocate caches and the device driver may not have
        the struct page information to call flush_dcache_page(). A
        proposed solution on the ARM lists was to differentiate (via
        some flags) between PIO and DMA block devices and use this
        information in mpage.c

      * Mixed endianness devices in the same system - this may only need
        dedicated readl_be/writel_be etc. macros but it could also be
        done by having bus-aware readl/writel-like macros

      * Asymmetric MP:
              * Different CPU frequencies
              * Different CPU features (e.g. floating point only one
                some CPUs): scheduler awareness, per-CPU hwcap bits (in
                case user space wants to set the affinity) 
              * Asymmetric workload balancing for power consumption (may
                be better to load 1 CPU at 60% than 4 at 15%) 

Thanks.

-- 
Catalin
