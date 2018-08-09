Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36255 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbeHIUfQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2018 16:35:16 -0400
MIME-Version: 1.0
References: <20180809174444.31705-1-paul.burton@mips.com> <20180809174444.31705-4-paul.burton@mips.com>
In-Reply-To: <20180809174444.31705-4-paul.burton@mips.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 9 Aug 2018 20:08:59 +0200
Message-ID: <CAK8P3a2AxGr2_r2jsrf3S+xAqaszXGozWwV7tc16VjmP6yx3fg@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] compiler.h: Allow arch-specific overrides
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Burton <paul.burton@mips.com>
Cc: "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-alpha@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, linux-arch <linux-arch@vger.kernel.org>, linux-um@lists.infradead.org

On Thu, Aug 9, 2018 at 7:45 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Include an arch-specific asm/compiler.h and allow for it to define a
> custom version of barrier_before_unreachable(), which is needed to
> workaround several issues on the MIPS architecture.
>
> This patch includes an effectively empty asm-generic implementation of
> asm/compiler.h for all architectures except alpha, arm, arm64, and mips
> (which already have an asm/compiler.h) and leaves the architecture
> specifics to a further patch.
>
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> [jhogan@kernel.org: Forward port and use asm/compiler.h instead of
>  asm/compiler-gcc.h]
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Reviewed-by: Paul Burton <paul.burton@mips.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-um@lists.infradead.org

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
