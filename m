From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Tue, 4 Mar 2014 23:40:43 +0100
Message-ID: <20140304224043.GQ9987@twins.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
	<20140303174305.GK9987@twins.programming.kicks-ass.net>
	<531611EA.6020200@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <531611EA.6020200@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutro>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 04, 2014 at 12:48:26PM -0500, Waiman Long wrote:
> Peter,
> 
> I was trying to implement the generic queue code exchange code using
> cmpxchg as suggested by you. However, when I gathered the performance
> data, the code performed worse than I expected at a higher contention
> level. Below were the execution time of the benchmark tool that I sent
> you:
> 
>                 [xchg]        [cmpxchg]
>   # of tasks    Ticket lock     Queue lock      Queue Lock
>   ----------    -----------     -----------     ----------
>        1          135            135              135
>        2          732           1315            1102
>        3         1827           2372            2681
>        4         2689           2934             5392
>        5         3736           3658             7696
>        6         4942           4434            9876
>        7         6304           5176           11901
>        8         7736           5955           14551
> 

I'm just not seeing that; with test-4 modified to take the AMD compute
units into account:

root@interlagos:~/spinlocks# LOCK=./qspinlock-pending-opt ./test-4.sh ; LOCK=./qspinlock-pending-opt2 ./test-4.sh
 4: 50783.509653
 8: 146295.875715
16: 332942.964709
 4: 51033.341441
 8: 146320.656285
16: 332586.355194

And the difference between opt and opt2 is that opt2 replaces 2 cmpxchg
loops with unconditional ops (xchg8 and xchg16).

And I'd think that 4 CPUs x 4 Nodes would be heavy contention.

I'll have another poke tomorrow; including verifying asm tomorrow, need
to go sleep now.
