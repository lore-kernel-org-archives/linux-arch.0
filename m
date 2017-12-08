From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 24/33] nds32: Device tree support
Date: Fri, 8 Dec 2017 10:23:45 +0000
Message-ID: <20171208102345.jjtlor7pr26lpbwx@lakrids.cambridge.arm.com>
References: <cover.1512723245.git.green.hu@gmail.com>
 <c1083b6f603aeeb13c72c501214e82549404fa5c.1512723245.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36424 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753176AbdLHKXw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Dec 2017 05:23:52 -0500
Content-Disposition: inline
In-Reply-To: <c1083b6f603aeeb13c72c501214e82549404fa5c.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, greg@kroah.com, Vincent Chen <vincentc@andestech.com>

On Fri, Dec 08, 2017 at 05:12:07PM +0800, Greentime Hu wrote:
> +	timer0: timer@f0400000 {
> +		compatible = "andestech,atcpit100";
> +		reg = <0xf0400000 0x1000>;
> +		interrupts = <2>;
> +		clocks = <&clk_pll>;
> +		clock-names = "apb_pclk";
> +		cycle-count-offset = <0x38>;
> +		cycle-count-down;
> +	};

The cover leter mentioned the atcpit100 driver had been removed, but the
node is still here, and the vdso code seems to look for this node.

This binding needs documentation.

Thanks,
Mark.
