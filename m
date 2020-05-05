From: Will Deacon <will@kernel.org>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Tue, 5 May 2020 14:06:30 +0100
Message-ID: <20200505130629.GK19710@willie-the-truck>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEENGe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 09:06:34 -0400
Content-Disposition: inline
In-Reply-To: <20200505124351.GF1551@shell.armlinux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, linux-man@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, May 05, 2020 at 01:43:51PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> > Michael has been nagging me on and off about that for, what, 10 years now?
> > I would therefore be very much in favour of having our ptrace extensions
> > documented!
> > 
> > We could even put this stuff under Documentation/arm64/man/ if it's deemed
> > too CPU-specific for the man-pages project, but my preference would still
> > be for it to be hosted there alongside all the other man pages.
> 
> Stuffing random things into the kernel tree is painful for some people.
> 
> For example, if you cross-build your kernel, then the stuff in the
> tools/ subdirectory is totally useless (I think everything except
> perf) because you can't build it.
> 
> Let's stop making the mistake of constantly shoving stuff into the
> kernel source tree.

For userspace tools, I'm inclined to agree, but this is just documentation
so it shouldn't cause any issues with cross building. But to be clear: I'd
still prefer it to be part of the man-pages project, and would only consider
it for inclusion in the kernel tree if it was rejected for being too
CPU-specific.

Will
