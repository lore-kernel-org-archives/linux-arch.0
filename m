From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/5] m68k: Added system call table generation support
Date: Mon, 24 Sep 2018 09:03:42 +0200
Message-ID: <CAMuHMdUPKh+6ocdH38=46veyOFUE2o_Hj=xodyLDCQ3s8J9ADQ@mail.gmail.com>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-4-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537455973-12468-4-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: firoz.khan@linaro.org
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Greg KH <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Deepa Dinamani <deepa.kernel@gmail.com>, marcin.juszkiewicz@linaro.org
List-Id: linux-arch.vger.kernel.org

Hi Firoz,

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> The system call tables are in different format in all
> architecture and it will be difficult to manually add or
> modify the system calls in the respective files. To make
> it easy by keeping a script and which'll generate the
> header file and syscall table file so this change will
> unify them across all architectures.
>
> The system call table generation script is added in
> syscalls directory which contain the script to generate
> both uapi header file system call table generation file
> and syscall.tbl file which'll be the input for the scripts.
>
> syscall.tbl contains the list of available system calls
> along with system call number and corresponding entry point.
> Add a new system call in this architecture will be possible
> by adding new entry in the syscall.tbl file.
>
> Adding a new table entry consisting of:
>         - System call number.
>         - ABI.
>         - System call name.
>         - Entry point name.
>
> syscallhdr.sh and syscalltbl.sh will generate uapi header-
> unistd.h and syscall_table.h files respectively. File
> syscall_table.h is included by syscall_table.S - the real
> system call table. Both .sh files will parse the content
> syscall.tbl to generate the header and table files.
>
> ARM, s390 and x86 architecuture does have the similar support.
> I leverage their implementation to come up with a generic
> solution. And this is the ground work for y2038 issue. We need
> to change two dozons of system call implementation and this
> work will reduce the effort by simply modify two dozon entries
> in syscall.tbl.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- /dev/null
> +++ b/arch/m68k/kernel/syscalls/syscall.tbl
> @@ -0,0 +1,369 @@
> +#
> +# Linux system call numbers and entry vectors
> +#
> +# The format is:
> +# <number> <abi> <name> <entry point>
> +#
> +# The abi is always common for this file.
> +#
> +0       common   restart_syscall          sys_restart_syscall

Why the indentation by an "odd" number of spaces, instead of TABs?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
