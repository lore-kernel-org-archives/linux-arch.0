From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH] arch: blackfin: kernel: sprintf(), need avoid NUL for '%s'
Date: Sat, 15 Jun 2013 23:02:28 -0400
Message-ID: <CAMjpGUf6rvcjNVqk6bB4RRjOSLQjk3de6CEv7rUm3VcMhzGdag@mail.gmail.com>
References: <51A5CDB4.9000204@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A5CDB4.9000204@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: anton.vorontsov@linaro.org, Richard Kuo <rkuo@codeaurora.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

i think you mean NULL instead of NUL

that said, the kernel is smart enough to replace NULL with "(null)",
so i don't see much point in this patch
-mike

On Wed, May 29, 2013 at 5:43 AM, Chen Gang <gang.chen@asianux.com> wrote:
>
> When it is kernel symbol, the 'modname' will be NUL, and the 'symname'
> contents the valid name.
>
> So for sprintf(), need avoid NUL for '%s'.
>
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/blackfin/kernel/trace.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/blackfin/kernel/trace.c b/arch/blackfin/kernel/trace.c
> index c36efa0..11f98bb 100644
> --- a/arch/blackfin/kernel/trace.c
> +++ b/arch/blackfin/kernel/trace.c
> @@ -51,7 +51,7 @@ void decode_address(char *buf, unsigned long address)
>                 if (!modname)
>                         modname = delim = "";
>                 sprintf(buf, "{ %s%s%s%s + 0x%lx }",
> -                       delim, modname, delim, symname,
> +                       delim, modname ? : "kernel", delim, symname,
>                         (unsigned long)offset);
>                 return;
>         }
> --
> 1.7.7.6
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
