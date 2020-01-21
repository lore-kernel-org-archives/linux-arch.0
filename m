From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v8 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Tue, 21 Jan 2020 10:45:48 -0500
Message-ID: <cfdf635d-be2e-9d4b-c4ca-6bcbddc6868f@redhat.com>
References: <20191230194042.67789-1-alex.kogan@oracle.com>
 <20191230194042.67789-5-alex.kogan@oracle.com>
 <20200121132949.GL14914@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121132949.GL14914@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
List-Id: linux-arch.vger.kernel.org

On 1/21/20 8:29 AM, Peter Zijlstra wrote:
> On Mon, Dec 30, 2019 at 02:40:41PM -0500, Alex Kogan wrote:
>
>> +/*
>> + * Controls the threshold for the number of intra-node lock hand-offs before
>> + * the NUMA-aware variant of spinlock is forced to be passed to a thread on
>> + * another NUMA node. By default, the chosen value provides reasonable
>> + * long-term fairness without sacrificing performance compared to a lock
>> + * that does not have any fairness guarantees. The default setting can
>> + * be changed with the "numa_spinlock_threshold" boot option.
>> + */
>> +int intra_node_handoff_threshold __ro_after_init = 1 << 16;
> There is a distinct lack of quantitative data to back up that
> 'reasonable' claim there.
>
> Where is the table of inter-node latencies observed for the various
> values tested, and on what criteria is this number deemed reasonable?
>
> To me, 64k lock hold times seems like a giant number, entirely outside
> of reasonable.

I actually had similar question before, but having the capability of
changing the default with boot time parameter alleviate some of my
concern. I will certainly like to see actual data on how different
values will affect the performance of the code.

Cheers,
Longman
