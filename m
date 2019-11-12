From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] mm: fixmap: convert __set_fixmap_offset() to an inline function
Date: Tue, 12 Nov 2019 16:53:49 +0900
Message-ID: <CAK7LNART2bL8C4yW5+-mP0aG=Depm3mrfLzKnhQuu3hnNSzTWA@mail.gmail.com>
References: <20191108124133.31751-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191108124133.31751-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
