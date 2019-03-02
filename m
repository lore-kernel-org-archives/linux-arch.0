Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.11.71.1]:58517 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfCBM4t (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 2 Mar 2019 07:56:49 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/20] Remove Mysterious Macro Intended to Obscure Weird Behaviours (mmiowb())
In-Reply-To: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
References: <20190301140348.25175-1-will.deacon@arm.com> <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Date: Sat, 02 Mar 2019 23:56:44 +1100
Message-ID: <871s3pjuyb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
Message-ID: <20190302125644._YAou-IaTl-VYApgQg09AbOzGvsj_CWCufJ8SphfgSk@z>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Love the acronym, and the series looks good to me.
>
> Michael - can you check (or maybe you already did?) that this works
> for ppc too, and doesn't have any gotcha's?

Yeah it looks fine to me.

I gave it a quick boot with a patch to count how many mb()s we actually
issue in the spin_unlock() path and it's definitely hitting that path
correctly. So it works at least as well as the old code.

cheers
