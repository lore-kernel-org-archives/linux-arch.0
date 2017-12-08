From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 24/33] nds32: Device tree support
Date: Fri, 8 Dec 2017 10:27:00 +0000
Message-ID: <20171208102700.g6wy4suhwmwnd4ix@lakrids.cambridge.arm.com>
References: <cover.1512723245.git.green.hu@gmail.com>
 <c1083b6f603aeeb13c72c501214e82549404fa5c.1512723245.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c1083b6f603aeeb13c72c501214e82549404fa5c.1512723245.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, greg@kroah.com, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Dec 08, 2017 at 05:12:07PM +0800, Greentime Hu wrote:
> +	timer0: timer@98400000 {
> +		compatible = "andestech,atftmr010";
> +		reg = <0x98400000 0x1000>;
> +		interrupts = <19>;
> +		clocks = <&clk_pll>;
> +		clock-names = "apb_pclk";
> +		cycle-count-offset = <0x20>;
> +	};

Looking through the series, I can't find a binding or driver for this
timer, either.

Does timekeeping work with this series, or are additional patches
necessary?

Thanks,
Mark.
