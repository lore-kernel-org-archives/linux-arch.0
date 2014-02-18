Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38338 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754559AbaBRHpr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 18 Feb 2014 02:45:47 -0500
Message-ID: <53030E46.3060908@zytor.com>
Date: Mon, 17 Feb 2014 23:39:50 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com> <53029167.4060109@zytor.com> <20140218073111.GW27965@twins.programming.kicks-ass.net>
In-Reply-To: <20140218073111.GW27965@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Message-ID: <20140218073950.48KsjYQ1i5Q_U1YF_FBzo3QoIKfo-VvCOFwnTGfpJgQ@z>

On 02/17/2014 11:31 PM, Peter Zijlstra wrote:
>>
>> This is starting to look good, so I have pulled it into
>> tip:x86/spinlocks to start give it some testing mileage.
> 
> It very much needs paravirt muck before we can even consider it.
> 

Ah yes.  Joy ... I so love PV.

	-hpa

