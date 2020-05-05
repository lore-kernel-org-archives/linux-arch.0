Return-Path: <SRS0=wOT8=6T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgEENQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 09:16:29 -0400
Date: Tue, 5 May 2020 14:16:19 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505131619.GG1551@shell.armlinux.org.uk>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
 <20200505130629.GK19710@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505130629.GK19710@willie-the-truck>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, linux-man@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-arm-kernel@lists.infradead.org
Message-ID: <20200505131619.fD7WqxjILv71Vlz7cgMPJ1QYSr_rUP6dLtcWJaPnVck@z>

On Tue, May 05, 2020 at 02:06:30PM +0100, Will Deacon wrote:
> On Tue, May 05, 2020 at 01:43:51PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> > > Michael has been nagging me on and off about that for, what, 10 years now?
> > > I would therefore be very much in favour of having our ptrace extensions
> > > documented!
> > > 
> > > We could even put this stuff under Documentation/arm64/man/ if it's deemed
> > > too CPU-specific for the man-pages project, but my preference would still
> > > be for it to be hosted there alongside all the other man pages.
> > 
> > Stuffing random things into the kernel tree is painful for some people.
> > 
> > For example, if you cross-build your kernel, then the stuff in the
> > tools/ subdirectory is totally useless (I think everything except
> > perf) because you can't build it.
> > 
> > Let's stop making the mistake of constantly shoving stuff into the
> > kernel source tree.
> 
> For userspace tools, I'm inclined to agree, but this is just documentation
> so it shouldn't cause any issues with cross building. But to be clear: I'd
> still prefer it to be part of the man-pages project, and would only consider
> it for inclusion in the kernel tree if it was rejected for being too
> CPU-specific.

I don't think that should be a concern; the man-pages project already
contains documentation that is specific to kernel versions, including
documentation for interfaces that are architecture specific (such as
prctl is a big one, ptrace to a lesser extent.)  syscall(2) contains
a whole bunch of architecture stuff about the calling convention for
syscalls.

Interestingly, I notice that syscall(2) is wrong for arm/OABI. I am
not surprised, because that documentation never came my way, and I am
the author of the kernel's OABI syscall interface.

It claims:

       arch/ABI      arg1  arg2  arg3  arg4  arg5  arg6  arg7  Notes
       ──────────────────────────────────────────────────────────────
       arm/OABI      a1    a2    a3    a4    v1    v2    v3

whereas, at the time I invented it, I decided that it shall pass
arguments in r0 to r6.  That's r0 to r6.  Not the APCS register
names that this document claims.  Not everything in OABI is APCS,
as illustrated here - APCS passes the first four arguments in a1
to a4, and then the rest on the stack.  The OABI syscall interface
doesn't do that.

I guess that's what happens when someone else writes interface
documentation and doesn't bother to get it reviewed by those who
created the interface in the first place.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
