From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v4 08/11] READ_ONCE: Drop pointer qualifiers when reading
 from scalar types
Date: Wed, 22 Apr 2020 12:25:03 +0200
Message-ID: <6cbc8ae1-8eb1-a5a0-a584-2081fca1c4aa@rasmusvillemoes.dk>
References: <20200421151537.19241-1-will@kernel.org>
 <20200421151537.19241-9-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgDVKZI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Apr 2020 06:25:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991EC03C1A8
        for <linux-arch@vger.kernel.org>; Wed, 22 Apr 2020 03:25:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u16so1703347wmc.5
        for <linux-arch@vger.kernel.org>; Wed, 22 Apr 2020 03:25:07 -0700 (PDT)
In-Reply-To: <20200421151537.19241-9-will@kernel.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>

On 21/04/2020 17.15, Will Deacon wrote:
> Passing a volatile-qualified pointer to READ_ONCE() is an absolute
> trainwreck for code generation: the use of 'typeof()' to define a
> temporary variable inside the macro means that the final evaluation in
> macro scope ends up forcing a read back from the stack. When stack
> protector is enabled (the default for arm64, at least), this causes
> the compiler to vomit up all sorts of junk.
> 
> Unfortunately, dropping pointer qualifiers inside the macro poses quite
> a challenge, especially since the pointed-to type is permitted to be an
> aggregate, and this is relied upon by mm/ code accessing things like
> 'pmd_t'. Based on numerous hacks and discussions on the mailing list,
> this is the best I've managed to come up with.

Hm, maybe this can be brought to work, only very lightly tested. It
basically abuses what -Wignored-qualifiers points out:

  warning: type qualifiers ignored on function return type

Example showing the idea:

const int c(void);
volatile int v(void);

int hack(int x, int y)
{
	typeof(c()) a = x;
	typeof(v()) b = y;

	a += b;
	b += a;
	a += b;
	return a;
}

Since that compiles, a cannot be const-qualified, and the generated code
certainly suggests that b is not volatile-qualified. So something like

#define unqual_type(x) _unqual_type(x, unique_id_dance)
#define _unqual_type(x, id) typeof( ({
  typeof(x) id(void);
  id();
}) )

and perhaps some _Pragma("GCC diagnostic push")/_Pragma("GCC diagnostic
ignored -Wignored-qualifiers")/_Pragma("GCC diagnostic pop") could
prevent the warning (which is in -Wextra, so I don't think it would
appear in a normal build anyway).

No idea how well any of this would work across gcc versions or with clang.

Rasmus
