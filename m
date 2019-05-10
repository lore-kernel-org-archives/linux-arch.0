Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44720 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfEJIQk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 04:16:40 -0400
Date: Fri, 10 May 2019 17:16:35 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] vsprintf: Do not break early boot with probing addresses
Message-ID: <20190510081635.GA4533@jagdpanzerIV>
References: <20190509121923.8339-1-pmladek@suse.com>
 <20190510043200.GC15652@jagdpanzerIV>
 <CAHk-=wiP+hwSqEW0dM6AYNWUR7jXDkeueq69et6ahfUgV7hC3w@mail.gmail.com>
 <20190510050709.GA1831@jagdpanzerIV>
 <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510080602.mdfk54f6lpyg6unw@pathway.suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "Tobin C . Harding" <me@tobin.cc>, Michal Hocko <mhocko@suse.cz>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Russell Currey <ruscur@russell.cc>, Christophe Leroy <christophe.leroy@c-s.fr>, Stephen Rothwell <sfr@ozlabs.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <20190510081635.P7Yubfnbogddj2izcJVf-xe5Orm1qEA_EodGti4mdQs@z>

On (05/10/19 10:06), Petr Mladek wrote:
[..]
> I am going to send a patch replacing probe_kernel_address() with
> a simple check:
> 
> 	if ((unsigned long)ptr < PAGE_SIZE || IS_ERR_VALUE(ptr))
> 		return "(efault)";

I'm OK with this.
Probing ptrs was a good idea, it just didn't work out.

	-ss
