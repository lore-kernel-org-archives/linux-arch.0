From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
Date: Wed, 8 Jul 2015 11:07:09 +0530
Message-ID: <559CB705.5010805@synopsys.com>
References: <cover.1434622147.git.viresh.kumar@linaro.org> <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:35742 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbGHFh3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Jul 2015 01:37:29 -0400
In-Reply-To: <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oleksij Rempel <linux@rempel-privat.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Thursday 18 June 2015 04:24 PM, Viresh Kumar wrote:
> Migrate asm9260 driver to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.

Hi Viresh,

Is this series (and other one touching arch/arm/*) specific to ARM event timers.
Are you planning to fixup the drivers in arch/* or the respective maintainers need
to follow suit.

Thx,
-Vineet
