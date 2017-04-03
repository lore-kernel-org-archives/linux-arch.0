From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] vmlinux.lds: add missing VMLINUX_SYMBOL macros
Date: Mon, 3 Apr 2017 16:30:24 -0700
Message-ID: <CAGXu5jKMzy5nZtpDq=_LO+ps0HNbGkKjoe+PycF7HBkLrod1rw@mail.gmail.com>
References: <1491259387-15869-1-git-send-email-jeyu@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f43.google.com ([209.85.214.43]:36179 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbdDCXaZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2017 19:30:25 -0400
Received: by mail-it0-f43.google.com with SMTP id e75so55818306itd.1
        for <linux-arch@vger.kernel.org>; Mon, 03 Apr 2017 16:30:25 -0700 (PDT)
In-Reply-To: <1491259387-15869-1-git-send-email-jeyu@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jessica <jeyu@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Eddie Kovsky <ewk@edkovsky.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Apr 3, 2017 at 3:43 PM, Jessica <jeyu@redhat.com> wrote:
> From: Jessica Yu <jeyu@redhat.com>
>
> When __{start,end}_ro_after_init is referenced from C code, we run into the
> following build errors on blackfin:
>
>   kernel/extable.c:169: undefined reference to `__start_ro_after_init'
>   kernel/extable.c:169: undefined reference to `__end_ro_after_init'
>
> The build error is due to the fact that blackfin is one of the few arches
> that prepends an underscore '_' to all symbols defined in C. Fix this by
> wrapping __{start,end}_ro_after_init in vmlinux.lds.h with VMLINUX_SYMBOL(),
> which adds the necessary prefix for arches that have HAVE_UNDERSCORE_SYMBOL_PREFIX.
>
> Signed-off-by: Jessica Yu <jeyu@redhat.com>

Thanks!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
> This patch is based on next-20170403.
>
>  include/asm-generic/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 979b573..54918ae 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -261,9 +261,9 @@
>   */
>  #ifndef RO_AFTER_INIT_DATA
>  #define RO_AFTER_INIT_DATA                                             \
> -       __start_ro_after_init = .;                                      \
> +       VMLINUX_SYMBOL(__start_ro_after_init) = .;                      \
>         *(.data..ro_after_init)                                         \
> -       __end_ro_after_init = .;
> +       VMLINUX_SYMBOL(__end_ro_after_init) = .;
>  #endif
>
>  /*
> --
> 2.5.5
>



-- 
Kees Cook
Pixel Security
