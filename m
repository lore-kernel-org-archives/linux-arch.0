From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 2/3] locking/qspinlock: Introduce CNA into the slow path
 of qspinlock
Date: Thu, 31 Jan 2019 12:38:57 -0500
Message-ID: <2c8aabab-1bb0-0708-94c4-305fd860609e@redhat.com>
References: <20190131030136.56999-1-alex.kogan@oracle.com>
 <20190131030136.56999-3-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131030136.56999-3-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

On 01/30/2019 10:01 PM, Alex Kogan wrote:
> In CNA, spinning threads are organized in two queues, a main queue for
> threads running on the same socket as the current lock holder, and a
> secondary queue for threads running on other sockets. For details,
> see https://arxiv.org/abs/1810.05600.
>
> Note that this variant of CNA may introduce starvation by continuously
> passing the lock to threads running on the same socket. This issue
> will be addressed later in the series.
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>

Just wondering if you have tried include PARVIRT_SPINLOCKS option to see
if that patch may screw up the PV qspinlock code.

Anyway, I do believe your claim that NUMA-aware qspinlock is good for
large systems with many nodes. However, all these extra code are
overhead for small systems that have a single node/socket, for instance.

I will support doing something similar to what had been done to support
PV qspinlock. IOW, a separate slowpath function that can be patched to
become the default depending on the system being run on or a kernel boot
option setting.

I would like to keep the core slowpath function simple and easy to
understand. So most of the CNA code should be encapsulated into some
helper functions and put into a separated file.

Thanks,
Longman
