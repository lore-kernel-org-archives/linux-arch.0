From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 04/31] arm64: MMU definitions
Date: Fri, 17 Aug 2012 02:38:22 -0700
Message-ID: <20120817093822.GV11011@atomide.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-5-git-send-email-catalin.marinas@arm.com>
 <20120817090451.GP11011@atomide.com>
 <20120817092106.GA24389@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24311 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab2HQJiY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 05:38:24 -0400
Content-Disposition: inline
In-Reply-To: <20120817092106.GA24389@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <Will.Deacon@arm.com>

* Catalin Marinas <catalin.marinas@arm.com> [120817 02:21]:
> On Fri, Aug 17, 2012 at 10:04:52AM +0100, Tony Lindgren wrote:
> > * Catalin Marinas <catalin.marinas@arm.com> [120814 10:57]:
> > > The virtual memory layout is described in
> > > Documentation/arm64/memory.txt. This patch adds the MMU definitions for
> > > the 4KB and 64KB translation table configurations. The SECTION_SIZE is
> > > 2MB with 4KB page and 512MB with 64KB page configuration.
> > > 
> > > PHYS_OFFSET is calculated at run-time and stored in a variable (no
> > > run-time code patching at this stage).
> > 
> > Care to clarify this part a bit? Is the memory standardized somehow
> > now and not needed? Or do we still need to add that for various SoCs
> > later on?
> 
> The memory is not standardised but we have FDT to fully specify it. The
> PHYS_OFFSET does not need to be defined, it is automatically detected at
> boo-time based on the kernel load address and stored in a variable to be
> used later.

OK nice thanks.

Tony
