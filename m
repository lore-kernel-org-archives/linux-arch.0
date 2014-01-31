From: "George Spelvin" <linux@horizon.com>
Subject: Re: [PATCH v11 0/4] Introducing a queue read/write lock implementation
Date: 31 Jan 2014 05:03:48 -0500
Message-ID: <20140131100348.8867.qmail@science.horizon.com>
References: <20140131092616.GC5126@laptop.programming.kicks-ass.net>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:25893 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932092AbaAaKDu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 31 Jan 2014 05:03:50 -0500
In-Reply-To: <20140131092616.GC5126@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, Waiman.Long@hp.com
Cc: akpm@linux-foundation.org, andi@firstfloor.org, arnd@arndb.de, aswin@hp.com, hpa@zytor.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@horizon.com, mingo@redhat.com, paulmck@linux.vnet.ibm.com, raghavendra.kt@linux.vnet.ibm.com, riel@redhat.com, rostedt@goodmis.org, scott.norton@hp.com, tglx@linutronix.de, tim.c.chen@linux.intel.com, torvalds@linux-foundation.org, walken@google.com, x86@kernel.org

How about getting rid of that TICKET_MSB mess and doing something like:

#define TICKET_MASK	0xFFFF

static inline void ticket_spin_unlock(atomic_t *tickets)
{
	u32 t = *tickets;

	smp_mb__before_atomic_inc();

	/* Increment the low 16 bits without affecting the upper. */
	if (unlikely((~t & TICKET_MASK) == 0))
		atomic_add(-(atomic_t)TICKET_MASK, tickets);
	else
		atomic_inc(tickets);
}

That also allows up to 2^16 waiters, up from 2^15.
(Minus one on both cases, if you want to be fussy.)
