Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:34856 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfGQHpF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jul 2019 03:45:05 -0400
Date: Wed, 17 Jul 2019 09:44:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190717074435.kyiD6R7D8VxfypAYH3peNCcfNwwvMs-PkRXqnTCg4mo@z>

On Tue, Jul 16, 2019 at 10:16:29PM -0400, Waiman Long wrote:
>  A simple graphic to illustrate those queues will help too, for example

Very much yes!

> /*
>  * MCS lock holder
>  * ===============
>  *    mcs_node
>  *   +--------+      +----+         +----+
>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>  *   | locked | -+   +----+         +----+
>  *   +--------+  |
>  *               |   +----+         +----+
>  *               +-> |next| -> ...  |next| -> X     [Secondary queue]
>  *    cna_node       +----+         +----+
>  *   +--------*                       ^
>  *   | tail   | ----------------------+
>  *   +--------*   

Almost; IIUC that cna_node is the same as the one from locked, so you
end up with something like:

>  *    mcs_node
>  *   +--------+      +----+         +----+
>  *   | next   | ---> |next| -> ...  |next| -> NULL  [Main queue]
>  *   | locked | -+   +----+         +----+
>  *   +--------+  |
>  *               |   +---------+         +----+
>  *               +-> |mcs::next| -> ...  |next| -> NULL     [Secondary queue]
>  *                   |cna::tail| -+      +----+
>  *                   +---------+  |        ^
>  *                                +--------+
>  *
>  * N.B. locked = 1 if secondary queue is absent.
>  */
