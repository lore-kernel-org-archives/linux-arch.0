From: Dave Martin <Dave.Martin@arm.com>
Subject: RFC: Adding arch-specific user ABI documentation in linux-man
Date: Mon, 4 May 2020 16:32:35 +0100
Message-ID: <20200504153214.GH30377@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:47488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbgEDPci (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 11:32:38 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linux-man@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi all,

I considering trying to plug some gaps in the arch-specific ABI
documentation in the linux man-pages, specifically for arm64 (and
possibly arm, where compat means we have some overlap).

For arm64, there are now significant new extensions (Pointer
authentication, SVE, MTE etc.)  Currently there is some user-facing
documentation mixed in with the kernel-facing documentation in the
kernel tree, but this situation isn't ideal.

Do you have an opinion on where in the man-pages documentation should be
added, and how to structure it?


Affected areas include:

 * exec interface
 * aux vector, hwcaps
 * arch-specific signals
 * signal frame
 * mmap/mprotect extensions
 * prctl calls
 * ptrace quirks and extensions
 * coredump contents


Not everything has an obvious home in an existing page, and adding
specifics for every architecture could make some existing manpages very
unwieldy.

I think for some arch features, we really need some "overview" pages
too: just documenting the low-level details is of limited value
without some guide as to how to use them together.


Does the following sketch look reasonable?

 * man7/arm64.7: new page: overview of arm64-specific ABI extensions

 * man7/sve.7 (or man7/arm64-sve.7 or man7/sve.7arm64): new page:
   overview of arm64 SVE ABI

 * man2/arm64-ptrace.2 (or man2/ptrace.2arm64): new page:
   arm64 ptrace extensions

 * man2/mmap.2: extend with arm64-specific flags (only two flags, so we
   add them to the existing man page rather than creating a new one).

etc.


Ideally, I'd like to adopt a pattern that other arches can follow.

Thoughts?

Cheers
---Dave
