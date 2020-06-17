From: =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>
Subject: Re: [PATCH] vmlinux.lds: consider .text.{hot|unlikely}.* part of
 .text too
Date: Wed, 17 Jun 2020 14:27:05 -0700
Message-ID: <20200617212705.tq2q6bi446gydymo@google.com>
References: <20200617210613.95432-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200617210613.95432-1-ndesaulniers@google.com>
Sender: stable-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, clang-built-linux@googlegroups.com, Kees Cook <keescook@chromium.org>, stable@vger.kernel.org, Jian Cai <jiancai@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


On 2020-06-17, Nick Desaulniers wrote:
>ld.bfd's internal linker script considers .text.hot AND .text.hot.* to
>be part of .text, as well as .text.unlikely and .text.unlikely.*.

>ld.lld will produce .text.hot.*/.text.unlikely.* sections.

Correction to this sentence. lld is not relevant here.

-ffunction-sections combined with profile-guided optimization can
produce .text.hot.* .text.unlikely.* sections.  Newer clang may produce
.text.hot. .text.unlikely. (without suffix, but with a trailing dot)
when -fno-unique-section-names is specified, as an optimization to make
.strtab smaller.

We've already seen that GCC can place main in .text.startup without
-ffunction-sections. There may be other non -ffunction-sections cases
for .text.hot.* or .text.unlikely.*. So it is definitely a good idea to
be more specific even if we don't care about -ffunction-sections for
now.

>Make sure to group these together.  Otherwise these orphan sections may
>be placed outside of the the _stext/_etext boundaries.
>
>Cc: stable@vger.kernel.org
>Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
>Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
>Link: https://reviews.llvm.org/D79600
>Reported-by: Jian Cai <jiancai@google.com>
>Debugged-by: Luis Lozano <llozano@google.com>
>Suggested-by: Fāng-ruì Sòng <maskray@google.com>
>Tested-by: Luis Lozano <llozano@google.com>
>Tested-by: Manoj Gupta <manojgupta@google.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> include/asm-generic/vmlinux.lds.h | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index d7c7c7f36c4a..fe5aaef169e3 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -560,7 +560,9 @@
>  */
> #define TEXT_TEXT							\
> 		ALIGN_FUNCTION();					\
>-		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
>+		*(.text.hot .text.hot.*)				\
>+		*(TEXT_MAIN .text.fixup)				\
>+		*(.text.unlikely .text.unlikely.*)			\
> 		NOINSTR_TEXT						\
> 		*(.text..refcount)					\
> 		*(.ref.text)						\
>-- 
>2.27.0.290.gba653c62da-goog
>
