From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [patches] Re: [PATCH 13/17] RISC-V: Add include subdirectory
Date: Sat, 24 Jun 2017 14:32:24 -0700 (PDT)
Message-ID: <mhng-d95a6423-75a8-4a91-bb6a-1f8765b97016@palmer-si-x1c4>
References: <1498318925.31581.89.camel@kernel.crashing.org>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36420 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754667AbdFXVcZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 24 Jun 2017 17:32:25 -0400
Received: by mail-pg0-f66.google.com with SMTP id e187so10489847pgc.3
        for <linux-arch@vger.kernel.org>; Sat, 24 Jun 2017 14:32:25 -0700 (PDT)
In-Reply-To: <1498318925.31581.89.camel@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, albert@sifive.com, patches@groups.riscv.org

On Sat, 24 Jun 2017 08:42:05 PDT (-0700), benh@kernel.crashing.org wrote:
> On Fri, 2017-06-23 at 19:01 -0700, Palmer Dabbelt wrote:
>> > > +#define mmiowb()       __asm__ __volatile__ ("fence io,io" : : : "memory");
>
> I forgot if we already mentioned that but mmiowb is primarily intended
> to order MMIO stores vs. a subsequent spin_unlock.
>
> I'm not sure an IO only fence is sufficient here.
>
> Note that I've never trusted drivers to get that right, it's a rather
> bad abstraction to begin with, so on powerpc, instead, I just set a
> per-cpu flag on every non-relaxed MMIO write and test it in spin_unlock
> in order to "beef up" the barrier in there if necessary.

Sorry about that -- I thought I'd included a note somewhere that the atomics
and barriers weren't ready to go yet, as we'd found a bunch of problems with
them in the first review and I needed to go through them all.  Arnd suggested
copying the PowerPC approach to mmiowb and I like that better, so we're going
to use it.

Thanks!
