Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mslow2.mail.gandi.net ([217.70.178.242]:60926 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfBRSbL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Feb 2019 13:31:11 -0500
Received: from relay12.mail.gandi.net (unknown [217.70.178.232])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 04E863A1B75
        for <linux-arch@vger.kernel.org>; Mon, 18 Feb 2019 18:18:27 +0000 (UTC)
Date: Mon, 18 Feb 2019 19:18:25 +0100
From: Hugo Lefeuvre <hle@owl.eu.com>
Subject: Re: [asm-generic:master 4/6] arch/powerpc/kernel/iomap.c:142:6:
 error: conflicting types for 'ioread8_rep'
Message-ID: <20190218181825.GA18457@behemoth.owl.eu.com.local>
References: <201902190221.hbMLi4kS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201902190221.hbMLi4kS%fengguang.wu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

Hi Arnd,

On Tue, Feb 19, 2019 at 02:10:34AM +0800, kbuild test robot wrote:
> All errors (new ones prefixed by >>):
> 
> >> arch/powerpc/kernel/iomap.c:18:14: error: conflicting types for 'ioread8'
>     unsigned int ioread8(void __iomem *addr)
>                  ^~~~~~~
>    In file included from arch/powerpc/include/asm/io.h:653,
>                     from include/linux/io.h:25,
>                     from include/linux/irq.h:20,
>                     from arch/powerpc/include/asm/hardirq.h:6,
>                     from include/linux/hardirq.h:9,
>                     from include/linux/interrupt.h:11,
>                     from include/linux/pci.h:32,
>                     from arch/powerpc/kernel/iomap.c:7:
>    include/asm-generic/iomap.h:29:21: note: previous declaration of 'ioread8' was here
>     extern unsigned int ioread8(const void __iomem *addr);
>                         ^~~~~~~

Just saw that, seems like powerpc headers should be updated as well. Should
I prepare a patch ?

Thanks.

regards,
 Hugo

-- 
                Hugo Lefeuvre (hle)    |    www.owl.eu.com
RSA4096_ 360B 03B3 BF27 4F4D 7A3F D5E8 14AA 1EB8 A247 3DFD
ed25519_ 37B2 6D38 0B25 B8A2 6B9F 3A65 A36F 5357 5F2D DC4C
