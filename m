From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization
	for 2 contending tasks
Date: Tue, 04 Mar 2014 12:48:26 -0500
Message-ID: <531611EA.6020200@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
	<20140303174305.GK9987@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140303174305.GK9987@twins.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org

Peter,

I was trying to implement the generic queue code exchange code using
cmpxchg as suggested by you. However, when I gathered the performance
data, the code performed worse than I expected at a higher contention
level. Below were the execution time of the benchmark tool that I sent
you:

                 [xchg]        [cmpxchg]
   # of tasks    Ticket lock     Queue lock      Queue Lock
   ----------    -----------     -----------     ----------
        1          135            135              135
        2          732           1315            1102
        3         1827           2372            2681
        4         2689           2934             5392
        5         3736           3658             7696
        6         4942           4434            9876
        7         6304           5176           11901
        8         7736           5955           14551

Below is the code that I used:

static inline u32 queue_code_xchg(struct qspinlock *lock, u32 *ocode, 
u32 ncode)
{
         while (true) {
                 u32 qlcode = atomic_read(&lock->qlcode);

                 if (qlcode == 0) {
                         /*
                          * Try to get the lock
                          */
                         if (atomic_cmpxchg(&lock->qlcode, 0,
                                            _QSPINLOCK_LOCKED) == 0)
                                 return 1;
                 } else if (qlcode & _QSPINLOCK_LOCKED) {
                         *ocode = atomic_cmpxchg(&lock->qlcode, qlcode,
                                                 ncode | _QSPINLOCK_LOCKED);
                         if (*ocode == qlcode) {
                                 /* Clear lock bit before return */
                                 *ocode &= ~_QSPINLOCK_LOCKED;
                                 return 0;
                         }
                 }
                 /*
                  * Wait if atomic_cmpxchg() fails or lock is 
temporarily free.
                  */
                 arch_mutex_cpu_relax();
         }
}

My cmpxchg code is not optimal, and I can probably tune the code to
make it perform better. Given the trend that I was seeing, however,
I think I will keep the current xchg code, but I will package it in
an inline function.

-Longman
