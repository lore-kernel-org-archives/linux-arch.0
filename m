Return-Path: <SRS0=wOT8=6T=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mx01-sz.bfs.de ([194.94.69.67]:44441 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgEEHpf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 May 2020 03:45:35 -0400
From: Walter Harms <wharms@bfs.de>
Subject: AW: Adding arch-specific user ABI documentation in linux-man
Date: Tue, 5 May 2020 07:45:32 +0000
Message-ID: <32259f3763344500a058a8ca8a3a33d8@bfs.de>
References: <20200504153214.GH30377@arm.com>
In-Reply-To: <20200504153214.GH30377@arm.com>
Content-Language: de-DE
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Message-ID: <20200505074532.9Z0yZc8U70wXXANbDE8xhqann8GiP6tZM6Ya62A3IM8@z>

Hi Dave,
you are pointing to an (IMHO) interesting question.
How to document different CPUs ?
Given that an operating system should hide the different CPU's using
CPU specific features should be used sparsely at best.

the easy part are adds-on like flags for prctrl etc. simply add it to the p=
age.

Other things should go to a cpu specific pages (can of worms). The problem =
will
be to keep that small but informative. I have no idea about the level of de=
tail
(and i have worked with a range of CPUs) that could be interesting for a pr=
ogrammer.
An of cause every other CPU now needs also a page.

jm2c
 wh
________________________________________
Von: linux-man-owner@vger.kernel.org <linux-man-owner@vger.kernel.org> im A=
uftrag von Dave Martin <Dave.Martin@arm.com>
Gesendet: Montag, 4. Mai 2020 17:32:35
An: Michael Kerrisk
Cc: Catalin Marinas; Will Deacon; Vincenzo Frascino; linux-man@vger.kernel.=
org; linux-arch@vger.kernel.org; linux-arm-kernel@lists.infradead.org
Betreff: RFC: Adding arch-specific user ABI documentation in linux-man

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
