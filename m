Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55537 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfLDQGF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Dec 2019 11:06:05 -0500
Received: by mail-wm1-f65.google.com with SMTP id q9so266165wmj.5
        for <linux-arch@vger.kernel.org>; Wed, 04 Dec 2019 08:06:02 -0800 (PST)
Subject: Re: [PATCH v6] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
References: <1574233946-48377-1-git-send-email-decui@microsoft.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fc5c9000-9753-4f64-2912-3e2a794f5528@linaro.org>
Date: Wed, 4 Dec 2019 17:05:59 +0100
MIME-Version: 1.0
In-Reply-To: <1574233946-48377-1-git-send-email-decui@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: decui@microsoft.com, arnd@arndb.de, bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org
Message-ID: <20191204160559.G_FeyQc2drKp0vlCKbVuqpj8hGJuU-Zls9lYp4HdTSg@z>

On 20/11/2019 08:12, Dexuan Cui wrote:
> This is needed for hibernation, e.g. when we resume the old kernel, we need
> to disable the "current" kernel's TSC page and then resume the old kernel's.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>
> ---
> 
> This patch is part of the v5 patchset:
>   https://lkml.org/lkml/2019/9/5/1158
>   https://lkml.org/lkml/2019/9/5/1161
> 
>   Actually v6 is the same as v1 (v2~v5 were posted with the other patches).
> 
>   Please pick up this patch into the tip.git tree, probably onto the branch
> timers/core.

Applied, thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
