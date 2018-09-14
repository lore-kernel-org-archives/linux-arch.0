From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
Date: Fri, 14 Sep 2018 11:58:09 +0200
Message-ID: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1536914314-5026-3-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
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
> and syscall_32/64.tbl file which'll be the input for the
> scripts.

I think it would be best to name the files
o32/n64/n32 instead of 32/64/n32

It would also be helpful to mention why the n32/n64
files cannot be combined into one nfile here.


> +364     32      pkey_alloc                      sys_pkey_alloc
> +365     32      pkey_free                       sys_pkey_free
> +366     32      statx                           sys_statx

You missed the additon of rseq and io_pgetevetns here.

       Arnd
