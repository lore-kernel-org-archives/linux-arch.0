From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/20] Remove Mysterious Macro Intended to Obscure Weird Behaviours (mmiowb())
Date: Sat, 02 Mar 2019 23:56:44 +1100
Message-ID: <871s3pjuyb.fsf@concordia.ellerman.id.au>
References: <20190301140348.25175-1-will.deacon@arm.com> <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wio4duTk=dPJZ+yW-Y-65Q4O8Hc09bexAqs4OQV1R3WhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>
List-Id: linux-arch.vger.kernel.org

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
