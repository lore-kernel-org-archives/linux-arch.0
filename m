Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:3753 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764189AbYBWVHy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 23 Feb 2008 16:07:54 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1044681wah.23
        for <linux-arch@vger.kernel.org>; Sat, 23 Feb 2008 13:07:54 -0800 (PST)
Message-ID: <b647ffbd0802231307h68a34f9buba004be3505d19d3@mail.gmail.com>
Date: Sat, 23 Feb 2008 22:07:53 +0100
From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: + kthread-add-a-missing-memory-barrier-to-kthread_stop.patch added to -mm tree
In-Reply-To: <alpine.LFD.1.00.0802231202380.21332@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200802230733.m1N7XnMu018253@imap1.linux-foundation.org>
	 <20080223162705.GA7686@tv-sign.ru>
	 <alpine.LFD.1.00.0802230937530.21332@woody.linux-foundation.org>
	 <20080223182258.GA19946@tv-sign.ru>
	 <alpine.LFD.1.00.0802231044240.21332@woody.linux-foundation.org>
	 <b647ffbd0802231151w481fdcb5hc2a3972e7fd03f69@mail.gmail.com>
	 <alpine.LFD.1.00.0802231202380.21332@woody.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, a.p.zijlstra@chello.nl, apw@shadowen.org, Ingo Molnar <mingo@elte.hu>, nickpiggin@yahoo.com.au, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org

On 23/02/2008, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>  On Sat, 23 Feb 2008, Dmitry Adamushko wrote:
>  >
>  > it's not a LOAD that escapes *out* of the region. It's a MODIFY that gets *in*:
>
>
> Not with the smp_wmb(). That's the whole point.
>
>  Ie the patch I'm suggesting is sufficient is appended, and the point is
>  that any write before the critical region will be ordered wrt the critical
>  region because of the write barrier before the spinlock (which itself is a
>  write).

Yeah, good point!

(heh... I wouldn't dare to say this 'obvious thing' only to Anton
Blanchard who is "the only person who always 'have a point' by
definition" :-))

> This is also why I mentioned that if you have a really odd architecure
> that considers spinlocks to be "outside" the normal cache coherency
> domain, that would be broken, but I cannot think of a single valid case of
> that, and I consider it insane.

Yeah, some potential implementations come into my mind but, I guess,
they are as far away from real hardware as science-fiction from
science :-/

So how should we proceed with this issue?

let's use your patch and declare try_to_wake_up() a 'full' mb for the case:

MODIFY
try_to_wake_up
LOAD or MODIFY (that take place either after or inside try_to_wake_up())

so we'll fix (lots of) potentially problematic cases with a single shot.

and

LOAD
try_to_wake_up()
LOAD or MODIFY

is probably not that common so we don't care.


-- 
Best regards,
Dmitry Adamushko
