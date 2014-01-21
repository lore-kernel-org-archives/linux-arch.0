Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:60278 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932181AbaAUVoV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 16:44:21 -0500
Message-ID: <52DEEA45.7090503@windriver.com>
Date: Tue, 21 Jan 2014 16:44:37 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
Subject: Re: [PATCH 73/73] include: remove needless instances of <linux/init.h>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>	<1390339396-3479-74-git-send-email-paul.gortmaker@windriver.com> <CAMuHMdX+H-jqmpUt+E6_-pSnFFboS0FPNai+0oBQpJz9qOzJYQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX+H-jqmpUt+E6_-pSnFFboS0FPNai+0oBQpJz9qOzJYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20140121214437.gYw568UPEakPcNCBES6hmVpa7MJtqmiMuqjHjDLvfe0@z>

On 14-01-21 04:37 PM, Geert Uytterhoeven wrote:
> On Tue, Jan 21, 2014 at 10:23 PM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
>> diff --git a/include/linux/zorro.h b/include/linux/zorro.h
>> index 63fbba0..529604b 100644
>> --- a/include/linux/zorro.h
>> +++ b/include/linux/zorro.h
>> @@ -15,7 +15,6 @@
>>  #include <uapi/linux/zorro.h>
>>
>>  #include <linux/device.h>
>> -#include <linux/init.h>
>>  #include <linux/ioport.h>
>>  #include <linux/mod_devicetable.h>
> 
> There's an __initdata below in that file:
> 
> extern struct zorro_dev_init zorro_autocon_init[ZORRO_NUM_AUTO] __initdata;

Aha, that was from a relatively recent commit; I'd done the original
version of this series last year on a tree that didn't have that.
Thanks for spotting it ; appreciate that -- will fix and push.

Paul.
--

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
