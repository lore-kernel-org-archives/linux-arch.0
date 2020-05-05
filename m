Return-Path: <SRS0=wOT8=6T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbgEEMoO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 08:44:14 -0400
Date: Tue, 5 May 2020 13:43:51 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505124351.GF1551@shell.armlinux.org.uk>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505104454.GC19710@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, linux-man@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20200505124351.yLz9Fsapl1KZ9UQNd5ZxLQkyXGXBApWf5ML6Zi9EIiY@z>

On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> Michael has been nagging me on and off about that for, what, 10 years now?
> I would therefore be very much in favour of having our ptrace extensions
> documented!
> 
> We could even put this stuff under Documentation/arm64/man/ if it's deemed
> too CPU-specific for the man-pages project, but my preference would still
> be for it to be hosted there alongside all the other man pages.

Stuffing random things into the kernel tree is painful for some people.

For example, if you cross-build your kernel, then the stuff in the
tools/ subdirectory is totally useless (I think everything except
perf) because you can't build it.

Let's stop making the mistake of constantly shoving stuff into the
kernel source tree.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
