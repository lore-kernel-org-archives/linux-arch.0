From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/3] qspinlock: Introducing a 4-byte queue spinlock
 implementation
Date: Tue, 18 Feb 2014 08:30:52 +0100
Message-ID: <20140218073052.GV27965@twins.programming.kicks-ass.net>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com>
 <1392669684-4807-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:36342 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbaBRHbp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2014 02:31:45 -0500
Content-Disposition: inline
In-Reply-To: <1392669684-4807-2-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On Mon, Feb 17, 2014 at 03:41:22PM -0500, Waiman Long wrote:
> +/*
> + * The queue node structure
> + *
> + * This structure is essentially the same as the mcs_spinlock structure
> + * in mcs_spinlock.h file. This structure is retained for future extension
> + * where new fields may be added.
> + */
> +struct qnode {
> +	u32		 wait;		/* Waiting flag		*/
> +	struct qnode	*next;		/* Next queue node addr */
> +};
> +
> +struct qnode_set {
> +	int		node_idx;	/* Current node to use */
> +	struct qnode	nodes[MAX_QNODES];
> +};
> +
> +/*
> + * Per-CPU queue node structures
> + */
> +static DEFINE_PER_CPU(struct qnode_set, qnset) ____cacheline_aligned
> +	= { 0 };

You really didn't pay attention did you.

That should be DEFINE_PER_CPU_ALIGNED()

Furthermore, your structure is bigger than 1 cacheline; your struct
qnode is 16 bytes, 4*16=64, and then you add that int.
