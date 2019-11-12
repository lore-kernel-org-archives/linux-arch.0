Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-02.nifty.com ([210.131.2.81]:28678 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfKLHy3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Nov 2019 02:54:29 -0500
MIME-Version: 1.0
References: <20191108124133.31751-1-yamada.masahiro@socionext.com>
In-Reply-To: <20191108124133.31751-1-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 12 Nov 2019 16:53:49 +0900
Message-ID: <CAK7LNART2bL8C4yW5+-mP0aG=Depm3mrfLzKnhQuu3hnNSzTWA@mail.gmail.com>
Subject: Re: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline function
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20191112075349.km97bh9rQzmoC9vPzHuCilCEARGL7qDByYB_p4CrUzo@z>

Hi Andrew,

On Fri, Nov 8, 2019 at 9:42 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> I just stopped by the ugly variable name, ________addr.
> (8 underscores!)
>
> If this is just a matter of casting to (unsigned long), this variable
> is unneeded since you can do like this:
>
> ({                                                                      \
>         __set_fixmap(idx, phys, flags);                                 \
>         (unsigned long)(fix_to_virt(idx) + ((phys) & (PAGE_SIZE - 1))); \
> })
>
> However, I'd rather like to change it to an inline function since it
> is more readable, and the parameter types are clearer.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Unfortunately, this patch broke building ppc, mips, etc.
(Not all arch implement __set_fixmap)

Could you drop it from your tree?

Thanks.


-- 
Best Regards
Masahiro Yamada
