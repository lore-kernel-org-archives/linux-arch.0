From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 00/31] AArch64 Linux kernel port
Date: Fri, 17 Aug 2012 02:36:59 -0700
Message-ID: <20120817093659.GU11011@atomide.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:22465 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756417Ab2HQJhC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 17 Aug 2012 05:37:02 -0400
Content-Disposition: inline
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

* Catalin Marinas <catalin.marinas@arm.com> [120814 10:54]:
> This is the 2nd version of the set of patches implementing Linux kernel
> support for the 64-bit ARM architecture (AArch64). Thanks to all who
> provided feedback on the previous version.

I've looked at these patches mostly from supporting SoCs point of view
and made few minor comments. It's nice to see that at least so far I did
not spot mutually exlusive #ifdef else stuff that's been causing major issues
supporting multiple SoCs with the current ARMs :) So all these patches,
feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>
