From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 15/31] arm64: SMP support
Date: Fri, 17 Aug 2012 02:21:33 -0700
Message-ID: <20120817092133.GR11011@atomide.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
 <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:29256 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756077Ab2HQJVg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 05:21:36 -0400
Content-Disposition: inline
In-Reply-To: <1344966752-16102-16-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Marc Zyngier <marc.zyngier@arm.com>

* Catalin Marinas <catalin.marinas@arm.com> [120814 11:05]:
> This patch adds SMP initialisation and spinlocks implementation for
> AArch64. The spinlock support uses the new load-acquire/store-release
> instructions to avoid explicit barriers. The architecture also specifies
> that an event is automatically generated when clearing the exclusive
> monitor state to wake up processors in WFE, so there is no need for an
> explicit DSB/SEV instruction sequence. The SEVL instruction is used to
> set the exclusive monitor locally as there is no conditional WFE and a
> branch is more expensive.

Do we always have SMP hardware on arm64? Or are we going to need to
again add smp_on_up support later on?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
