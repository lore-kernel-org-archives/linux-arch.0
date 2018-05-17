Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:47325 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751367AbeEQGkb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 17 May 2018 02:40:31 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC PATCH] UAPI: Document auxvec AT_* namespace policy and note reservations
In-Reply-To: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
References: <1526480447-18185-1-git-send-email-Dave.Martin@arm.com>
Date: Thu, 17 May 2018 16:40:19 +1000
Message-ID: <8736yqokdo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Michal Simek <monstr@monstr.eu>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <albert@sifive.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>
Message-ID: <20180517064019.qdKZ8DG6SM-T__MsRmR-PD0ejUJdiYcNvnWDpmdW_z8@z>

Dave Martin <Dave.Martin@arm.com> writes:

> There are constraints on defining AT_* auxvec tags that are not
> obvious to the casual maintainer of either the global
> <uapi/linux/auxvec.h> or the arch-specific headers.  This is likely
> to lead to mistakes.  (I certainly fell foul of it...)

Thanks for cleaning this up.

It looks like us (powerpc) / me is the main offender here.

My excuse is it was glibc folk who asked us to add all those new AT_
entries in the first place. </buckpassing>

> For the benefit of future maintainers, this patch collects the
> relevant information in one place, documenting how the namespace
> needs to be managed, and noting all the values currently in use.
>
> Maintaining a global list may result in some merge conflicts, but
> AT_* values are not added frequently.  I'm open to suggestions on
> the best approach.

Yeah I agree with Rich that having a global list would be best. That is
the most reliable to make people think twice about adding new entries.

> I also assume that values 38 and 39 may have been used for
> historical purposes, such as an architecture that is no longer
> supported.  If they have definitely never been used for anything,
> they could be removed from the "reserved" list.

I don't know why we added the new entries starting at 40, maybe Ben
remembers. Quite likely it was just an accident.

I don't see any sign of 38 or 39 in glibc history.

cheers
