Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeJaEFa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Oct 2018 00:05:30 -0400
MIME-Version: 1.0
References: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540921794.git.ren_guo@c-sky.com>
In-Reply-To: <d7007cad85bb06e0f4e081bc4daf6f0f79c81861.1540921794.git.ren_guo@c-sky.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Oct 2018 14:10:34 -0500
Message-ID: <CAL_JsqJR+iZCwcnp3fQbCAnwsoZpuBfC7k=Qf0JSG32wsXwFhQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] csky: remove builtin-dtb Kbuild
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>, devicetree@vger.kernel.org

On Tue, Oct 30, 2018 at 12:50 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> Remove the builtin-dtb implementation in arch/csky.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/csky/Kconfig.debug     | 10 +---------
>  arch/csky/Makefile          |  2 --
>  arch/csky/boot/dts/Makefile |  7 -------
>  3 files changed, 1 insertion(+), 18 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
