From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 6/7] ia64: uapi header and system call table file generation
Date: Fri, 28 Sep 2018 14:10:32 +0200
Message-ID: <CAK8P3a3YkR7Qr=XnqvQTOn=v34rCBfW1+dqU5xpV4ysar+C4yg@mail.gmail.com>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org> <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:

> +#include <asm/syscall_table.h>
>         .org sys_call_table + 8*NR_syscalls     // guard against failures to increase NR_syscalls
> +#undef __SYSCALL

This part looks odd: according to the comment, this should only guard against
the table getting out of sync. However, with the script, that will never happen.

      Arnd
