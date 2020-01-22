Return-Path: <SRS0=lDRc=3L=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:51800 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730891AbgAVJwQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jan 2020 04:52:16 -0500
Date: Wed, 22 Jan 2020 10:51:27 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200122095127.GC14946@hirez.programming.kicks-ass.net>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20200122095127.YJnFcJa2OnIIxjkln9SwNLOJXFByq50P2ZELHkzkRlE@z>

On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> 
> various notes and changes in the below.

Also, sorry for replying to v7 and v8, I forgot to refresh email on the
laptop and had spotty cell service last night and only found v7 in that
mailbox.

Afaict none of the things I commented on were fundamentally changed
though.
