From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/12] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
Date: Wed, 15 Apr 2020 20:37:46 +0200
Message-ID: <CAK8P3a2jSS89Ldhu1g46zLTBHDVHUr3HSdyq_c7yiTfM8w6hDg@mail.gmail.com>
References: <20200415165218.20251-1-will@kernel.org> <20200415165218.20251-12-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200415165218.20251-12-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Android Kernel Team <kernel-team@android.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 15, 2020 at 6:53 PM Will Deacon <will@kernel.org> wrote:
>
> It is very rare to see versions of GCC prior to 4.8 being used to build
> the mainline kernel. These old compilers are also know to have codegen
> issues which can lead to silent miscompilation:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
>
> Raise the minimum GCC version for kernel build to 4.8 and remove some
> tautological Kconfig dependencies as a consequence.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

On a related note, I've updated the cross-compilers on kernel.org and
done some randconfig testing on all major versions from v4.8 to 9.3.
There were a couple of minor regressions with 4.8 (mostly harmless
warnings), but overall gcc-4.8 is still working well. I did not try older
compilers.

       Arnd
