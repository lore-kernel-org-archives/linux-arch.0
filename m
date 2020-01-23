From: Alex Kogan <alex.kogan@oracle.com>
Subject: Re: [PATCH v9 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Thu, 23 Jan 2020 18:39:36 -0500
Message-ID: <1B2B46E9-651E-4BA5-988A-924AE3E72C00@oracle.com>
References: <20200115035920.54451-1-alex.kogan@oracle.com>
 <20200115035920.54451-5-alex.kogan@oracle.com>
 <f5e31716-d687-f64c-0fc5-f1c9b539c4ff@redhat.com>
 <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:56632 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729288AbgAWXkd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2020 18:40:33 -0500
In-Reply-To: <5f865b62-4867-2c7b-715a-0605759e647f@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com

> On Jan 23, 2020, at 3:39 PM, Waiman Long <longman@redhat.com> wrote:
>=20
> On 1/23/20 2:55 PM, Waiman Long wrote:
>> Playing with lock event counts, I would like you to change the =
meaning
>> intra_count parameter that you are tracking. Instead of tracking the
>> number of times a lock is passed to a waiter of the same node
>> consecutively, I would like you to track the number of times the head
>> waiter in the secondary queue has given up its chance to acquire the
>> lock because a later waiter has jumped the queue and acquire the lock
>> before it.
Isn=E2=80=99t that the same thing? Note that we keep track of the number =
of=20
intra-node lock transfers only when the secondary queue is not empty.

>> This value determines the worst case latency that a secondary
>> queue waiter can experience. So
>=20
> Well, that is not strictly true as a a waiter in the middle of the
> secondary queue can go back and fro between the queues for a number of
> times. Of course, if we can ensure that when a FLUSH_SECONDARY_QUEUE =
is
> issued, those waiters that were in the secondary queue won't be put =
back
> into the secondary queue again.
This will not work as intended when we have more than 2 nodes. That is, =
if we
have threads from node A & B in the secondary queue, and then the queue
is flushed and its head (say, from node A) gets the lock, we want to =
push=20
threads from node B back into the secondary queue, to keep the lock on =
node A.

And if we have only 2 nodes, a waiter in the middle of the secondary =
queue will=20
never go back into the secondary queue, even if the threshold is small.=20=

This is because we flush the secondary queue by putting all its waiters =
in
the front of the main queue, and the secondary queue will remain empty =
at least
until we reach a thread from another node.

Regards,
=E2=80=94 Alex=
