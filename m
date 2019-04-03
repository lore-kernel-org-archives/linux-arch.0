Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:43680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfDCQKN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Apr 2019 12:10:13 -0400
Date: Wed, 3 Apr 2019 18:10:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190403161003.GL4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <20190401090653.GF11158@hirez.programming.kicks-ass.net>
 <20190401093345.GA14281@hirez.programming.kicks-ass.net>
 <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7A8A6827-BF79-47FC-99A1-C9EE00D9C3B1@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alex Kogan <alex.kogan@oracle.com>
Cc: linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, longman@redhat.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190403161003.Ps2EuP8TMsB8A4DHYjSXrhM1wiIMm6ZsC7cYN1_9XdQ@z>

On Wed, Apr 03, 2019 at 11:53:53AM -0400, Alex Kogan wrote:

> > One thing we could maybe do is change locked and count to u8, then your
> > overlay structure could be something like:
> > 
> > struct mcs_spinlock {
> > 	struct mcs_spinlock *next;
> > 	u8 locked;
> > 	u8 count;
> > };
> I was trying to keep the size of the mcs_spinlock structure for the non-NUMA variant unchanged.
> If this is not a huge concern, changing the fields as above would indeed simplify a few things.

Well, sizeof(struct mcs_spinlock) is unchanged by the above proposal
(for x86_64).

And I don't think it matters for x86, which is very good at byte
accesses, my only concern would be for other architectures that might
not be as good at byte accesses. For instance Alpha <EV56 would generate
shit code, but then, Alpha isn't using qspinlock anyway.
