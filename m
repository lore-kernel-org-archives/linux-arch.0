Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:8364 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbaAWRrn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jan 2014 12:47:43 -0500
Message-ID: <52E155A8.7000206@hp.com>
Date: Thu, 23 Jan 2014 12:47:20 -0500
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v10 1/4] qrwlock: A queue read/write lock implementation
References: <1390426438-31252-1-git-send-email-Waiman.Long@hp.com> <1390426438-31252-2-git-send-email-Waiman.Long@hp.com> <20140123100751.GS30183@twins.programming.kicks-ass.net> <52E14D67.4000202@hp.com> <CA+55aFzhx6K9A62ve6E5X4juvNPewED_g1nWwq+-EY0fd0A-0g@mail.gmail.com>
In-Reply-To: <CA+55aFzhx6K9A62ve6E5X4juvNPewED_g1nWwq+-EY0fd0A-0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, "Chandramouleeswaran, Aswin" <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>
Message-ID: <20140123174720.VBcEBQmon80eZgFzYi6BW55JpJy3XScZpY6U_pihlO0@z>

On 01/23/2014 12:15 PM, Linus Torvalds wrote:
> On Thu, Jan 23, 2014 at 9:12 AM, Waiman Long<waiman.long@hp.com>  wrote:
>> I thought that all atomic RMW instructions are memory barrier.
> On x86 they are. Not necessarily elsewhere.
>
>> If they are not, what kind of barrier should be added?
> smp_mb__before_atomic_xyz() and smp_mb__after_atomic_xyz() will do it,
> and are no-op (well, barriers - I don't think it matters) on x86.
>
>              Linus
> -

Thank for the info. I am less familiar with that kind of issues on other 
architecture. I will add a smp_mb__after_atomic_dec() & send out a new 
patch.

-Longman
