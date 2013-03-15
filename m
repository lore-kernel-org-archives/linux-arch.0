From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Fri, 15 Mar 2013 17:58:08 +0000
Message-ID: <20130315175808.GT4977@n2100.arm.linux.org.uk>
References: <7534695.eTHcH0enMV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36391 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab3COR6R (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 13:58:17 -0400
Content-Disposition: inline
In-Reply-To: <7534695.eTHcH0enMV@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

On Thu, Mar 14, 2013 at 11:01:35PM +0100, Arnd Bergmann wrote:
> gcc-4.7 and higher add a lot of false positive warnings about
> potential uses of uninitialized warnings, but only when optimizing
> for size (-Os). This is the default when building allyesconfig,
> which turns on CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> In order to avoid getting a lot of patches that initialize such
> variables and accidentally hide real errors along the way, let's
> just turn off this warning on the respective gcc versions
> when building with size optimizations. The -Wmaybe-uninitialized
> option was introduced in the same gcc version (4.7) that is now
> causing the false positives, so there is no effect on older compilers.
> 
> A side effect is that when building with CONFIG_CC_OPTIMIZE_FOR_SIZE,
> we might now see /fewer/ warnings about possibly uninitialized
> warnings than with -O2, but that is still much better than seeing
> warnings known to be bogus.

What about truely uninitialized uses of variables?  Will this hide
their warning too?
