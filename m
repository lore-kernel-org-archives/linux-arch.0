From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Fri, 18 Apr 2014 13:52:50 -0400
Message-ID: <53516672.3010701@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
	<20140417155649.GR11096@twins.programming.kicks-ass.net>
	<53504BB3.4010009@hp.com>
	<20140418082716.GZ11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140418082716.GZ11096@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 04/18/2014 04:27 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 05:46:27PM -0400, Waiman Long wrote:
>> On 04/17/2014 11:56 AM, Peter Zijlstra wrote:
>>> On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
>>>> +struct __qspinlock {
>>>> +	union {
>>>> +		atomic_t val;
> 		char bytes[4];
>
>>>> +		struct {
>>>> +#ifdef __LITTLE_ENDIAN
>>>> +			u16	locked_pending;
>>>> +			u16	tail;
>>>> +#else
>>>> +			u16	tail;
>>>> +			u16	locked_pending;
>>>> +#endif
>>>> +		};
> 		struct {
> #ifdef __LITTLE_ENDIAN
> 			u8	locked;
> #else
> 			u8	res[3];
> 			u8	locked;
> #endif
> 		};
>
>>>> +	};
>>>> +};
>>>> +
>>>> +/**
>>>> + * clear_pending_set_locked - take ownership and clear the pending bit.
>>>> + * @lock: Pointer to queue spinlock structure
>>>> + * @val : Current value of the queue spinlock 32-bit word
>>>> + *
>>>> + * *,1,0 ->   *,0,1
>>>> + */
>>>> +static __always_inline void
>>>> +clear_pending_set_locked(struct qspinlock *lock, u32 val)
>>>> +{
>>>> +	struct __qspinlock *l = (void *)lock;
>>>> +
>>>> +	ACCESS_ONCE(l->locked_pending) = 1;
>>> You lost the __constant_le16_to_cpu(_Q_LOCKED_VAL) there. The
>>> unconditional 1 is wrong. You also have to flip the bytes in
>>> locked_pending.
>> I don't think that is wrong. The lock byte is in the least significant 8
>> bits and the pending byte is the next higher significant 8 bits irrespective
>> of the endian-ness. So a value of 1 in a 16-bit context means the lock byte
>> is set, but the pending byte is cleared. The name "locked_pending" doesn't
>> mean that locked variable is in a lower address than pending.
> val            is LE bytes[0,1,2,3] BE [3,2,1,0]
> locked_pending is LE bytes[0,1]     BE     [1,0]
> locked            LE bytes[0]       BE       [0]
>
> That does mean that the LSB of BE locked_pending is bytes[1].
> So if you do BE: locked_pending = 1, you set bytes[1], not bytes[0].

I am confused by your notation. Anyway, my version of the byte location 
chart is:

val            is LE bytes[0,1,2,3]    BE [0,1,2,3]
locked_pending is LE bytes[0,1]        BE     [2,3]
locked         is LE bytes[0]          BE       [3]

If we assign 1 to BE locked_pending, bytes[2] = 0 and bytes[3] = 1. Note 
that the LSB of the BE locked_pending is bytes[3]. Similarly, if we 
assign 1 to BE val, bytes[3] = 1 and all the other bytes will be 0.

-Longman
