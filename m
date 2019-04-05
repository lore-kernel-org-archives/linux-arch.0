From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 00/21] Remove Mysterious Macro Intended to Obscure
 Weird Behaviours (mmiowb())
Date: Fri, 5 Apr 2019 06:15:12 -1000
Message-ID: <CAHk-=wiBQwAL5hoLD9-EmCAf1N9CUmUkuj_jJhUCsboNLy-uLw@mail.gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com> <CAHk-=wiarqZVH52VuKDiPk7Jqf1H-znf-NMoGkKnM7H08VN5fg@mail.gmail.com>
 <20190405160919.GA7857@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405160919.GA7857@fuggles.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 5, 2019 at 6:09 AM Will Deacon <will.deacon@arm.com> wrote:
> >
> > Or did I miss something? I think the ia64() mb/rmb/wmb stuff only
> > works on normal memory on ia64.
>
> I was worried about RISC-V, but actually their wmb() is "fence ow,ow"
> which I think is stronger than their mmiowb() "fence o,w" implementation.

Also with smp_store_release -> smp_load_acquire kind of ordering?

Again, this is not at all a NAK - I think we should do this - just
perhaps a request to add a note to the commit and make people aware of
the issue.

I suspect very few drivers use non-locking serialization to begin with.

                 Linus
