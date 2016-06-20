From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 5/5] vmlinux.lds.h: replace config_enabled() with IS_ENABLED()
Date: Tue, 21 Jun 2016 08:20:10 +0900
Message-ID: <CAK7LNAR4mdwQqsf4xhtsMA7FEuAqNMEzE+6HkYCW30qLbKb1=A@mail.gmail.com>
References: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com>
 <1465883938-25194-5-git-send-email-yamada.masahiro@socionext.com> <576855FD.6020202@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from condef009-v.nifty.com ([210.131.4.246]:37917 "EHLO
	condef009-v.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbcFTX2s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2016 19:28:48 -0400
In-Reply-To: <576855FD.6020202@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Michal Simek <michal.simek@xilinx.com>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org

2016-06-21 5:45 GMT+09:00 Michal Marek <mmarek@suse.cz>:
> Dne 14.6.2016 v 07:58 Masahiro Yamada napsal(a):
>> The use of config_enabled() against config options is ambiguous.
>>
>> Now, IS_ENABLED() is implemented purely with macro expansion, so
>> let's replace config_enabled() with IS_ENABLED().
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> I applied the whole series to kbuild.git#kbuild.
>

This series was applied by Andrew Morton last week.

I do not want to double it.  Could you drop it?




-- 
Best Regards
Masahiro Yamada
