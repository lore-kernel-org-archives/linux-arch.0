From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
Date: Wed, 8 Jul 2015 06:14:46 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075665AC7FB@IN01WEMBXB.internal.synopsys.com>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
 <559CB705.5010805@synopsys.com> <20150708054341.GC19130@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:43435 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752973AbbGHGOz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Jul 2015 02:14:55 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Oleksij Rempel <linux@rempel-privat.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Wednesday 08 July 2015 11:14 AM, Viresh Kumar wrote:
> On 08-07-15, 11:07, Vineet Gupta wrote:
>> Is this series (and other one touching arch/arm/*) specific to ARM event timers.
>> Are you planning to fixup the drivers in arch/* or the respective maintainers need
>> to follow suit.
> Hi Vineet,
>
> I am fixing all clockevent drivers available in Linux kernel, so you
> need not worry :)

Ok I can go back to sleeping peacefully again ;-)

> Changes are kept here for testing by auto-bots, in case you wanna have
> a look at arc patch :).
>
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/clocksource/set-state

LGTM - I'll give it a spin when u send out the series on ml.

Thx,
-Vineet
