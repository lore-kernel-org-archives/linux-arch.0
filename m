From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 00/11] test_user_copy improvements
Date: Wed, 12 Aug 2015 14:34:10 -0700 (PDT)
Message-ID: <20150812.143410.1500869614245341672.davem@davemloft.net>
References: <20150810.152938.1076489414700359615.davem@redhat.com>
	<20150810.210804.1413406155445559341.davem@davemloft.net>
	<CAMuHMdUzHwm5_TL7TNAOF+uqheJnKgsqF+_vzqGRzB_3eufKug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:60161 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbbHLVeM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 12 Aug 2015 17:34:12 -0400
In-Reply-To: <CAMuHMdUzHwm5_TL7TNAOF+uqheJnKgsqF+_vzqGRzB_3eufKug@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: geert@linux-m68k.org
Cc: james.hogan@imgtec.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, keescook@chromium.org, akpm@linux-foundation.org, monstr@monstr.eu, lftan@altera.com, jonas@southpole.se, chris@zankel.net, jcmvbkbc@gmail.com, nios2-dev@lists.rocketboards.org, linux@lists.openrisc.net, linux-xtensa@linux-xtensa.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Aug 2015 13:20:53 +0200

> On Tue, Aug 11, 2015 at 6:08 AM, David Miller <davem@davemloft.net> wrote:
 ...
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 3a2ef67..149eb29 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -62,6 +62,9 @@ config ARCH_USE_CMPXCHG_LOCKREF
>>  config ARCH_HAS_FAST_MULTIPLIER
>>         bool
>>
>> +config ARCH_SPLIT_VA_SPACE
>> +       def_bool n
>> +
>>  config CRC_CCITT
>>         tristate "CRC-CCITT functions"
>>         help
> 
> I think this applies to a few more architectures.
> 
> M68k already has a config symbol for his (CPU_HAS_ADDRESS_SPACES),
> which is set by classic m68k (not Coldfire) that has the "moves" instruction.

Awesome, maybe James can add the M68K case to his patch as well.
