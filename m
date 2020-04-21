From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v4 01/11] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
Date: Wed, 22 Apr 2020 02:15:30 +0900
Message-ID: <CAK7LNATyFAusdcsvZxOjB7vAtj7G2w6b-bWd7dJjXUoEKm=LcA@mail.gmail.com>
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-2-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:35891 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDURQc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 13:16:32 -0400
In-Reply-To: <20200421151537.19241-2-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "Cc: Android Kernel" <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>

On Wed, Apr 22, 2020 at 12:15 AM Will Deacon <will@kernel.org> wrote:
>
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also know to have codegen

"know" -> "known"


> issues which can lead to silent miscompilation:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> Raise the minimum GCC version for kernel build to 4.8 and remove some
> tautological Kconfig dependencies as a consequence.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>


Maybe you can also clean up mm/migrate.c
because GCC_VERSION >= 40700 is always met.
It is up to you if you want to send v5.

Please replace CC with
Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Thank you!

> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---


-- 
Best Regards
Masahiro Yamada
