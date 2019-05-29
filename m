Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:58832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfE2MBe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 08:01:34 -0400
Date: Wed, 29 May 2019 14:01:18 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 3/3] asm-generic, x86: Add bitops instrumentation for
 KASAN
Message-ID: <20190529120118.GQ2623@hirez.programming.kicks-ass.net>
References: <20190528163258.260144-1-elver@google.com>
 <20190528163258.260144-3-elver@google.com>
 <20190528165036.GC28492@lakrids.cambridge.arm.com>
 <CACT4Y+bV0CczjRWgHQq3kvioLaaKgN+hnYEKCe5wkbdngrm+8g@mail.gmail.com>
 <CANpmjNNtjS3fUoQ_9FQqANYS2wuJZeFRNLZUq-ku=v62GEGTig@mail.gmail.com>
 <20190529100116.GM2623@hirez.programming.kicks-ass.net>
 <CANpmjNMvwAny54udYCHfBw1+aphrQmiiTJxqDq7q=h+6fvpO4w@mail.gmail.com>
 <20190529103010.GP2623@hirez.programming.kicks-ass.net>
 <CACT4Y+aVB3jK_M0-2D_QTq=nncVXTsNp77kjSwBwjqn-3hAJmA@mail.gmail.com>
 <a0157a8d778a48b7ba3935f3e6840d30@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0157a8d778a48b7ba3935f3e6840d30@AcuMS.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Dmitry Vyukov' <dvyukov@google.com>, Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Andrey Konovalov <andreyknvl@google.com>, Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>
Message-ID: <20190529120118.gSx-YuLM-CbclIfikcM0KM6kfLl2wL9zhIwcB2Jx0jM@z>

On Wed, May 29, 2019 at 11:20:56AM +0000, David Laight wrote:
> From: Dmitry Vyukov
> > Sent: 29 May 2019 11:57

> > Interesting. Does an address passed to bitops also should be aligned,
> > or alignment is supposed to be handled by bitops themselves?
> 
> The bitops are defined on 'long []' and it is expected to be aligned.
> Any code that casts the argument is likely to be broken on big-endian.
> I did a quick grep a few weeks ago and found some very dubious code.
> Not all the casts seemed to be on code that was LE only (although
> I didn't try to find out what the casts were from).
> 
> The alignment trap on x86 could be avoided by only ever requesting 32bit
> cycles - and assuming the buffer is always 32bit aligned (eg int []).
> But on BE passing an 'int []' is just so wrong ....

Right, but as argued elsewhere, I feel we should clean up the dubious
code instead of enabling it.
