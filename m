From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization
	for 2 contending tasks
Date: Tue, 04 Mar 2014 10:27:03 -0500
Message-ID: <5315F0C7.8090909@hp.com>
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

On 03/03/2014 12:43 PM, Peter Zijlstra wrote:
> Hi,
>
> Here are some numbers for my version -- also attached is the test code.
> I found that booting big machines is tediously slow so I lifted the
> whole lot to userspace.
>
> I measure the cycles spend in arch_spin_lock() + arch_spin_unlock().
>
> The machines used are a 4 node (2 socket) AMD Interlagos, and a 2 node
> (2 socket) Intel Westmere-EP.
>
> AMD (ticket)		AMD (qspinlock + pending + opt)
>
> Local:                  Local:
>
> 1:    324.425530        1:    324.102142
> 2:  17141.324050        2:    620.185930
> 3:  52212.232343        3:  25242.574661
> 4:  93136.458314        4:  47982.037866
> 6: 167967.455965        6:  95345.011864
> 8: 245402.534869        8: 142412.451438
>
> 2 - nodes:              2 - nodes:
>
> 2:  12763.640956        2:   1879.460823
> 4:  94423.027123        4:  48278.719130
> 6: 167903.698361        6:  96747.767310
> 8: 257243.508294        8: 144672.846317
>
> 4 - nodes:              4 - nodes:
>
>   4:  82408.853603        4:  49820.323075
>   8: 260492.952355        8: 143538.264724
> 16: 630099.031148       16: 337796.553795
>
>
>
> Intel (ticket)		Intel (qspinlock + pending + opt)
>
> Local:                  Local:
>
> 1:    19.002249         1:    29.002844
> 2:  5093.275530         2:  1282.209519
> 3: 22300.859761         3: 22127.477388
> 4: 44929.922325         4: 44493.881832
> 6: 86338.755247         6: 86360.083940
>
> 2 - nodes:              2 - nodes:
>
> 2:   1509.193824        2:   1209.090219
> 4:  48154.495998        4:  48547.242379
> 8: 137946.787244        8: 141381.498125
>
> ---
>
> There a few curious facts I found (assuming my test code is sane).
>
>   - Intel seems to be an order of magnitude faster on uncontended LOCKed
>     ops compared to AMD
>
>   - On Intel the uncontended qspinlock fast path (cmpxchg) seems slower
>     than the uncontended ticket xadd -- although both are plenty fast
>     when compared to AMD.
>
>   - In general, replacing cmpxchg loops with unconditional atomic ops
>     doesn't seem to matter a whole lot when the thing is contended.
>
> Below is the (rather messy) qspinlock slow path code (the only thing
> that really differs between our versions.
>
> I'll try and slot your version in tomorrow.
>
> ---
>

It is curious to see that the qspinlock code offers a big benefit on AMD 
machines, but no so much on Intel. Anyway, I am working on a revised 
version of the patch that includes some of your comments. I will also 
try to see if I can get an AMD machine to run test on.

-Longman
