From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] include/asm-generic: vmlinux.lds.h
Date: Sun, 15 Mar 2020 19:12:51 +0100
Message-ID: <CAMuHMdV7N4cxCmyv-eXa1Cnx9pnQLr-cuwAbNwwG-4YyKodgeA@mail.gmail.com>
References: <20200315175108.9694-1-romain.naour@gmail.com> <20200315175108.9694-2-romain.naour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20200315175108.9694-2-romain.naour@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Romain Naour <romain.naour@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Alan Modra <amodra@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

CC arnd, linux-arch

On Sun, Mar 15, 2020 at 6:51 PM Romain Naour <romain.naour@gmail.com> wrote:
> Since the patch [1], building the kernel using a toolchain built with
> Binutils 2.33.1 prevent booting a sh4 system under Qemu.
> Apply the patch provided by Alan Modra [2] that fix alignment of rodata.
>
> [1] https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=ebd2263ba9a9124d93bbc0ece63d7e0fae89b40e
> [2] https://www.sourceware.org/ml/binutils/2019-12/msg00112.html
>
> Signed-off-by: Romain Naour <romain.naour@gmail.com>
> Cc: Alan Modra <amodra@gmail.com>
> ---
>  include/asm-generic/vmlinux.lds.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..d46d34b58c96 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -374,6 +374,7 @@
>   */
>  #ifndef RO_AFTER_INIT_DATA
>  #define RO_AFTER_INIT_DATA                                             \
> +       . = ALIGN(8);                                                   \
>         __start_ro_after_init = .;                                      \
>         *(.data..ro_after_init)                                         \
>         JUMP_TABLE_DATA                                                 \
> --
> 2.24.1
