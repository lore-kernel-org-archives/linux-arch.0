Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef008-v.nifty.com ([210.131.4.245]:50952 "EHLO
	condef008-v.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbcFVHAk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2016 03:00:40 -0400
Received: from conssluserg-03.nifty.com ([10.26.8.82])by condef008-v.nifty.com with ESMTP id u5M6qKAT005776
	for <linux-arch@vger.kernel.org>; Wed, 22 Jun 2016 15:52:20 +0900
MIME-Version: 1.0
In-Reply-To: <9339659.lz6OGfeSnb@wuerfel>
References: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com>
 <576855FD.6020202@suse.cz> <CAK7LNAR4mdwQqsf4xhtsMA7FEuAqNMEzE+6HkYCW30qLbKb1=A@mail.gmail.com>
 <9339659.lz6OGfeSnb@wuerfel>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 22 Jun 2016 15:52:05 +0900
Message-ID: <CAK7LNAQiTwqN=OPgVk0KveyMyfu11ps_p0AMP=OUqfYDMSAtRg@mail.gmail.com>
Subject: Re: [PATCH 5/5] vmlinux.lds.h: replace config_enabled() with IS_ENABLED()
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Marek <mmarek@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rusty Russell <rusty@rustcorp.com.au>, Michal Simek <michal.simek@xilinx.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org
Message-ID: <20160622065205.mSrSIa83ZfqiG6bXi9F-nfXwq1Bcf7oxqUesI4mRghA@z>

Hi Andrew,

2016-06-21 18:25 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday, June 21, 2016 8:20:10 AM CEST Masahiro Yamada wrote:
>> 2016-06-21 5:45 GMT+09:00 Michal Marek <mmarek@suse.cz>:
>> > Dne 14.6.2016 v 07:58 Masahiro Yamada napsal(a):
>> >> The use of config_enabled() against config options is ambiguous.
>> >>
>> >> Now, IS_ENABLED() is implemented purely with macro expansion, so
>> >> let's replace config_enabled() with IS_ENABLED().
>> >>
>> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> >
>> > I applied the whole series to kbuild.git#kbuild.
>> >
>>
>> This series was applied by Andrew Morton last week.
>>
>> I do not want to double it.  Could you drop it?
>
> Andrew usually drops patches from his tree when they show up in
> another maintainer tree.


Now, each patch of this series appears twice in linux-next.

Andrew,
Is it possible to drop this series from your tree?


Thanks

-- 
Best Regards
Masahiro Yamada
