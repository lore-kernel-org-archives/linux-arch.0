From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Thu, 13 Mar 2014 15:03:01 -0400
Message-ID: <532200E5.2050107@hp.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>
	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>
	<53218E7A.8090707@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53218E7A.8090707@citrix.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu>
List-Id: linux-arch.vger.kernel.org

On 03/13/2014 06:54 AM, David Vrabel wrote:
> On 12/03/14 18:54, Waiman Long wrote:
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
> I do not think this is a good idea -- the problems with unfair locks are
> worse in a virtualized guest.  If a waiting VCPU deschedules and has to
> be kicked to grab a lock then it is very likely to lose a race with
> another running VCPU trying to take a lock (since it takes time for the
> VCPU to be rescheduled).

I have seen figure that it will take about 1000 cycles to kick in a CPU. 
As long as the critical section isn't that long, there is enough time 
for a lock stealer to come in, grab the lock, do whatever it needs to do 
and leave without introducing too much latency to the kicked-in CPU.

Anyway there are people who ask for unfair lock. In fact, RHEL6 ship a 
virtual guest with unfair lock. So I provide an option for those people 
who want unfair lock to enable it in their virtual guest. For those who 
don't want it, they can always turn them off when building the kernel.

>> With the unfair locking activated on bare metal 4-socket Westmere-EX
>> box, the execution times (in ms) of a spinlock micro-benchmark were
>> as follows:
>>
>>    # of    Ticket       Fair	    Unfair
>>    tasks    lock     queue lock    queue lock
>>    ------  -------   ----------    ----------
>>      1       135        135	     137
>>      2      1045       1120	     747
>>      3      1827       2345     	    1084
>>      4      2689       2934	    1438
>>      5      3736       3658	    1722
>>      6      4942       4434	    2092
>>      7      6304       5176          2245
>>      8      7736       5955          2388
> Are these figures with or without the later PV support patches?

This is without the PV patch.

Regards,
Longman
