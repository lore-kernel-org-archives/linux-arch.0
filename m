Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:33262 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQOnT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 10:43:19 -0400
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
From: Alex Kogan <alex.kogan@oracle.com>
In-Reply-To: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Date: Wed, 17 Jul 2019 10:42:26 -0400
Content-Transfer-Encoding: quoted-printable
Message-ID: <779FC7D4-67CE-4D22-8154-FC108479935F@oracle.com>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
 <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717144226.G_z3VhX0OknJZrvPLWbFxJEoD0gE7Vek4ODbRrTFzYA@z>


>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +---------+         +----+
>>  *               +-> |mcs::next| -> ...  |next| -> NULL     =
[Secondary queue]
>> *                   |cna::tail| -+      +----+
>>  *                   +---------+  |        ^
>> *                                +--------+
>>  *
>>  * N.B. locked =3D 1 if secondary queue is absent.
>>  */


I would change mcs_node to cna_node, next to mcs::next and locked to =
mcs::locked
in the very first node. Other than that, this is great. Thanks, Peter =
and Longman!

I should probably stick this graphic in the comment at the top of the =
file,=20
instead of a comment to find_successor() (or whatever this function ends =
up=20
being called).

=E2=80=94 Alex
