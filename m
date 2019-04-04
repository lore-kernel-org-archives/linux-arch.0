Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53550 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729287AbfDDJjQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 05:39:16 -0400
Date: Thu, 4 Apr 2019 11:38:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20190404093859.GU4038@hirez.programming.kicks-ass.net>
References: <20190329152006.110370-1-alex.kogan@oracle.com>
 <20190329152006.110370-4-alex.kogan@oracle.com>
 <60a3a2d8-d222-73aa-2df1-64c9d3fa3241@redhat.com>
 <20190402094320.GM11158@hirez.programming.kicks-ass.net>
 <6AEDE4F2-306A-4DF9-9307-9E3517C68A2B@oracle.com>
 <20190403160112.GK4038@hirez.programming.kicks-ass.net>
 <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf4ffdd-b0d9-e18b-d394-2d1c19811dc5@suse.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Juergen Gross <jgross@suse.com>
Cc: Alex Kogan <alex.kogan@oracle.com>, Waiman Long <longman@redhat.com>, linux@armlinux.org.uk, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
Message-ID: <20190404093859.aO0z4QIrlrgM2cl2CI2KNvmrFUR1NA-AnpabFPOQino@z>

On Thu, Apr 04, 2019 at 07:05:24AM +0200, Juergen Gross wrote:

> Without PARAVIRT_SPINLOCK this would be just an alternative() then?

That could maybe work yes. This is all early enough.

> Maybe the resulting code would be much more readable if we'd just
> make PARAVIRT_SPINLOCK usable without the other PARAVIRT hooks? So
> splitting up PARAVIRT into PARAVIRT_GUEST (timer hooks et al) and
> the patching infrastructure, with PARAVIRT_GUEST and PARAVIRT_SPINLOCK
> selecting PARAVIRT, and PARAVIRT_XXL selecting PARAVIRT_GUEST.

Well, ideally we'll get static_call() sorted and use that.
