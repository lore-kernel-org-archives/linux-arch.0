From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v4 11/11] gcov: Remove old GCC 3.4 support
Date: Wed, 22 Apr 2020 02:19:43 +0900
Message-ID: <CAK7LNATuvjY=SKuc-otRg0zPoJZeKOoTFzdyuyY_9X78p+twxQ@mail.gmail.com>
References: <20200421151537.19241-1-will@kernel.org> <20200421151537.19241-12-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-04.nifty.com ([210.131.2.83]:52159 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbgDURUm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Apr 2020 13:20:42 -0400
In-Reply-To: <20200421151537.19241-12-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "Cc: Android Kernel" <kernel-team@android.com>, Mark Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Peter Oberparleiter <oberpar@linux.ibm.com>, Nick Desaulniers <ndesaulniers@google.com>

On Wed, Apr 22, 2020 at 12:16 AM Will Deacon <will@kernel.org> wrote:
>
> The kernel requires at least GCC 4.8 in order to build, and so there is
> no need to cater for the pre-4.7 gcov format.
>
> Remove the obsolete code.
>
> Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks!


-- 
Best Regards
Masahiro Yamada
