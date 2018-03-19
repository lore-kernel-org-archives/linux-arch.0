Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:34755 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966744AbeCSQL0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2018 12:11:26 -0400
MIME-Version: 1.0
In-Reply-To: <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <9cb4cf158b8c73325dc524cba8d575e41647131f.1521399976.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 20 Mar 2018 00:11:24 +0800
Message-ID: <CAK8P3a15wbEmejpiokATLW=Cwe-XHZEdgU8fNQY-opjbjuU3-w@mail.gmail.com>
Subject: Re: [PATCH 14/19] csky: Misc headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180319161124.flENFtN3YjlSpW2FcdXiHeEB0W2dvGdXP6PyNZh-wfA@z>

On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> +++ b/arch/csky/include/uapi/asm/fcntl.h
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef __ASM_CSKY_FCNTL_H
> +#define __ASM_CSKY_FCNTL_H
> +
> +#define O_DIRECTORY    040000
> +#define O_NOFOLLOW     0100000
> +#define O_DIRECT       0200000
> +#define O_LARGEFILE    0400000
> +
> +#include <asm-generic/fcntl.h>

This should just use the generic file without overrides: Please don't diverge
from the generic syscall ABI.

> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/stat.h
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
> +#ifndef _CSKY_STAT_H
> +#define _CSKY_STAT_H
> +
> +struct __old_kernel_stat {
> +       unsigned short st_dev;

Same here: no need for __old_kernel_stat  or the headers on new architectures.

          Arnd
