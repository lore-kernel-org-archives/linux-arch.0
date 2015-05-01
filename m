From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/5] m68k: use for_each_sg()
Date: Fri, 1 May 2015 19:30:15 +0900
Message-ID: <CAC5umygcpPaNUh-7U0r2htsRptyO8AMLQePt_F53WU60rYMscQ@mail.gmail.com>
References: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
	<CAMuHMdURwUnHtp2Q327m8y9Cqud=gyfkpUbTC_+7Y7v=nogLkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34499 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753377AbbEAKaR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2015 06:30:17 -0400
In-Reply-To: <CAMuHMdURwUnHtp2Q327m8y9Cqud=gyfkpUbTC_+7Y7v=nogLkw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux-Arch <linux-arch@vger.kernel.org>

2015-05-01 18:07 GMT+09:00 Geert Uytterhoeven <geert@linux-m68k.org>:
> Hi Mita-san,
>
> On Fri, May 1, 2015 at 8:47 AM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
>> Since m68k doesn't select ARCH_HAS_SG_CHAIN, it is not necessary to
>> use for_each_sg() in order to loop over each sg element.  But this can
>> help find problems with drivers that do not properly initialize their
>> sg tables when CONFIG_DEBUG_SG is enabled.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: linux-m68k@lists.linux-m68k.org
>> Cc: linux-arch@vger.kernel.org
>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Do you want me to queue this up for v4.2, or do you want to handle these
> changes yourself, together with "[PATCH] scatterlist: enable sg chaining
> for all architectures"?

Hi Geert,

Please queue it up to your tree.  As it turned out that enabling
sg chaining for all architectures requires more survey, I've just
started trivial works like this.
