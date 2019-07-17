Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54742 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726494AbfGQNft (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Jul 2019 09:35:49 -0400
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
 <20190717074435.GU3419@hirez.programming.kicks-ass.net>
From: Waiman Long <longman@redhat.com>
Message-ID: <378093ad-46cc-7ecb-5a06-1e22ee5ce4a1@redhat.com>
Date: Wed, 17 Jul 2019 09:35:46 -0400
MIME-Version: 1.0
In-Reply-To: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717133546.9-ULFXky-kTOBQqZb86SpJ4pyZHdZub_eu45CW3gxbg@z>

On 7/17/19 3:44 AM, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 10:16:29PM -0400, Waiman Long wrote:
>>  A simple graphic to illustrate those queues will help too, for example
> Very much yes!
>
>> /*
>>  * MCS lock holder
>>  * ===============
>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +----+         +----+
>>  *               +-> |next| -> ...  |next| -> X     [Secondary queue]
>>  *    cna_node       +----+         +----+
>>  *   +--------*                       ^
>>  *   | tail   | ----------------------+
>>  *   +--------*   
> Almost; IIUC that cna_node is the same as the one from locked, so you
> end up with something like:
>
>>  *    mcs_node
>>  *   +--------+      +----+         +----+
>>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>>  *   | locked | -+   +----+         +----+
>>  *   +--------+  |
>>  *               |   +---------+         +----+
>>  *               +-> |mcs::next| -> ...  |next| -> NULL     [Secondary queue]
>>  *                   |cna::tail| -+      +----+
>>  *                   +---------+  |        ^
>>  *                                +--------+
>>  *
>>  * N.B. locked = 1 if secondary queue is absent.
>>  */

Yes, you are right. Thanks for the correction.

Cheers,
Longman
