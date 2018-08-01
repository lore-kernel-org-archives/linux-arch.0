From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: include architecture Kconfig files from top-level Kconfig v4
Date: Thu, 2 Aug 2018 08:10:00 +0900
Message-ID: <CAK7LNASpOWQqNREQ_XN22QQM6Jx4F1Lrf76=_WHupPCFmOB2gA@mail.gmail.com>
References: <20180731113935.6105-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731113935.6105-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Michal Simek <monstr@monstr.eu>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-um@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2018-07-31 20:39 GMT+09:00 Christoph Hellwig <hch@lst.de>:
> Hi Masahiro,
>
> what do you think about the series below, which moves the includes
> of all the architecture independ Kconfig files to the top-level
> Kconfig instead of duplicating the includes in all architectures?
>
> Note that this only handles the low-hanging fruite, there are a lot
> of other bits that should probably be cleaned up to be common,
> but those will be not entirely trivial.
>
> Changes since v3:
>  - don't allow to select PREEMPT_COUNT for architectures that don't
>    implement it
>  - fix usage of SUBARCH=i386 and SUBARCH=x86_64 for um
>
> Changes since v2:
>  - fix the missing sh conversion
>  - handle the lack of CONFIG_SWAP support in microblaze and nios2
>    properly
>
> Changes since v1:
>  - add back a remove source statement from arch/arm/Kconfig
>  - various fixes from Randy
>  - various UML patches to be able to use the common Kconfig
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Applied.  Thanks!

-- 
Best Regards
Masahiro Yamada
