From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v5 13/36] vmlinux.lds.h: add PGO and AutoFDO input
 sections
Date: Fri, 31 Jul 2020 23:51:28 -0400
Message-ID: <20200801035128.GB2800311@rani.riverdale.lan>
References: <20200731230820.1742553-1-keescook@chromium.org>
 <20200731230820.1742553-14-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200731230820.1742553-14-keescook@chromium.org>
Sender: stable-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Jian Cai <jiancai@google.com>, =?utf-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>, Luis Lozano <llozano@google.com>, Manoj Gupta <manojgupta@google.com>, stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 31, 2020 at 04:07:57PM -0700, Kees Cook wrote:
> From: Nick Desaulniers <ndesaulniers@google.com>
> 
> Basically, consider .text.{hot|unlikely|unknown}.* part of .text, too.
> 
> When compiling with profiling information (collected via PGO
> instrumentations or AutoFDO sampling), Clang will separate code into
> .text.hot, .text.unlikely, or .text.unknown sections based on profiling
> information. After D79600 (clang-11), these sections will have a
> trailing `.` suffix, ie.  .text.hot., .text.unlikely., .text.unknown..
> 
> When using -ffunction-sections together with profiling infomation,
> either explicitly (FGKASLR) or implicitly (LTO), code may be placed in
> sections following the convention:
> .text.hot.<foo>, .text.unlikely.<bar>, .text.unknown.<baz>
> where <foo>, <bar>, and <baz> are functions.  (This produces one section
> per function; we generally try to merge these all back via linker script
> so that we don't have 50k sections).
> 
> For the above cases, we need to teach our linker scripts that such
> sections might exist and that we'd explicitly like them grouped
> together, otherwise we can wind up with code outside of the
> _stext/_etext boundaries that might not be mapped properly for some
> architectures, resulting in boot failures.
> 
> If the linker script is not told about possible input sections, then
> where the section is placed as output is a heuristic-laiden mess that's
> non-portable between linkers (ie. BFD and LLD), and has resulted in many
> hard to debug bugs.  Kees Cook is working on cleaning this up by adding
> --orphan-handling=warn linker flag used in ARCH=powerpc to additional
> architectures. In the case of linker scripts, borrowing from the Zen of
> Python: explicit is better than implicit.
> 
> Also, ld.bfd's internal linker script considers .text.hot AND
> .text.hot.* to be part of .text, as well as .text.unlikely and
> .text.unlikely.*. I didn't see support for .text.unknown.*, and didn't
> see Clang producing such code in our kernel builds, but I see code in
> LLVM that can produce such section names if profiling information is
> missing. That may point to a larger issue with generating or collecting
> profiles, but I would much rather be safe and explicit than have to
> debug yet another issue related to orphan section placement.
> 
> Reported-by: Jian Cai <jiancai@google.com>
> Suggested-by: Fāng-ruì Sòng <maskray@google.com>
> Tested-by: Luis Lozano <llozano@google.com>
> Tested-by: Manoj Gupta <manojgupta@google.com>
> Acked-by: Kees Cook <keescook@chromium.org>
> Cc: stable@vger.kernel.org
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=add44f8d5c5c05e08b11e033127a744d61c26aee
> Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commitdiff;h=1de778ed23ce7492c523d5850c6c6dbb34152655
> Link: https://reviews.llvm.org/D79600
> Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1084760
> Debugged-by: Luis Lozano <llozano@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 2593957f6e8b..af5211ca857c 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -561,7 +561,10 @@
>   */
>  #define TEXT_TEXT							\
>  		ALIGN_FUNCTION();					\
> -		*(.text.hot TEXT_MAIN .text.fixup .text.unlikely)	\
> +		*(.text.hot .text.hot.*)				\
> +		*(TEXT_MAIN .text.fixup)				\
> +		*(.text.unlikely .text.unlikely.*)			\
> +		*(.text.unknown .text.unknown.*)			\
>  		NOINSTR_TEXT						\
>  		*(.text..refcount)					\
>  		*(.ref.text)						\
> -- 
> 2.25.1
> 

This also changes the ordering to place all hot resp unlikely sections separate
from other text, while currently it places the hot/unlikely bits of each file
together with the rest of the code in that file. That seems like a reasonable
change and should be mentioned in the commit message.

However, the history of their being together comes from

  9bebe9e5b0f3 ("kbuild: Fix .text.unlikely placement")

which seems to indicate there was some problem with having them separated out,
although I don't quite understand what the issue was from the commit message.

Cc Andi and Michal to see if they remember.
