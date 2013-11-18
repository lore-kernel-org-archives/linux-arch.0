From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v6 3/5] qrwlock: Enable fair queue read/write lock
Date: Mon, 18 Nov 2013 10:38:13 -0800
Message-ID: <CA+55aFyH_BUrrzft-1JGZ5zL=KxGrUESBBOZnzT=nQm6Ld0V+Q@mail.gmail.com>
References: <1384267735-43213-1-git-send-email-Waiman.Long@hp.com>
	<1384267735-43213-5-git-send-email-Waiman.Long@hp.com>
	<CA+55aFxXu7eC1WGfZ=_JQbLLJHM5HYRkJPjm3jBDC51SL66Ecw@mail.gmail.com>
	<20131118183433.GB29695@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:35222 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3KRSiQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2013 13:38:16 -0500
In-Reply-To: <20131118183433.GB29695@two.firstfloor.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>

On Mon, Nov 18, 2013 at 10:34 AM, Andi Kleen <andi@firstfloor.org> wrote:
>
> FWIW unfair can be faster in some cases. It depends on the workload.

Sure. And we've never cared before.

When we switched over to the ticket spinlocks, we actually had
*numbers* about how the old unfair spinlocks could be faster. And we
still didn't leave a "unfair spinlocks" option. Because it didn't make
sense.

Why would it make sense here?

                Linus
