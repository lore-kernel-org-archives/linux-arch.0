From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH RFC v5 4/8] pvqspinlock, x86: Allow unfair spinlock in
	a real PV environment
Date: Thu, 27 Feb 2014 14:40:13 -0500
Message-ID: <530F949D.6050609@hp.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-5-git-send-email-Waiman.Long@hp.com>
	<530F2F7B.40500@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <530F2F7B.40500@citrix.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Vrabel <david.vrabel@citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/27/2014 07:28 AM, David Vrabel wrote:
> On 26/02/14 15:14, Waiman Long wrote:
>> Locking is always an issue in a virtualized environment as the virtual
>> CPU that is waiting on a lock may get scheduled out and hence block
>> any progress in lock acquisition even when the lock has been freed.
>>
>> One solution to this problem is to allow unfair lock in a
>> para-virtualized environment. In this case, a new lock acquirer can
>> come and steal the lock if the next-in-line CPU to get the lock is
>> scheduled out. Unfair lock in a native environment is generally not a
>> good idea as there is a possibility of lock starvation for a heavily
>> contended lock.
> I'm not sure I'm keen on losing the fairness in PV environment.  I'm
> concerned that on an over-committed host, the lock starvation problem
> will be particularly bad.
>
> But I'll have to revist this once a non-broken PV qspinlock
> implementation exists (or someone explains how the proposed one works).
>
> David

On second thought, the unfair qspinlock may not be as bad as other 
unfair locks. Basically, a task gets one chance to steal the lock. If it 
can't, it will go to the back of the queue and wait for its turn. So 
unless a single CPU can monopolize a lock by acquiring it again 
immediately after release, all the tasks queuing up will eventually has 
its chance of getting the lock.

-Longman
