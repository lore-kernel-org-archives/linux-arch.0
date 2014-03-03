From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v5 4/8] pvqspinlock, x86: Allow unfair spinlock in
	a real PV environment
Date: Mon, 03 Mar 2014 11:55:41 +0100
Message-ID: <53145FAD.3020905@redhat.com>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-5-git-send-email-Waiman.Long@hp.com>
	<20140226170734.GB20775@phenom.dumpdata.com>
	<5310C21F.7000809@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5310C21F.7000809@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Scott J Norton <scott.norton@hp.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Daniel J Blueman <daniel@numascale.com>, Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Cheg
List-Id: linux-arch.vger.kernel.org

Il 28/02/2014 18:06, Waiman Long ha scritto:
> On 02/26/2014 12:07 PM, Konrad Rzeszutek Wilk wrote:
>> On Wed, Feb 26, 2014 at 10:14:24AM -0500, Waiman Long wrote:
>>> Locking is always an issue in a virtualized environment as the virtual
>>> CPU that is waiting on a lock may get scheduled out and hence block
>>> any progress in lock acquisition even when the lock has been freed.
>>>
>>> One solution to this problem is to allow unfair lock in a
>>> para-virtualized environment. In this case, a new lock acquirer can
>>> come and steal the lock if the next-in-line CPU to get the lock is
>>> scheduled out. Unfair lock in a native environment is generally not a
>> Hmm, how do you know if the 'next-in-line CPU' is scheduled out? As
>> in the hypervisor knows - but you as a guest might have no idea
>> of it.
>
> I use a heart-beat counter to see if the other side responses within a
> certain time limit. If not, I assume it has been scheduled out probably
> due to PLE.

PLE is unnecessary if you have "true" pv spinlocks where the 
next-in-line schedules itself out with a hypercall (Xen) or hlt 
instruction (KVM).  Set a bit in the qspinlock before going to sleep, 
and the lock owner will know that it needs to kick the next-in-line.

I think there is no need for the unfair lock bits.  1-2% is a pretty 
large hit.

Paolo
