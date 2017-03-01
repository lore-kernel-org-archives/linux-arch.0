From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] uapi: fix asm/ipcbuf.h userspace compilation errors
Date: Wed, 1 Mar 2017 17:23:52 +0100
Message-ID: <CAK8P3a3Ptm68i43BT5+kWptDw1koPwexpuFwH3-1naj_xi+arQ@mail.gmail.com>
References: <20170226182927.GA6998@altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34288 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdCAQuh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2017 11:50:37 -0500
In-Reply-To: <20170226182927.GA6998@altlinux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Feb 26, 2017 at 7:29 PM, Dmitry V. Levin <ldv@altlinux.org> wrote:
> Include <linux/posix_types.h> to fix asm/ipcbuf.h userspace compilation
> errors like this:
>
> /usr/include/asm-generic/ipcbuf.h:20:2: error: unknown type name '__kernel_key_t'
>   __kernel_key_t  key;
> /usr/include/asm-generic/ipcbuf.h:21:2: error: unknown type name '__kernel_uid32_t'
>   __kernel_uid32_t uid;
> /usr/include/asm-generic/ipcbuf.h:22:2: error: unknown type name '__kernel_gid32_t'
>   __kernel_gid32_t gid;
> /usr/include/asm-generic/ipcbuf.h:23:2: error: unknown type name '__kernel_uid32_t'
>   __kernel_uid32_t cuid;
> /usr/include/asm-generic/ipcbuf.h:24:2: error: unknown type name '__kernel_gid32_t'
>   __kernel_gid32_t cgid;
> /usr/include/asm-generic/ipcbuf.h:25:2: error: unknown type name '__kernel_mode_t'
>   __kernel_mode_t  mode;
> /usr/include/asm-generic/ipcbuf.h:27:35: error: '__kernel_mode_t' undeclared here (not in a function)
>   unsigned char  __pad1[4 - sizeof(__kernel_mode_t)];
> /usr/include/asm-generic/ipcbuf.h:30:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused1;
> /usr/include/asm-generic/ipcbuf.h:31:2: error: unknown type name '__kernel_ulong_t'
>   __kernel_ulong_t __unused2;
>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  include/uapi/asm-generic/ipcbuf.h     | 2 ++
>  arch/s390/include/uapi/asm/ipcbuf.h   | 2 ++
>  arch/sparc/include/uapi/asm/ipcbuf.h  | 2 ++
>  arch/xtensa/include/uapi/asm/ipcbuf.h | 2 ++
>  4 files changed, 8 insertions(+)
>
> diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
> index 3dbcc1e..909f825 100644
> --- a/include/uapi/asm-generic/ipcbuf.h
> +++ b/include/uapi/asm-generic/ipcbuf.h
> @@ -1,6 +1,8 @@
>  #ifndef __ASM_GENERIC_IPCBUF_H
>  #define __ASM_GENERIC_IPCBUF_H
>
> +#include <linux/posix_types.h>
> +


Acked-by: Arnd Bergmann <arnd@arndb.de>
