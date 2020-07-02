From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] vmlinux.lds.h: Coalesce transient LLVM dead code
 elimination sections
Date: Thu, 2 Jul 2020 09:04:20 -0700
Message-ID: <20200702160420.GA3512364@ubuntu-s3-xlarge-x86>
References: <20200702085400.2643527-1-danny@kdrag0n.dev>
 <202007020853.5F15B5DDD@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <202007020853.5F15B5DDD@keescook>
Sender: stable-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Danny Lin <danny@kdrag0n.dev>, Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <ndesaulniers@google.com>, Sami Tolvanen <samitolvanen@google.com>, Fangrui Song <maskray@google.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 02, 2020 at 08:54:53AM -0700, Kees Cook wrote:
> On Thu, Jul 02, 2020 at 01:54:00AM -0700, Danny Lin wrote:
> > A recent LLVM 11 commit [1] made LLD stop implicitly coalescing some
> > temporary LLVM sections, namely .{data,bss}..compoundliteral.XXX:
> > 
> >   [30] .data..compoundli PROGBITS         ffffffff9ac9a000  19e9a000
> >        000000000000cea0  0000000000000000  WA       0     0     32
> >   [31] .rela.data..compo RELA             0000000000000000  40965440
> >        0000000000001d88  0000000000000018   I      2238    30     8
> >   [32] .data..compoundli PROGBITS         ffffffff9aca6ea0  19ea6ea0
> >        00000000000033c0  0000000000000000  WA       0     0     32
> >   [33] .rela.data..compo RELA             0000000000000000  409671c8
> >        0000000000000948  0000000000000018   I      2238    32     8
> >   [...]
> >   [2213] .bss..compoundlit NOBITS           ffffffffa3000000  1d85c000
> >        00000000000000a0  0000000000000000  WA       0     0     32
> >   [2214] .bss..compoundlit NOBITS           ffffffffa30000a0  1d85c000
> >        0000000000000040  0000000000000000  WA       0     0     32
> >   [...]
> > 
> > While these extra sections don't typically cause any breakage, they do
> > inflate the vmlinux size due to the overhead of storing metadata for
> > thousands of extra sections.
> > 
> > It's also worth noting that for some reason, some downstream Android
> > kernels can't boot at all if these sections aren't coalesced.
> > 
> > This issue isn't limited to any specific architecture; it affects arm64
> > and x86 if CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is forced on.

It might be worth noting that this happens explicitly because of
-fdata-sections, which is currently only used with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION but there are other features such
as LTO that will enable this and make this relevant in the future.

https://android-review.googlesource.com/c/kernel/common/+/1329278/6#message-81b191e92ef4e98e017fa9ded5ef63ef6e60db3a

It is also worth noting that those commits add .bss..L* and .data..L*
and rodata variants. Do you know if those are relevant here?

> > Example on x86 allyesconfig:
> >     Before: 2241 sections, 1170972 KiB
> >     After:    56 sections, 1171169 KiB

Am I reading this right that coalescing those sections increases the
image size? Kind of interesting.

> > [1] https://github.com/llvm/llvm-project/commit/9e33c096476ab5e02ab1c8442cc3cb4e32e29f17
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/958
> > Cc: stable@vger.kernel.org # v4.4+
> > Suggested-by: Fangrui Song <maskray@google.com>
> > Signed-off-by: Danny Lin <danny@kdrag0n.dev>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> > ---
> >  include/asm-generic/vmlinux.lds.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index db600ef218d7..18968cba87c7 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -94,10 +94,10 @@
> >   */
> >  #ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
> >  #define TEXT_MAIN .text .text.[0-9a-zA-Z_]*
> > -#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX*
> > +#define DATA_MAIN .data .data.[0-9a-zA-Z_]* .data..LPBX* .data..compoundliteral*

I am fairly certain this will fix a PowerPC warning that we had
recently so good!

https://lore.kernel.org/lkml/202006180904.TVUXCf6H%25lkp@intel.com/

Unfortunately, I forgot to reply to that thread...

> >  #define SDATA_MAIN .sdata .sdata.[0-9a-zA-Z_]*
> >  #define RODATA_MAIN .rodata .rodata.[0-9a-zA-Z_]*
> > -#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]*
> > +#define BSS_MAIN .bss .bss.[0-9a-zA-Z_]* .bss..compoundliteral*
> 
> Are there .data.. and .bss.. sections we do NOT want to collect? i.e.
> why not include .data..* and .bss..* ?

At one point Android was doing that for modules but stopped:

https://android-review.googlesource.com/c/kernel/common/+/1266787

I wonder if that is a problem for the main kernel image.

Cheers,
Nathan
