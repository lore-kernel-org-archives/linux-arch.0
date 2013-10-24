From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM: add support to dump the kernel page tables
Date: Thu, 24 Oct 2013 22:31:38 +0100
Message-ID: <20131024213138.GP16735@n2100.arm.linux.org.uk>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk> <20131024105143.GA24288@linaro.org> <20131024122306.GK16735@n2100.arm.linux.org.uk> <20131024125530.GA27357@linaro.org> <20131024154956.GN16735@n2100.arm.linux.org.uk> <20131024162542.GA32124@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41644 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab3JXVcN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Oct 2013 17:32:13 -0400
Content-Disposition: inline
In-Reply-To: <20131024162542.GA32124@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steve Capper <steve.capper@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org

On Thu, Oct 24, 2013 at 05:25:43PM +0100, Steve Capper wrote:
> Hi,
> for LPAE:
> I want pmd_large to return true for all non-zero pmds that have bit #1
> clear.
>  
> Clearing bit #0 of a pmd produces a faulting entry, and this is how
> PROT_NONE protection is enforced by huge pages.
> 
> pmd_sect will return false for non-zero pmds that have both bit #0 and
> bit #1 clear, thus will return false for some huge pages.

Well, consider that we want to move this code out of arch/arm and into
generic code - when that happens architectures should just have to
provide some data (the data to interpret the bitfields and memory
sections) to this code.

Therefore, we need pmd_large() to have the same semantics across all
architectures, and we can't use ARMs pmd_sect() - ARMs sections have
no meaning on other architectures, and the established macro which
should return true for large pages is pmd_large().

If there's the possibility for pmd_none(pmd) && pmd_large(pmd) to
return true, but the entry contains something which is not a section
descriptor, and ARM will be incompatible with other stuff and it will
stand in the way of moving this to generic code.

Really, I don't think ARM can be different with its definition of
pmd_large() even though generic code does not yet make use of this
macro.
