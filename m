From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Date: Sat, 18 Jun 2016 15:48:49 +0200
Message-ID: <4420923.qQJUdaA1rI@diego>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org> <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, =?ISO-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander Shiyan <shc_work@mail.ru>, Kukj
List-Id: linux-arch.vger.kernel.org

Am Donnerstag, 16. Juni 2016, 23:27:22 schrieb Daniel Lezcano:
> All the clocksource drivers's init function are now converted to return
> an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
> clksrc-of table.
> 
> Let's convert back the names:
>  - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>  - clksrc-of-ret              => clksrc-of
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/rockchip_timer.c      |  8 ++++----

> diff --git
> a/drivers/clocksource/rockchip_timer.c
> b/drivers/clocksource/rockchip_timer.c index d10bdee..d10e7a5 100644
> --- a/drivers/clocksource/rockchip_timer.c
> +++ b/drivers/clocksource/rockchip_timer.c
> @@ -200,7 +200,7 @@ static int __init rk3399_timer_init(struct device_node
> *np) return rk_timer_init(np, TIMER_CONTROL_REG3399);
>  }
> 
> -CLOCKSOURCE_OF_DECLARE_RET(rk3288_timer, "rockchip,rk3288-timer",
> -			   rk3288_timer_init);
> -CLOCKSOURCE_OF_DECLARE_RET(rk3399_timer, "rockchip,rk3399-timer",
> -			   rk3399_timer_init);
> +CLOCKSOURCE_OF_DECLARE(rk3288_timer, "rockchip,rk3288-timer",
> +		       rk3288_timer_init);
> +CLOCKSOURCE_OF_DECLARE(rk3399_timer, "rockchip,rk3399-timer",
> +		       rk3399_timer_init);

for the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>
