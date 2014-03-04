From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Tue, 4 Mar 2014 19:09:09 +0100
Message-ID: <20140304180909.GO3104@twins.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<5310BB81.3090508@hp.com>
	<20140303174305.GK9987@twins.programming.kicks-ass.net>
	<20140304165800.GN3104@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140304165800.GN3104@twins.programming.kicks-ass.net>
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

On Tue, Mar 04, 2014 at 05:58:00PM +0100, Peter Zijlstra wrote:
>  2:  17141.324050        2:    620.185930        2:    618.737681

So I forgot that AMD has compute units that share L2:

root@interlagos:~/spinlocks# export LOCK=./ticket ; ($LOCK 0 1 ; $LOCK 0 2) | awk '/^total/ { print $2 }'
982.938839
1325.702905
root@interlagos:~/spinlocks# export LOCK=./qspinlock-pending-opt2 ; ($LOCK 0 1 ; $LOCK 0 2) | awk '/^total/ { print $2 }'
630.684313
999.119087
root@interlagos:~/spinlocks# export LOCK=./waiman ; ($LOCK 0 1 ; $LOCK 0 2) | awk '/^total/ { print $2 }'
620.562791
1644.700639


Doing the same for Intel SMT, which shares L1:


root@westmere:~/spinlocks# export LOCK=./ticket ; ($LOCK 0 12 ; $LOCK 0 1) | awk '/^total/ { print $2 }'
45.765302
1292.721827
root@westmere:~/spinlocks# export LOCK=./qspinlock-pending-opt2 ; ($LOCK 0 12 ; $LOCK 0 1) | awk '/^total/ { print $2 }'
54.536890
1260.467527
root@westmere:~/spinlocks# export LOCK=./waiman ; ($LOCK 0 12 ; $LOCK 0 1) | awk '/^total/ { print $2 }'
65.944794
1230.522895
