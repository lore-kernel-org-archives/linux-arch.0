From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V2 16/19] csky: SMP support
Date: Sat, 7 Jul 2018 14:16:06 +0800
Message-ID: <20180707061606.GA26276@guoren>
References: <cover.1530465325.git.ren_guo@c-sky.com>
 <21d859826fe19aecaa2aefe3103d6d33e6f1b925.1530465326.git.ren_guo@c-sky.com>
 <20180706052432.q74gql32dtj5gj3b@salmiak>
 <20180706113200.GA27148@guoren>
 <20180706114352.6r7zkjunoafqtr3s@lakrids.cambridge.arm.com>
 <20180706122631.GA30265@guoren>
 <20180706162100.3iimik242cied2c6@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180706162100.3iimik242cied2c6@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 06, 2018 at 05:21:00PM +0100, Mark Rutland wrote:
> Please don't open-code this. Use of_device_is_available(), which checks
> the status property itself. e.g.
> 
> void __init setup_smp(void)
> {
> 	struct device_node *node = NULL;
> 
> 	while ((node = of_find_node_by_type(node, "cpu"))) {
> 		if (!of_device_is_available(node))
> 			continue;
> 
> 		...
> 	}
> }
Ok, approve.

> Please use the reg property, you need it to describe which particular
> CPUs are available.
> 
> You probably also want a mapping from Linux logical CPU id to your
> physical CPU id, and a sanity check on this. See arm64 for an example.
Yes, you are right. Reg property could determine which bit of CPU in
cr<0, 29> could be booted.

Thx for the tips.

 Guo Ren
