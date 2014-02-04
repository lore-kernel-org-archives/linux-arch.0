From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: mips octeon memory model questions
Date: Tue, 4 Feb 2014 11:16:58 -0800
Message-ID: <CA+55aFwiuE+WbNLdeV8sGqZccoXkjg_VFOJ+xKMZUgbFP_sKZw@mail.gmail.com>
References: <20140204184150.GB5002@laptop.programming.kicks-ass.net>
	<CA+55aFz9+AtK_OnUhH0gspUsXLxZN-MRwKVR5zVPsVGmGpBqxg@mail.gmail.com>
	<20140204190535.GC5002@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54763 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbaBDTQ7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 4 Feb 2014 14:16:59 -0500
In-Reply-To: <20140204190535.GC5002@laptop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Daney <ddaney@caviumnetworks.com>, Ralf Baechle <ralf@linux-mips.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>

On Tue, Feb 4, 2014 at 11:05 AM, Peter Zijlstra
>
>> So writes move down, not up.
>
> Right, but the ll-sc store might move down over a later store.

Unlikely. The thing is, in order for the sc to succeed, it has to
already have hit the cache coherency domain (or at least reserved it -
ie maybe the value is not actually *in* the cache, but the sc needs to
have gotten exclusive access to the cacheline).

So just how do you expect a later store (that is *after* the
conditional branch that tests the result of the sc) to move up before
it?

I'm not saying it's physically impossible: speculation is always
possible. But it would require some rather clever speculative store
buffers or caches and killing of same when mispredicted. Which is
actually fairly unlikely, since stores are seldom - if ever - in the
critical path. IOW, "lots and lots of effort for very little gain".

So I'm personally quite willing to believe that a
sc+conditional-branch+st is quite well ordered without any extra
barriers. I'd be more worried about *reads* moving up past the sc
("doesn't reorder reads" to me would imply not moving across the "ll"
part, but it's quite likely that the "sc" actually counts as both a
read and a write).

Without any visible documentation (see aforementioned "clown company"
comment) all of this is obviously just pure speculation.

              Linus
