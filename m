Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36439 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753522Ab3COSNj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 14:13:39 -0400
Date: Fri, 15 Mar 2013 18:12:46 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Fwd: [PATCH] Turn off -Wmaybe-uninitialized when building with
	-Os
Message-ID: <20130315181246.GW4977@n2100.arm.linux.org.uk>
References: <201303151455.38917.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201303151455.38917.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, inux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-ID: <20130315181246.TZyn-DxU5EpzTz3hXTV6_O5gZP0oyRKyUg2RjvvNXEk@z>

On Fri, Mar 15, 2013 at 02:55:38PM +0000, Arnd Bergmann wrote:
> I forgot to put the linux-kbuild list on Cc, that is probably the
> best place to discuss this patch.
> 
> ----------  Forwarded Message  ----------
> 
> Subject: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
> Date: Thursday 14 March 2013
> From: Arnd Bergmann <arnd@arndb.de>
> To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
> 
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
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: stable@vger.kernel.org
> --
> I'd like to merge this for 3.9 and also for the stable kernels,
> if people agree this is a good idea.

I think I replied to your previous version recently asking whether
this affects real uninitialized variables too.
