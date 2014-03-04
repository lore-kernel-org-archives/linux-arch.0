From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization
	for 2 contending tasks
Date: Tue, 04 Mar 2014 09:54:05 -0500
Message-ID: <5315E90D.4020801@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-4-git-send-email-Waiman.Long@hp.com>
	<20140302131638.GB13206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140302131638.GB13206@redhat.com>
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

On 03/02/2014 08:16 AM, Oleg Nesterov wrote:
> On 02/26, Waiman Long wrote:
>> @@ -144,7 +317,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
>>   	int qlcode = atomic_read(lock->qlcode);
>>
>>   	if (!(qlcode&  _QSPINLOCK_LOCKED)&&  (atomic_cmpxchg(&lock->qlcode,
>> -		qlcode, qlcode|_QSPINLOCK_LOCKED) == qlcode))
>> +		qlcode, code|_QSPINLOCK_LOCKED) == qlcode))
> Hmm. didn't read the patch, but this change looks like accidental typo...
>
> Oleg.
>

Thank for catching that typo error. That generic code wasn't compiled in 
and so I missed it. I will fix that in the next version.

-Longman
