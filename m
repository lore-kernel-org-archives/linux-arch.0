Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f180.google.com ([209.85.160.180]:41615 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1SeS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 14:34:18 -0400
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org> <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1538057720-3392-7-git-send-email-firoz.khan@linaro.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 28 Sep 2018 14:10:32 +0200
Message-ID: <CAK8P3a3YkR7Qr=XnqvQTOn=v34rCBfW1+dqU5xpV4ysar+C4yg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] ia64: uapi header and system call table file generation
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Firoz Khan <firoz.khan@linaro.org>
Cc: linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180928121032.zEEZ2HWQFkwvFl1e3Pp17BeHZPVoNUSSq-I3Rd5-Uew@z>

On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:

> +#include <asm/syscall_table.h>
>         .org sys_call_table + 8*NR_syscalls     // guard against failures to increase NR_syscalls
> +#undef __SYSCALL

This part looks odd: according to the comment, this should only guard against
the table getting out of sync. However, with the script, that will never happen.

      Arnd
