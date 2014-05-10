From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 07/19] qspinlock: Use a simple write to grab the lock,
	if applicable
Date: Fri, 09 May 2014 21:05:25 -0400
Message-ID: <536D7B55.6030208@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-8-git-send-email-Waiman.Long@hp.com>
	<20140508190004.GO2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508190004.GO2844@laptop.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 05/08/2014 03:00 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:35AM -0400, Waiman Long wrote:
>> @@ -94,23 +94,29 @@ static inline struct mcs_spinlock *decode_tail(u32 tail)
>>    * can allow better optimization of the lock acquisition for the pending
>>    * bit holder.
>>    */
>> -#if _Q_PENDING_BITS == 8
>> -
>>   struct __qspinlock {
>>   	union {
>>   		atomic_t val;
>> -		struct {
>>   #ifdef __LITTLE_ENDIAN
>> +		u8	 locked;
>> +		struct {
>>   			u16	locked_pending;
>>   			u16	tail;
>> +		};
>>   #else
>> +		struct {
>>   			u16	tail;
>>   			u16	locked_pending;
>> -#endif
>>   		};
>> +		struct {
>> +			u8	reserved[3];
>> +			u8	locked;
>> +		};
>> +#endif
>>   	};
>>   };
>>
>> +#if _Q_PENDING_BITS == 8
> That doesn't make sense, that struct __qspinlock only makes sense when
> _Q_PENDING_BITS == 8.

I need to use the locked field (the 2nd strcut) in get_qlock() where I 
grab the lock by setting the lock byte directly. Since the endian-aware 
structure is already in place, I reused it and have to expose it even 
when _Q_PENDING_BITS isn't 8. I will document that more clearly in the 
code to avoid this confusion.

-Longman
