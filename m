From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v12 09/11] pvqspinlock,
	x86: Add para-virtualization support
Date: Fri, 24 Oct 2014 16:53:27 -0400
Message-ID: <544ABC47.2000700@hp.com>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
	<1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
	<20141024084738.GU21513@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20141024084738.GU21513@worktop.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On 10/24/2014 04:47 AM, Peter Zijlstra wrote:
> On Thu, Oct 16, 2014 at 02:10:38PM -0400, Waiman Long wrote:
>> +static inline void pv_init_node(struct mcs_spinlock *node)
>> +{
>> +	struct pv_qnode *pn = (struct pv_qnode *)node;
>> +
>> +	BUILD_BUG_ON(sizeof(struct pv_qnode)>  5*sizeof(struct mcs_spinlock));
>> +
>> +	if (!pv_enabled())
>> +		return;
>> +
>> +	pn->cpustate = PV_CPU_ACTIVE;
>> +	pn->mayhalt  = false;
>> +	pn->mycpu    = smp_processor_id();
>> +	pn->head     = PV_INVALID_HEAD;
>> +}
>
>> @@ -333,6 +393,7 @@ queue:
>>   	node += idx;
>>   	node->locked = 0;
>>   	node->next = NULL;
>> +	pv_init_node(node);
>>
>>   	/*
>>   	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
>
> So even if !pv_enabled() the compiler will still have to emit the code
> for that inline, which will generate additional register pressure,
> icache pressure and lovely stuff like that.
>
> The patch I had used pv-ops for these things that would turn into NOPs
> in the regular case and callee-saved function calls for the PV case.
>
> That still does not entirely eliminate cost, but does reduce it
> significant. Please consider using that.

The additional register pressure may just cause a few more register 
moves which should be negligible in the overall performance . The 
additional icache pressure, however, may have some impact on 
performance. I was trying to balance the performance of the pv and 
non-pv versions so that we won't penalize the pv code too much for a bit 
more performance in the non-pv code. Doing it your way will add a lot of 
function call and register saving/restoring to the pv code.

Another alternative that I can think of is to generate 2 versions of the 
slowpath code - one pv and one non-pv out of the same source code. The 
non-pv code will call into the pv code once if pv is enabled. In this 
way, it won't increase the icache and register pressure of the non-pv 
code. However, this may make the source code a bit harder to read.

Please let me know your thought on this alternate approach.

-Longman
