Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36608 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733037AbfGPLFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 16 Jul 2019 07:05:40 -0400
Date: Tue, 16 Jul 2019 13:05:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190716110518.GQ3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715192536.104548-4-alex.kogan@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190716110518.zHKUweY8T5aYHdX0ItBWo-dcPEeFsHxbr8GEqa2CaZE@z>

On Mon, Jul 15, 2019 at 03:25:34PM -0400, Alex Kogan wrote:
> +/**
> + * find_successor - Scan the main waiting queue looking for the first
> + * thread running on the same node as the lock holder. If found (call it
> + * thread T), move all threads in the main queue between the lock holder
> + * and T to the end of the secondary queue and return T; otherwise, return NULL.
> + */
> +static struct cna_node *find_successor(struct mcs_spinlock *me)

Either don't use a kernel doc comment, but if you must, you have to
stick to their format, otherwise we'll get endless stupid patches fixing
up the stupid comment.
