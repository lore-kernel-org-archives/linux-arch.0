From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v6] clocksource/drivers: Suspend/resume Hyper-V
 clocksource for hibernation
Date: Wed, 4 Dec 2019 17:05:59 +0100
Message-ID: <fc5c9000-9753-4f64-2912-3e2a794f5528@linaro.org>
References: <1574233946-48377-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1574233946-48377-1-git-send-email-decui@microsoft.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: decui@microsoft.com, arnd@arndb.de, bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com, Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
