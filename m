From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] asm-generic/io.h: Fix sparse warnings on big-endian architectures
Date: Mon, 3 Aug 2020 21:50:59 +0200
Message-ID: <CAK8P3a1m=PPg1sDdRsCz7BOu44-zD87b80SvdZbMuvfLTWsc-A@mail.gmail.com>
References: <20200803151134.3740544-1-shorne@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:44847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbgHCTvS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Aug 2020 15:51:18 -0400
In-Reply-To: <20200803151134.3740544-1-shorne@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>

On Mon, Aug 3, 2020 at 5:11 PM Stafford Horne <shorne@gmail.com> wrote:
>
> On big-endian architectures like OpenRISC, sparse outputs below warnings on
> asm-generic/io.h.  This is due to io statements like:
>
>   __raw_writel(cpu_to_le32(value), PCI_IOBASE + addr);
>
> The __raw_writel() function expects native endianness, however
> cpu_to_le32() returns __le32.  On little-endian machines these match up
> and there is no issue.  However, on big-endian we get warnings, for IO
> that is defined as little-endian the mismatch is expected.
>
> The fix I propose is to __force to native endian.
>
> Warnings:
>
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:166:15: warning: cast to restricted __le16
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:179:15: warning: cast to restricted __le32
> ./include/asm-generic/io.h:215:22: warning: incorrect type in argument 1 (different base types)
> ./include/asm-generic/io.h:215:22:    expected unsigned short [usertype] value
> ./include/asm-generic/io.h:215:22:    got restricted __le16 [usertype]
> ./include/asm-generic/io.h:225:22: warning: incorrect type in argument 1 (different base types)
> ./include/asm-generic/io.h:225:22:    expected unsigned int [usertype] value
> ./include/asm-generic/io.h:225:22:    got restricted __le32 [usertype]
>
> Signed-off-by: Stafford Horne <shorne@gmail.com>

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you just merge that through your openrisc tree? I don't have
any other asm-generic changes for this merge window.
