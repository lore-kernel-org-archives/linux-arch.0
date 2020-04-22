Return-Path: <SRS0=8toe=6G=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54711 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgDVLsi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Apr 2020 07:48:38 -0400
Date: Wed, 22 Apr 2020 06:48:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading from scalar types
Message-ID: <20200422114807.GW26902@gate.crashing.org>
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-9-will@kernel.org> <6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@android.com, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
Message-ID: <20200422114807.e1JIGL0d2paJ1MM1XRTg35Nb0Rt4mn9Qo4gYcSM-Wx8@z>

Hi!

On Wed, Apr 22, 2020 at 12:25:03PM +0200, Rasmus Villemoes wrote:
> On 21/04/2020 17.15, Will Deacon wrote:
> > Unfortunately, dropping pointer qualifiers inside the macro poses quite
> > a challenge, especially since the pointed-to type is permitted to be an
> > aggregate, and this is relied upon by mm/ code accessing things like
> > 'pmd_t'. Based on numerous hacks and discussions on the mailing list,
> > this is the best I've managed to come up with.
> 
> Hm, maybe this can be brought to work, only very lightly tested. It
> basically abuses what -Wignored-qualifiers points out:
> 
>   warning: type qualifiers ignored on function return type
> 
> Example showing the idea:
> 
> const int c(void);
> volatile int v(void);
> 
> int hack(int x, int y)
> {
> 	typeof(c()) a = x;
> 	typeof(v()) b = y;
> 
> 	a += b;
> 	b += a;
> 	a += b;
> 	return a;
> }

Nasty.  I like it :-)

> Since that compiles, a cannot be const-qualified, and the generated code
> certainly suggests that b is not volatile-qualified. So something like
> 
> #define unqual_type(x) _unqual_type(x, unique_id_dance)
> #define _unqual_type(x, id) typeof( ({
>   typeof(x) id(void);
>   id();
> }) )
> 
> and perhaps some _Pragma("GCC diagnostic push")/_Pragma("GCC diagnostic
> ignored -Wignored-qualifiers")/_Pragma("GCC diagnostic pop") could
> prevent the warning (which is in -Wextra, so I don't think it would
> appear in a normal build anyway).
> 
> No idea how well any of this would work across gcc versions or with clang.

https://gcc.gnu.org/legacy-ml/gcc-patches/2016-05/msg01054.html

This is defined to work this way in ISO C since C11.

But, it doesn't work with GCC before GCC 7 :-(


Segher
