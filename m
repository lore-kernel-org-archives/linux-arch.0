From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Writes, smp_wmb(), and transitivity?
Date: Tue, 16 Feb 2016 10:59:08 -0800
Message-ID: <CA+55aFxaQEvDrzecmZUQ5QfKzU4ei6E-+NpsW5hYp3ouaLP98g@mail.gmail.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35268 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932584AbcBPS7I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 13:59:08 -0500
In-Reply-To: <20160215175825.GA15878@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc: Will Deacon <will.deacon@arm.com>, Andy.Glew@imgtec.com, Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, Peter Zijlstra <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-metag@vger.kernel.org, linux-mips <linux-mips@linux-mips.org>, linux-xtensa@linux-xtensa.org, ppc-dev <linuxppc-dev@lists.ozlabs.org>, graham.whaley@gmail.com, Peter Anvin <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>

On Mon, Feb 15, 2016 at 9:58 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> Two threads:
>
>         int a, b;
>
>         void thread0(void)
>         {
>                 WRITE_ONCE(a, 1);
>                 smp_wmb();
>                 WRITE_ONCE(b, 2);
>         }
>
>         void thread1(void)
>         {
>                 WRITE_ONCE(b, 1);
>                 smp_wmb();
>                 WRITE_ONCE(a, 2);
>         }
>
>         /* After all threads have completed and the dust has settled... */
>
>         BUG_ON(a == 1 && b == 1);

So the more I look at that kind of litmus test, the less I think that
we should care, because I can't come up with a scenario in where that
kind of test makes sense. without even a possibility of any causal
relationship between the two, I can't say why we'd ever care about the
ordering of the (independent) writes to the individual variables.

If somebody can make up a causal chain, things differ. But as long as
all the CPU's are just doing locally ordered writes, I don't think we
need to care about a global store ordering.

              Linus
