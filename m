From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 3/3] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 5 Feb 2019 08:48:27 -0500
Message-ID: <16095d28-d3e9-7394-d3c6-1bd24381173d@redhat.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-4-alex.kogan@oracle.com>
 <20190131100009.GB31534@hirez.programming.kicks-ass.net>
 <10672939-5C35-4DEF-AFDE-99E85E0F9C46@oracle.com>
 <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190205092256.GN17528@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On 02/05/2019 04:22 AM, Peter Zijlstra wrote:
> On Mon, Feb 04, 2019 at 10:35:09PM -0500, Alex Kogan wrote:
>>> On Jan 31, 2019, at 5:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>>>
>>> On Wed, Jan 30, 2019 at 10:01:35PM -0500, Alex Kogan wrote:
>>>> Choose the next lock holder among spinning threads running on the same
>>>> socket with high probability rather than always. With small probability,
>>>> hand the lock to the first thread in the secondary queue or, if that
>>>> queue is empty, to the immediate successor of the current lock holder
>>>> in the main queue.  Thus, assuming no failures while threads hold the
>>>> lock, every thread would be able to acquire the lock after a bounded
>>>> number of lock transitions, with high probability.
>>>>
>>>> Note that we could make the inter-socket transition deterministic,
>>>> by sticking a counter of intra-socket transitions in the head node
>>>> of the secondary queue. At the handoff time, we could increment
>>>> the counter and check if it is below a threshold. This adds another
>>>> field to queue nodes and nearly-certain local cache miss to read and
>>>> update this counter during the handoff. While still beating stock,
>>>> this variant adds certain overhead over the probabilistic variant.
>>> (also heavily suffers from the socket == node confusion)
>>>
>>> How would you suggest RT 'tunes' this?
>>>
>>> RT relies on FIFO fairness of the basic spinlock primitives; you just
>>> completely wrecked that.
>> This is true that CNA trades some fairness for shorter lock handover
>> latency, much like any other NUMA-aware lock.
>>
>> Can you explain, however, what exactly breaks here?
> Timeliness guarantees. FIFO-fair has well defined time behaviour; you
> know exactly how long you get to wait before you acquire the lock,
> namely however many waiters are in front of you multiplied by the worst
> case wait time.
>
> Doing time analysis on a randomized algorithm isn't my idea of fun.

RT doesn't work well with NUMA qspinlock is another reason why I want it
to be a separate slow path. We will disable it  on a RT kernel where
guaranteed low latency is a must and throughput isn't as important.

Cheers,
Longman
