Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:62696
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726872AbeHUUVf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 16:21:35 -0400
Date: Tue, 21 Aug 2018 10:00:34 -0700
From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH v9 1/2] kbuild: Allow arch-specific asm/compiler.h
Message-ID: <20180821170034.rpnwukgnpyrpxytw@pburton-laptop>
References: <20180820183417.dejfsluih7elbclu@pburton-laptop>
 <20180820223618.22319-1-paul.burton@mips.com>
 <20180820223618.22319-2-paul.burton@mips.com>
 <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASarMBH8af=oTPoanEvJOS3zWTKx4MpGZe-AJiP2Wu41g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, James Hogan <jhogan@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Message-ID: <20180821170034.TaTT6PuUmbj7F8t4JjS3JYlCt91snRP2UZuEFkWxYDk@z>

Hi Masahiro,

On Tue, Aug 21, 2018 at 11:49:48AM +0900, Masahiro Yamada wrote:
> The code diff looks good to me.
> 
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks :)

> > A straightforward approach to the per-arch header is to make use of
> > asm-generic to provide a default empty header & adjust architectures
> > which don't need anything specific to make use of that by adding the
> > header to generic-y. Unfortunately this doesn't work so well due to
> > commit a95b37e20db9 ("kbuild: get <linux/compiler_types.h> out of
> > <linux/kconfig.h>") which moved the inclusion of linux/compiler.h to
> > cflags using the -include compiler flag.
>
> I doubt this statement.
> 
> Commit a95b37e20db9 is not the cause of the problem.
> 
>%
> 
> The change happened in commit 28128c61e08e.

You're correct - I'll fix that up.

> One more thing, you are not touching any makefile in this version.
> 
> Maybe, you can prefix the subject with "compiler.h:" or something
> instead of "kbuild:".

Will do.

Thanks,
    Paul
