From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
Date: Fri, 5 Apr 2019 05:50:32 -1000
Message-ID: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
References: <20190405135936.7266-1-will.deacon@arm.com> <20190405135936.7266-18-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405135936.7266-18-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Mikulas Patocka <mpatocka@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
>
> mmiowb() is now implied by spin_unlock() on architectures that require
> it, so there is no reason to call it from driver code. This patch was
> generated using coccinelle:
>
>         @mmiowb@
>         @@
>         - mmiowb();

So I love the patch series, and think we should just do it, but I do
wonder if some of the drivers involved end up relying on memory
ordering things (store_release -> load_aquire) and IO ordering rather
than using locking...

Wouldn't such use now be broken on ia64 SN platforms? Do we care?

So it might be worth noting that a lot of the mmiowb()s here weren't
paired with spin_unlock?

                    Linus
