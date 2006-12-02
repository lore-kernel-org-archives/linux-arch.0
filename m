Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpout.mac.com ([17.250.248.186]:56516 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1162858AbWLBJYA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Dec 2006 04:24:00 -0500
In-Reply-To: <20061201172149.GC3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6911A3DA-83C4-4BE9-8553-3E960026BF51@mac.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] timers, pointers to functions and type safety
Date: Sat, 2 Dec 2006 04:23:32 -0500
Sender: linux-arch-owner@vger.kernel.org
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
List-ID: <linux-arch.vger.kernel.org>

On Dec 01, 2006, at 12:21:49, Al Viro wrote:
> And that's where it gets interesting.  It would be very nice to get to
> the following situation:
>  * callbacks are void (*)(void *)
>  * data is void *
>  * instances can take void * or pointer to object type
>  * a macro SETUP_TIMER(timer, func, data) sets callback and data  
> and checks if func(data) would be valid.

This is where a very limited form of C++ templates would do nicely;  
you could define something like the following:

template <typename T>
static inline void setup_timer(struct timer_list *timer,
		void (*function)(T *), T *data)
{
	timer->function = (void (*)(void *))function;
	timer->data = (void *)data;
	init_timer(timer);
}

Any attempts to call it with mismatched "function" and "data"  
arguments would display an "Unable to find matching template" error  
from the compiler.

Unfortunately you can't get simple templated functions without  
opening the whole barrel of monkeys involved with C++ support;  
including an explosion of reserved words, a 400% or more increase in  
compilation time, a decrease in the efficiency of parts of the  
generated code, etc.

<crazy-talk>
Maybe it's time for Linux to fork GCC and morph C99 into a language  
whose design more fundamentally supports the kinds of type-checking  
and static verification that we keep adding to the kernel, including  
some of the things that sparse, lockdep, kmemleak, etc. do.
</crazy-talk>

Cheers,
Kyle Moffett
