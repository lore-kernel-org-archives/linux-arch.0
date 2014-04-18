From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 04/19] qspinlock: Extract out the exchange of tail
	code word
Date: Fri, 18 Apr 2014 13:32:47 -0400
Message-ID: <535161BF.90405@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-5-git-send-email-Waiman.Long@hp.com>
	<20140417154902.GO11096@twins.programming.kicks-ass.net>
	<53504771.9070102@hp.com>
	<20140418081517.GY11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140418081517.GY11096@twins.programming.kicks-ass.net>
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

On 04/18/2014 04:15 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 05:28:17PM -0400, Waiman Long wrote:
>> On 04/17/2014 11:49 AM, Peter Zijlstra wrote:
>>> On Thu, Apr 17, 2014 at 11:03:56AM -0400, Waiman Long wrote:
>>>> @@ -192,36 +220,25 @@ void queue_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>>>>   	node->next = NULL;
>>>>
>>>>   	/*
>>>> +	 * We touched a (possibly) cold cacheline; attempt the trylock once
>>>> +	 * more in the hope someone let go while we weren't watching as long
>>>> +	 * as no one was queuing.
>>>>   	 */
>>>> +	if (!(val&   _Q_TAIL_MASK)&&   queue_spin_trylock(lock))
>>>> +		goto release;
>>> But you just did a potentially very expensive op; @val isn't
>>> representative anymore!
>> That is not true. I pass in a pointer to val to trylock_pending() (the
>> pointer thing) so that it will store the latest value that it reads from the
>> lock back into val. I did miss one in the PV qspinlock exit loop. I will add
>> it back when I do the next version.
> But you did that read _before_ you touched a cold cacheline, that's 100s
> of cycles. Whatever value you read back then is now complete nonsense.

For spin_lock(), the lock cacheline is touched by a cmpxchg(). It can 
takes 100s of cycles whether it is hot or cold.

I will take the precheck out, it is not such a big deal anyway.

-Longman
