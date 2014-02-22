From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
Date: Sat, 22 Feb 2014 17:56:13 +0100
Message-ID: <20140222165613.GA30098@gmail.com>
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com>
 <53029167.4060109@zytor.com>
 <20140218073825.GY27965@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:56434 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbaBVQ4V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Feb 2014 11:56:21 -0500
Content-Disposition: inline
In-Reply-To: <20140218073825.GY27965@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Feb 17, 2014 at 02:47:03PM -0800, H. Peter Anvin wrote:
> > This is starting to look good, so I have pulled it into
> > tip:x86/spinlocks to start give it some testing mileage.
> 
> Its still atrociously ugly code please drop it.

Fair enough - I've excluded it from tip:master for now, until the 
uglies get resolved.

Waiman: please address PeterZ's feedback.

Thanks,

	Ingo
