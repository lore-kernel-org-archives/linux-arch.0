Return-Path: <SRS0=qOhU=AN=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41541 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgGBJha (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 05:37:30 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 00/22] add support for Clang LTO
Date: Thu, 2 Jul 2020 09:37:26 +0000
Message-ID: <aeed740a4d86470d84ae7d5f1cf07951@AcuMS.aculab.com>
References: <20200624211540.GS4817@hirez.programming.kicks-ass.net>
 <CAKwvOdmxz91c-M8egR9GdR1uOjeZv7-qoTP=pQ55nU8TCpkK6g@mail.gmail.com>
 <20200625080313.GY4817@hirez.programming.kicks-ass.net>
 <20200625082433.GC117543@hirez.programming.kicks-ass.net>
 <20200625085745.GD117543@hirez.programming.kicks-ass.net>
 <20200630191931.GA884155@elver.google.com>
 <20200630201243.GD4817@hirez.programming.kicks-ass.net>
 <20200630203016.GI9247@paulmck-ThinkPad-P72>
 <20200701091054.GW4781@hirez.programming.kicks-ass.net>
 <4427b0f825324da4b1640e32265b04bd@AcuMS.aculab.com>
 <20200701160624.GO9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200701160624.GO9247@paulmck-ThinkPad-P72>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "'paulmck@kernel.org'" <paulmck@kernel.org>
Cc: 'Peter Zijlstra' <peterz@infradead.org>, Marco Elver <elver@google.com>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Message-ID: <20200702093726.MBAbWdjSm9iHV_tgedYevvX1g5KH7mARxGFVed_2QEA@z>

From: Paul E. McKenney
> Sent: 01 July 2020 17:06
...
> > Would an asm statement that uses the same 'register' for input and
> > output but doesn't actually do anything help?
> > It won't generate any code, but the compiler ought to assume that
> > it might change the value - so can't do optimisations that track
> > the value across the call.
> 
> It might replace the volatile load, but there are optimizations that
> apply to the downstream code as well.
> 
> Or are you suggesting periodically pushing the dependent variable
> through this asm?  That might work, but it would be easier and
> more maintainable to just mark the variable.

Marking the variable requires compiler support.
Although what 'volatile register int foo;' means might be interesting.

So I was thinking that in the case mentioned earlier you do:
	ptr += LAUNDER(offset & 1);
to ensure the compiler didn't convert to:
	if (offset & 1) ptr++;
(Which is probably a pessimisation - the reverse is likely better.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
