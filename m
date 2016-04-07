Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:32803 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755447AbcDGM2q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Apr 2016 08:28:46 -0400
MIME-Version: 1.0
In-Reply-To: <20160406122924.GA21527@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
	<CAMuHMdUUkaYVZ3-Jh6o1b++R=yFBg7siQt+A+TqqXRSa953CAw@mail.gmail.com>
	<20160406122924.GA21527@yury-N73SV>
Date: Thu, 7 Apr 2016 14:28:43 +0200
Message-ID: <CAMuHMdVTw=UjRZqJZCj=OS4SzrFt22SVaC39ePYC_1THZzX1Fw@mail.gmail.com>
Subject: Re: [RFC6 PATCH v6 00/21] ILP32 for ARM64
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Pinski <pinskia@gmail.com>, Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>, Andreas Schwab <schwab@suse.de>, Nathan Lynch <Nathan_Lynch@mentor.com>, Alexander Graf <agraf@suse.de>, Alexey Klimov <klimov.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Message-ID: <20160407122843.KF9Z6t5caGr7cs3fGn62ks7cxrnO4VtYp3mAYPA7_Ug@z>

On Wed, Apr 6, 2016 at 2:29 PM, Yury Norov <ynorov@caviumnetworks.com> wrote:
>> We're already closer to the (future) y2038 than to the (past) introduction of
>> LP64...
>
> This is not about Y2038 at all. In fact, current version doesn't fix
> Y2038 problem, as we decided finally.

Indeed. So these legacy applications have to be fixed later anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
