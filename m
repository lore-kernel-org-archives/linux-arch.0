From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 01/20] asm-generic/mmiowb: Add generic implementation of mmiowb() tracking
Date: Mon, 04 Mar 2019 12:01:08 +1100
Message-ID: <87d0n7bgh7.fsf@concordia.ellerman.id.au>
References: <20190301140348.25175-1-will.deacon@arm.com> <20190301140348.25175-2-will.deacon@arm.com> <1551575210.6lwpiqtg5k.astroid@bobo.none> <87tvgkia0k.fsf@concordia.ellerman.id.au> <1551607531.yk1v9azmym.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551607531.yk1v9azmym.astroid@bobo.none>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, Daniel Lustig <dlustig@nvidia.com>, linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@linux-mips.org>, Ingo Molnar <mingo@kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Paul Burton <paul.burton@mips.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Alan Stern <stern@rowland.harvard.edu>, Tony Luck <tony.luck@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

Nicholas Piggin <npiggin@gmail.com> writes:
> Michael Ellerman's on March 3, 2019 7:26 pm:
>> Nicholas Piggin <npiggin@gmail.com> writes:
...
>>> what was broken about the powerpc one, which is basically:
>>>
>>> static inline void mmiowb_set_pending(void)
>>> {
>>> 	struct mmiowb_state *ms = __mmiowb_state();
>>> 	ms->mmiowb_pending = 1;
>>> }
>>>
>>> static inline void mmiowb_spin_lock(void)
>>> {
>>> }
>> 
>> The current powerpc code clears io_sync in spin_lock().
>> 
>> ie, it would be equivalent to:
>> 
>> static inline void mmiowb_spin_lock(void)
>> {
>>  	ms->mmiowb_pending = 0;
>> }
>
> Ah okay that's what I missed. How about we just not do that?

Yeah I thought of that too but it's not great. We'd start semi-randomly
executing the sync in unlock depending on whether someone had done IO on
that CPU prior to the spinlock.

eg.

	writel(x, y);		// sets paca->io_sync
	...	

	<schedule>

	spin_lock(a);
        ...
        // No IO in here
        ...
        spin_unlock(a);		// sync() here because other task did writel().


Which wouldn't be *incorrect*, but would be kind of weird.

cheers
