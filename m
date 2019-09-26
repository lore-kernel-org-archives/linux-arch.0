Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42434 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfIZNQr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Sep 2019 09:16:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so1821477pff.9
        for <linux-arch@vger.kernel.org>; Thu, 26 Sep 2019 06:16:47 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
References: <1567723581-29088-1-git-send-email-decui@microsoft.com>
 <1567723581-29088-4-git-send-email-decui@microsoft.com>
 <8ba5e2fd-6a9f-b61b-685e-23a69cabe3a2@linaro.org>
 <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <17e5a535-8597-4780-7cd0-e8c4d2aa8f0f@linaro.org>
Date: Thu, 26 Sep 2019 15:16:43 +0200
MIME-Version: 1.0
In-Reply-To: <PU1P153MB0169A28B05A7CDE04A57AA58BF870@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dexuan Cui <decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>, Haiyang Zhang <haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>, KY Srinivasan <kys@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, "sashal@kernel.org" <sashal@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, "x86@kernel.org" <x86@kernel.org>, Michael Kelley <mikelley@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190926131643.-EQpEUYAAlHo30Y6DX9GH4LG3pEfF8IyayoSt1PRHS0@z>

On 26/09/2019 01:35, Dexuan Cui wrote:
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Sent: Wednesday, September 25, 2019 4:21 PM
>> To: Dexuan Cui <decui@microsoft.com>; arnd@arndb.de; bp@alien8.de;
>> Haiyang Zhang <haiyangz@microsoft.com>; hpa@zytor.com; KY Srinivasan
>> <kys@microsoft.com>; linux-hyperv@vger.kernel.org;
>> linux-kernel@vger.kernel.org; mingo@redhat.com; sashal@kernel.org; Stephen
>> Hemminger <sthemmin@microsoft.com>; tglx@linutronix.de; x86@kernel.org;
>> Michael Kelley <mikelley@microsoft.com>; Sasha Levin
>> <Alexander.Levin@microsoft.com>
>> Cc: linux-arch@vger.kernel.org
>> Subject: Re: [PATCH v5 3/3] clocksource/drivers: Suspend/resume Hyper-V
>> clocksource for hibernation
>>
>> On 06/09/2019 00:47, Dexuan Cui wrote:
>>> This is needed for hibernation, e.g. when we resume the old kernel, we need
>>> to disable the "current" kernel's TSC page and then resume the old kernel's.
>>>
>>> Signed-off-by: Dexuan Cui <decui@microsoft.com>
>>> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
>>
>> I can take this patch if needed.
> 
> Thanks, Daniel! Usually tglx takes care of the patches, but it looks recently he
> may be too busy to handle the 3 patches. 
> 
> I guess you can take the patch, if tglx has no objection. :-)
> If you take the patch, please take all the 3 patches.

I maintain drivers/clocksource for the tip/timers/core branch. I don't
want to proxy another tip branch as it is out of my jurisdiction.

So I can take patch 3/3 but will let the other 2 patches to be picked by
the right person. It is your call.



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
