From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Date: Wed, 01 Apr 2015 14:54:45 -0400
Message-ID: <551C3EF5.6090809@hp.com>
References: <20150316131613.720617163@infradead.org>
	<20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com>
	<20150319101242.GM21418@twins.programming.kicks-ass.net>
	<20150319122536.GD11574@worktop.ger.corp.intel.com>
	<551C1ACE.4090408@hp.com>
	<20150401171223.GO23123@twins.programming.kicks-ass.net>
	<20150401174239.GO24151@twins.programming.kicks-ass.net>
	<20150401181744.GE32047@worktop.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150401181744.GE32047@worktop.ger.corp.intel.com>
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
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, konrad.wilk@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On 04/01/2015 02:17 PM, Peter Zijlstra wrote:
> On Wed, Apr 01, 2015 at 07:42:39PM +0200, Peter Zijlstra wrote:
>>> Hohumm.. time to think more I think ;-)
>> So bear with me, I've not really pondered this well so it could be full
>> of holes (again).
>>
>> After the cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL) succeeds the
>> spin_unlock() must do the hash lookup, right? We can make the lookup
>> unhash.
>>
>> If the cmpxchg() fails the unlock will not do the lookup and we must
>> unhash.
> The idea being that the result is that any lookup is guaranteed to find
> an entry, which reduces our worst case lookup cost to whatever the worst
> case insertion cost was.
>

I think it doesn't matter who did the unhashing. Multiple independent 
locks can be hashed to the same value. Since they can be unhashed 
independently, there is no way to know whether you have checked all the 
possible buckets.

-Longman
