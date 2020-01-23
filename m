Return-Path: <SRS0=XOKs=3M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53952 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728792AbgAWUjL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 15:39:11 -0500
Subject: Re: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
From: Waiman Long <longman@redhat.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-5-alex.kogan@oracle.com>
 <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
Message-ID: <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
Date: Thu, 23 Jan 2020 15:39:00 -0500
MIME-Version: 1.0
In-Reply-To: <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com
Message-ID: <20200123203900.OaGj49Js_CazipUu1GWrgZoYrSufzPXq6SbSheL32tc@z>

On 1/23/20 2:55 PM, Waiman Long wrote:
> Playing with lock event counts, I would like you to change the meaning
> intra_count parameter that you are tracking. Instead of tracking the
> number of times a lock is passed to a waiter of the same node
> consecutively, I would like you to track the number of times the head
> waiter in the secondary queue has given up its chance to acquire the
> lock because a later waiter has jumped the queue and acquire the lock
> before it. This value determines the worst case latency that a secondary
> queue waiter can experience. So

Well, that is not strictly true as a a waiter in the middle of the
secondary queue can go back and fro between the queues for a number of
times. Of course, if we can ensure that when a FLUSH_SECONDARY_QUEUE is
issued, those waiters that were in the secondary queue won't be put back
into the secondary queue again. The parameter will then really determine
the worst case latency.

One way to do it is to store the tail of the secondary queue into the
CNA node and passed it down the queue until it matches the current
encoded tail. That will require changing both numa_node and intra_count
into u16 to squeeze out space for another u32.

That will also make the code a bit easier to analyze.

Cheers,
Longman
