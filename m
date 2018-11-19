From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 4/5] mips: add system call table generation support
Date: Mon, 19 Nov 2018 17:00:28 +0100
Message-ID: <CAK8P3a1Ee-6unLimZ=0TH0PjdSjwu1naK=U6Jvoi_qvsf5+z7w@mail.gmail.com>
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org> <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542262461-29024-5-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 15, 2018 at 7:15 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> The system call tables are in different format in all
> architecture and it will be difficult to manually add,
> modify or delete the syscall table entries in the res-
> pective files. To make it easy by keeping a script and
> which will generate the uapi header and syscall table
> file. This change will also help to unify the implemen-
> tation across all architectures.

This looks great to me, just one question:

> +# The <abi> is always "64" for this file.
> +#
> +0      64      read                            sys_read
> +1      64      write                           sys_write

What is the reason for using '64', 'n32', and 'o32' respectively in
the ABI field
but use 'common' in other architectures that have a table of entries that are
all for the same architecture?

       Arnd
