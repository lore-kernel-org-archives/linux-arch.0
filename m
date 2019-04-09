From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 17/21] drivers: Remove explicit invocations of mmiowb()
Date: Tue, 09 Apr 2019 19:00:52 +1000
Message-ID: <1554798941.svmfd0sejb.astroid@bobo.none>
References: <20190405135936.7266-1-will.deacon@arm.com>
        <20190405135936.7266-18-will.deacon@arm.com>
        <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHk-=wj6ymuXDS1Azr4fFJC7Z77zOfN5vaKZjDzUA4izvULWXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Luis Chamberlain <mcgrof@kernel.org>, Ingo Molnar <mingo@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.e>
List-Id: linux-arch.vger.kernel.org

Linus Torvalds's on April 6, 2019 1:50 am:
> On Fri, Apr 5, 2019 at 4:01 AM Will Deacon <will.deacon@arm.com> wrote:
>>
>> mmiowb() is now implied by spin_unlock() on architectures that require
>> it, so there is no reason to call it from driver code. This patch was
>> generated using coccinelle:
>>
>>         @mmiowb@
>>         @@
>>         - mmiowb();
>=20
> So I love the patch series, and think we should just do it, but I do
> wonder if some of the drivers involved end up relying on memory
> ordering things (store_release -> load_aquire) and IO ordering rather
> than using locking...

Hopefully the convention that smp_ prefix does not work for MMIO
ordering helps there. Drivers relying on that would be broken today
on powerpc, at least.

> Wouldn't such use now be broken on ia64 SN platforms? Do we care?

Hopefully not too much, what changed since last thread? :)

> So it might be worth noting that a lot of the mmiowb()s here weren't
> paired with spin_unlock?

I repeat myself, but the correct change is for ia64 to #define wmb to
mmiowb, then nothing is silently broken, nothing has to be noted, and=20
nobody has to care. The ia64/sn2 platform will run a little slower=20
that's all.

But deliberately breaking sn2 I guess is implicitly acknowledging the=20
same end result that I wanted, so fine.

I think it might be an idea to remove all the mmiowb() that obviously
come before spin_unlock in one big patch, but then submit the rest=20
individually to driver maintainers. I could do that rather than ask
more work from Will, if he and you agree.

Thanks,
Nick

=
