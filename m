From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 17/22] arm64: vdso: disable LTO
Date: Wed, 24 Jun 2020 13:58:57 -0700
Message-ID: <CAKwvOdnEbCfYZ9o=OF51oswyqDvN4iP-9syWUDhxfueq4q0xcw@mail.gmail.com>
References: <20200624203200.78870-1-samitolvanen@google.com> <20200624203200.78870-18-samitolvanen@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20200624203200.78870-18-samitolvanen@google.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kernel Hardening <kernel-hardening@lists.openwall.com>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 24, 2020 at 1:33 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Filter out CC_FLAGS_LTO for the vDSO.

Just curious about this patch (and the following one for x86's vdso),
do you happen to recall specifically what the issues with the vdso's
are?

>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index 556d424c6f52..cfad4c296ca1 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -29,8 +29,8 @@ ldflags-y := -shared -nostdlib -soname=linux-vdso.so.1 --hash-style=sysv \
>  ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
>  ccflags-y += -DDISABLE_BRANCH_PROFILING
>
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)
> -KBUILD_CFLAGS                  += $(DISABLE_LTO)
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
> +                               $(CC_FLAGS_LTO)
>  KASAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
>  OBJECT_FILES_NON_STANDARD      := y
> --
> 2.27.0.212.ge8ba1cc988-goog
>


-- 
Thanks,
~Nick Desaulniers
