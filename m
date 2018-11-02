Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35918 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbeKCBHV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Nov 2018 21:07:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id z13-v6so105372wrs.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Nov 2018 08:59:46 -0700 (PDT)
Subject: Re: [PATCH V13 0/2] C-SKY(csky) Timer Driver
References: <cover.1540947083.git.ren_guo@c-sky.com>
 <8ce6d07f-6608-dcb2-6394-00a18d726988@linaro.org>
 <20181102121623.GA14721@guoren-Inspiron-7460>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <52013026-67d8-c3e0-e780-4449ff08b5a1@linaro.org>
Date: Fri, 2 Nov 2018 16:59:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181102121623.GA14721@guoren-Inspiron-7460>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: tglx@linutronix.de, arnd@arndb.de, linux-arch@vger.kernel.org, devicetree@vger.kernel.org

On 02/11/2018 13:17, Guo Ren wrote:
> Hi Daniel,
> 
> Thx for reply.
> 
> On Fri, Nov 02, 2018 at 12:16:39PM +0100, Daniel Lezcano wrote:
>>
>> Hi Guo,
>>
>> On 31/10/2018 03:06, Guo Ren wrote:
>>> Hi Daniel & Thomas,
>>>
>>> I sent you "PATCH V13" a few days ago, but no-reply:
>>> https://lkml.org/lkml/2018/10/29/608
>>> Now I send again.
>>
>> Where are the DT bindings ?
> I've sent you PATCH V13 before, see here:
> https://lore.kernel.org/lkml/ad5c91023ae9bbb07aa0392882667a5a2b133fc5.1539579760.git.ren_guo@c-sky.com/
> https://lore.kernel.org/lkml/0f7cbde6462150c6ddb058d89d59ce35c3d6da9f.1539579760.git.ren_guo@c-sky.com/
> dt-bingdings docs have been reivewed-by Rob Herring.
> 
> If necessory, I could send PATCH V13 again with dt-bindings.
> 
>>
>> please (cc lkml when sending patches)
> Ok, got it. I'll cc lkml next.

Yes, please resend the patches you want upstream with dt-bindings and
prefix with resend in the subject. I will take them, fix some formatting
and send the PR to Thomas.

Don't forget to Cc lkml@, so I can use my tools to retrieve the series.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
