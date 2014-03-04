From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 2/8] qspinlock, x86: Enable x86-64 to use queue spinlock
Date: Tue, 04 Mar 2014 10:06:07 -0500
Message-ID: <5315EBDF.90304@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-3-git-send-email-Waiman.Long@hp.com>
	<20140302141058.GA15629@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140302141058.GA15629@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

On 03/02/2014 09:10 AM, Oleg Nesterov wrote:
> On 02/26, Waiman Long wrote:
>> +#define _ARCH_SUPPORTS_ATOMIC_8_16_BITS_OPS
>> +
>> +/*
>> + * x86-64 specific queue spinlock union structure
>> + */
>> +union arch_qspinlock {
>> +	struct qspinlock slock;
>> +	u8		 lock;	/* Lock bit	*/
>> +};
> And this enables the optimized version of queue_spin_setlock().
>
> But why does it check ACCESS_ONCE(qlock->lock) == 0 ? This is called
> right after queue_get_lock_qcode() returns 0, this locked should be
> likely unlocked.
>
> Oleg.
>

Yes, the read check in queue_spin_setlock is probably redundant. Will 
remove that.

-Longman
