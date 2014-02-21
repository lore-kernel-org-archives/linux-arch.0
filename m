From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 3/3] qspinlock, x86: Add x86 specific optimization for
 2 contending tasks
Date: Fri, 21 Feb 2014 18:28:11 +0100
Message-ID: <20140221172811.GS9987@twins.programming.kicks-ass.net>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com>
 <1392669684-4807-4-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:44442 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255AbaBUR2f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2014 12:28:35 -0500
Content-Disposition: inline
In-Reply-To: <1392669684-4807-4-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>

On Mon, Feb 17, 2014 at 03:41:24PM -0500, Waiman Long wrote:
> +	struct {
> +		u8  lock;	/* Lock bit	*/
> +		u8  wait;	/* Waiting bit	*/
> +		u16 qcode;	/* Queue code	*/
> +	};

16 bit code would result in 14 bits for the CPU number, that's only 16k,
I think SGI actually had a machine with that many CPUs in.
