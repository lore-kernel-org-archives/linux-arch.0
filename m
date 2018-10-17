Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40058 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeJQXeK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:34:10 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <1c0d8cddcdf15e5f397b3e42b76461e97d6e34ad.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:37:38 +0200
Message-ID: <CAK8P3a363-ucdqEtrkUah9NPrFtQV6eH=4G3fcQtHMyMStME5w@mail.gmail.com>
Subject: Re: [PATCH V9 14/21] csky: User access
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017153738.18A6HIgN42FdKPncOD6EnQKsQPhmYVTq0T_0ckkBjnc@z>

On Tue, Oct 16, 2018 at 5:05 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> The patch adds "user access from kernel" codes.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/include/asm/uaccess.h | 416 ++++++++++++++++++++++++++++++++++++++++
>  arch/csky/lib/usercopy.c        | 262 +++++++++++++++++++++++++
>  2 files changed, 678 insertions(+)
>  create mode 100644 arch/csky/include/asm/uaccess.h
>  create mode 100644 arch/csky/lib/usercopy.c

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

The 64-bit __put_user() is usually what everyone gets wrong, but
your version seems fine. Also the access_ok() checks and
the copy_to_user() result value all look correct.

        Arnd
