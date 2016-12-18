Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:34108 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751532AbcLRJcs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 18 Dec 2016 04:32:48 -0500
Date: Sun, 18 Dec 2016 10:23:29 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 3/3] mm: make pagoff_t type 64-bit
Message-ID: <20161218092329.GA16618@lst.de>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com> <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com> <2636242.RWRJivuddj@wuerfel> <20161216105514.GA466@yury-N73SV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161216105514.GA466@yury-N73SV>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, libc-alpha@sourceware.org, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Nathan Lynch <Nathan_Lynch@mentor.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, davem@davemloft.net, christoph.muellner@theobroma-systems.com
Message-ID: <20161218092329.uTEJWySlOOkzu6s7GtRhRM_C88KLGf-uZ3FYx1lDHz4@z>

On Fri, Dec 16, 2016 at 04:25:14PM +0530, Yury Norov wrote:
>  1 leave things as is. 32-bit architectures will have no option to
>    mmap big offsets, and no one cares - as usual.

And that's the only sensible option.
