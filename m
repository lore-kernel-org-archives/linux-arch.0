From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic: unistd.h: fixup broken macro include.
Date: Thu, 6 Dec 2018 17:14:02 +0100
Message-ID: <CAK8P3a1UbR3bosJgKAJZVMn-5aJLS1u0t_OAYSU-dzum4EyVMw@mail.gmail.com>
References: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544062060-26875-1-git-send-email-ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Joseph Myers <joseph@codesourcery.com>, Mao Han <han_mao@c-sky.com>, linux-arch <linux-arch@vger.kernel.org>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 6, 2018 at 3:07 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The broken macros make the glibc compile error. If there is no
> __NR3264_fstat*, we should also removed related definitions.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the reminder!

Marcin had already sent me the same patch a while ago
and I forgot to apply it. I applied your version now, which
as a slightly better changelog, so it will be in linux-next
tomorrow, and I plan to send it after that shows no regressions.

     Arnd

>  include/uapi/asm-generic/unistd.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 538546e..c7f3321 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -760,8 +760,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_ftruncate __NR3264_ftruncate
>  #define __NR_lseek __NR3264_lseek
>  #define __NR_sendfile __NR3264_sendfile
> +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>  #define __NR_newfstatat __NR3264_fstatat
>  #define __NR_fstat __NR3264_fstat
> +#endif
>  #define __NR_mmap __NR3264_mmap
>  #define __NR_fadvise64 __NR3264_fadvise64
>  #ifdef __NR3264_stat
> @@ -776,8 +778,10 @@ __SYSCALL(__NR_rseq, sys_rseq)
>  #define __NR_ftruncate64 __NR3264_ftruncate
>  #define __NR_llseek __NR3264_lseek
>  #define __NR_sendfile64 __NR3264_sendfile
> +#if defined(__ARCH_WANT_NEW_STAT) || defined(__ARCH_WANT_STAT64)
>  #define __NR_fstatat64 __NR3264_fstatat
>  #define __NR_fstat64 __NR3264_fstat
> +#endif
>  #define __NR_mmap2 __NR3264_mmap
>  #define __NR_fadvise64_64 __NR3264_fadvise64
>  #ifdef __NR3264_stat
> --
> 2.7.4
>
