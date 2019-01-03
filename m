From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kallsyms: lower alignment on ARM
Date: Thu, 3 Jan 2019 09:30:12 +0900
Message-ID: <CAK7LNATr9N=e26QQ=ks7ub-YhDPX5tfy7LY41m5oLSXpLLxxLw@mail.gmail.com>
References: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546173360-25573-1-git-send-email-minipli@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathias Krause <minipli@googlemail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Dec 30, 2018 at 9:37 PM Mathias Krause <minipli@googlemail.com> wrote:
>
> As mentioned in the info pages of gas, the '.align' pseudo op's
> interpretation of the alignment value is architecture specific.
> It might either be a byte value or taken to the power of two.
>
> On ARM it's actually the latter which leads to unnecessary large
> alignments of 16 bytes for 32 bit builds or 256 bytes for 64 bit
> builds.
>
> Fix this by switching to '.balign' instead which is consistent
> across all architectures.
>
> Signed-off-by: Mathias Krause <minipli@googlemail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>


Applied to linux-kbuild.
Thanks!


> ---
>  scripts/kallsyms.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 109a1af7e444..77cebad0474e 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -334,10 +334,10 @@ static void write_src(void)
>         printf("#include <asm/types.h>\n");
>         printf("#if BITS_PER_LONG == 64\n");
>         printf("#define PTR .quad\n");
> -       printf("#define ALGN .align 8\n");
> +       printf("#define ALGN .balign 8\n");
>         printf("#else\n");
>         printf("#define PTR .long\n");
> -       printf("#define ALGN .align 4\n");
> +       printf("#define ALGN .balign 4\n");
>         printf("#endif\n");
>
>         printf("\t.section .rodata, \"a\"\n");
> --
> 2.19.2
>


-- 
Best Regards
Masahiro Yamada
