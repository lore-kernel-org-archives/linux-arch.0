From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 6/7] clocksource: Rename CLKSRC_OF to TIMER_OF
Date: Sun, 28 May 2017 11:18:40 +0200
Message-ID: <3bea2d43-e582-5b62-03df-3557028cc4b8@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
 <1495879129-28109-6-git-send-email-daniel.lezcano@linaro.org>
 <20170528030058.GC4528@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20170528030058.GC4528@dragon>
Content-Language: en-US
Sender: linux-sh-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.o>
List-Id: linux-arch.vger.kernel.org

On 28/05/2017 05:00, Shawn Guo wrote:
> On Sat, May 27, 2017 at 11:58:47AM +0200, Daniel Lezcano wrote:
>> diff --git a/arch/arm/mach-imx/epit.c b/arch/arm/mach-imx/epit.c
>> index fb9a73a..4a4d2e2 100644
>> --- a/arch/arm/mach-imx/epit.c
>> +++ b/arch/arm/mach-imx/epit.c
>> @@ -39,7 +39,7 @@
>>  #define EPITCR_OM_TOGGLE		(1 << 22)
>>  #define EPITCR_OM_CLEAR			(2 << 22)
>>  #define EPITCR_OM_SET			(3 << 22)
>> -#define EPITCR_CLKSRC_OFF		(0 << 24)
>> +#define EPITCR_TIMER_OFF		(0 << 24)
>>  #define EPITCR_CLKSRC_PERIPHERAL	(1 << 24)
>>  #define EPITCR_CLKSRC_REF_HIGH		(1 << 24)
>>  #define EPITCR_CLKSRC_REF_LOW		(3 << 24)
> 
> I do not think this change should be there.

Right. Thanks!


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

