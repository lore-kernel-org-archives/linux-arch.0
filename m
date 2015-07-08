From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 01/41] clocksource: asm9260: Migrate to new 'set-state'
 interface
Date: Wed, 8 Jul 2015 11:13:41 +0530
Message-ID: <20150708054341.GC19130@linux>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <57ae9434bbb7218961c3ad45a26fbe1fffe40cbd.1434622147.git.viresh.kumar@linaro.org>
 <559CB705.5010805@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <559CB705.5010805@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Oleksij Rempel <linux@rempel-privat.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 08-07-15, 11:07, Vineet Gupta wrote:
> Is this series (and other one touching arch/arm/*) specific to ARM event timers.
> Are you planning to fixup the drivers in arch/* or the respective maintainers need
> to follow suit.

Hi Vineet,

I am fixing all clockevent drivers available in Linux kernel, so you
need not worry :)

I stopped a bit because of a dependency patch, which just got included
in tip tree yesterday. Once that gets into next rc release (hopefully
-4.2-rc2), I will send all the patches I have. At that point, these
changes wouldn't have any dependency on clockevents tree and
maintainers like you can apply them directly.

Changes are kept here for testing by auto-bots, in case you wanna have
a look at arc patch :).

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git clkevt/clocksource/set-state

-- 
viresh
