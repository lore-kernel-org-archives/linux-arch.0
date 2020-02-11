From: Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH] asm-generic: make more kernel-space headers mandatory
Date: Tue, 11 Feb 2020 23:59:08 +0900
Message-ID: <CAK7LNARZnyj7pynscGtz+hQF2LPvzxW5YjHAOivjYZhT8Yq7VQ@mail.gmail.com>
References: <20200210175452.5030-1-masahiroy@kernel.org> <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:59870 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgBKPAC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Feb 2020 10:00:02 -0500
In-Reply-To: <20200210143052.1d89f7e26c9bd115d617cc92@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, X86 ML <x86@kernel.org>, Michal Simek <michal.simek@xilinx.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>

Hi Andrew,

On Tue, Feb 11, 2020 at 7:30 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 11 Feb 2020 02:54:52 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > Change a header to mandatory-y if both of the following are met:
> >
> > [1] At least one architecture (except um) specifies it as generic-y in
> >     arch/*/include/asm/Kbuild
> >
> > [2] Every architecture (except um) either has its own implementation
> >     (arch/*/include/asm/*.h) or specifies it as generic-y in
> >     arch/*/include/asm/Kbuild
>
> (reads Documentation/kbuild/makefiles.rst to remember what these things
> do).
>
> Why are we making this change?  What's the benefit?


One obvious benefit is the diff stat:

 25 files changed, 52 insertions(+), 557 deletions(-)


It is tedious to list generic-y for each arch
that needs it.

So, mandatory-y works like a fallback default
(by just wrapping asm-generic one)
when arch does not have a specific header implementation.

See the following commits:

def3f7cefe4e81c296090e1722a76551142c227c
a1b39bae16a62ce4aae02d958224f19316d98b24


It is tedious to convert headers one by one,
so I processed by a shell script.


-- 
Best Regards
Masahiro Yamada
