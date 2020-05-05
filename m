From: Will Deacon <will@kernel.org>
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Tue, 5 May 2020 11:44:55 +0100
Message-ID: <20200505104454.GC19710@willie-the-truck>
References: <20200504153214.GH30377@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgEEKpA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 06:45:00 -0400
Content-Disposition: inline
In-Reply-To: <20200504153214.GH30377@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dave,

On Mon, May 04, 2020 at 04:32:35PM +0100, Dave Martin wrote:
> I considering trying to plug some gaps in the arch-specific ABI
> documentation in the linux man-pages, specifically for arm64 (and
> possibly arm, where compat means we have some overlap).
> 
> For arm64, there are now significant new extensions (Pointer
> authentication, SVE, MTE etc.)  Currently there is some user-facing
> documentation mixed in with the kernel-facing documentation in the
> kernel tree, but this situation isn't ideal.
> 
> Do you have an opinion on where in the man-pages documentation should be
> added, and how to structure it?
> 
> 
> Affected areas include:
> 
>  * exec interface
>  * aux vector, hwcaps
>  * arch-specific signals
>  * signal frame
>  * mmap/mprotect extensions
>  * prctl calls
>  * ptrace quirks and extensions
>  * coredump contents
> 
> 
> Not everything has an obvious home in an existing page, and adding
> specifics for every architecture could make some existing manpages very
> unwieldy.
> 
> I think for some arch features, we really need some "overview" pages
> too: just documenting the low-level details is of limited value
> without some guide as to how to use them together.
> 
> 
> Does the following sketch look reasonable?
> 
>  * man7/arm64.7: new page: overview of arm64-specific ABI extensions
> 
>  * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
>    overview of arm64 SVE ABI
> 
>  * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
>    arm64 ptrace extensions

Michael has been nagging me on and off about that for, what, 10 years now?
I would therefore be very much in favour of having our ptrace extensions
documented!

We could even put this stuff under Documentation/arm64/man/ if it's deemed
too CPU-specific for the man-pages project, but my preference would still
be for it to be hosted there alongside all the other man pages.

Will
