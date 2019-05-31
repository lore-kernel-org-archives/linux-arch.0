Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33915 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEaIT6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 04:19:58 -0400
MIME-Version: 1.0
References: <20190530141531.43462-1-vincenzo.frascino@arm.com> <20190530141531.43462-3-vincenzo.frascino@arm.com>
In-Reply-To: <20190530141531.43462-3-vincenzo.frascino@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2019 10:19:41 +0200
Message-ID: <CAK8P3a3Sr+MNbGQiMYt3RrE6SaYFPO-rXNoNvtOC7=qKE1kuYQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/19] kernel: Define gettimeofday vdso common code
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mips@vger.kernel.org, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King <linux@armlinux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Mark Salyzyn <salyzyn@android.com>, Peter Collingbourne <pcc@google.com>, Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Huw Davies <huw@codeweavers.com>
Message-ID: <20190531081941.jAZ_TJalJc3OeSb2DpV1vgupIbcvs3oE6sJN-QEoyEg@z>

On Thu, May 30, 2019 at 4:15 PM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:

> +
> +static __always_inline notrace void vdso_write_end(struct vdso_data *vd)
> +{

Rather than marking every single function in here as "notrace",I think it
would be more robust to remove the '-pg' flag in the CFLAGS used for
compiling the vdso files.

       Arnd
