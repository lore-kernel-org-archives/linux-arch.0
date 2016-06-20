From: Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Date: Mon, 20 Jun 2016 13:03:27 -0400
Message-ID: <1466442207.1887.3.camel@localhost>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org>
 <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "open
 list:RALINK MIPS ARCHI..." <linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Santosh Shilimkar <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liviu Dudau <liviu.dudau-5wv7dgnIgG8@public.gmane.org>, Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, "open
 list:ARM/STI ARCHITECTURE" <kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org>, "open
 list:GENERIC INCLUDE/A..." <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "moderated
 list:H8/300 ARCHITECTURE" <ucl>
List-Id: linux-arch.vger.kernel.org

On Thu, 2016-06-16 at 23:27 +0200, Daniel Lezcano wrote:
> All the clocksource drivers's init function are now converted to return
> an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
> clksrc-of table.
> 
> Let's convert back the names:
>  - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>  - clksrc-of-ret              => clksrc-of
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  arch/arc/kernel/time.c                    |  6 +++---
>  arch/arm/kernel/smp_twd.c                 |  6 +++---
>  arch/microblaze/kernel/timer.c            |  2 +-
>  arch/mips/ralink/cevt-rt3352.c            |  2 +-
>  arch/nios2/kernel/time.c                  |  2 +-
>  drivers/clocksource/arm_arch_timer.c      |  6 +++---
>  drivers/clocksource/arm_global_timer.c    |  2 +-
>  drivers/clocksource/armv7m_systick.c      |  2 +-
>  drivers/clocksource/asm9260_timer.c       |  2 +-
>  drivers/clocksource/bcm2835_timer.c       |  2 +-
>  drivers/clocksource/bcm_kona_timer.c      |  4 ++--
>  drivers/clocksource/cadence_ttc_timer.c   |  2 +-
>  drivers/clocksource/clksrc-dbx500-prcmu.c |  2 +-
>  drivers/clocksource/clksrc-probe.c        | 14 --------------
>  drivers/clocksource/clksrc_st_lpc.c       |  2 +-
>  drivers/clocksource/clps711x-timer.c      |  2 +-
>  drivers/clocksource/dw_apb_timer_of.c     |  8 ++++----
>  drivers/clocksource/exynos_mct.c          |  4 ++--
>  drivers/clocksource/fsl_ftm_timer.c       |  2 +-
>  drivers/clocksource/h8300_timer16.c       |  2 +-
>  drivers/clocksource/h8300_timer8.c        |  2 +-
>  drivers/clocksource/h8300_tpu.c           |  2 +-
>  drivers/clocksource/meson6_timer.c        |  2 +-
>  drivers/clocksource/mips-gic-timer.c      |  2 +-
>  drivers/clocksource/moxart_timer.c        |  2 +-
>  drivers/clocksource/mps2-timer.c          |  2 +-
>  drivers/clocksource/mtk_timer.c           |  2 +-
>  drivers/clocksource/mxs_timer.c           |  2 +-
>  drivers/clocksource/nomadik-mtu.c         |  2 +-
>  drivers/clocksource/pxa_timer.c           |  2 +-
>  drivers/clocksource/qcom-timer.c          |  4 ++--
>  drivers/clocksource/rockchip_timer.c      |  8 ++++----
>  drivers/clocksource/samsung_pwm_timer.c   |  8 ++++----
>  drivers/clocksource/sun4i_timer.c         |  2 +-
>  drivers/clocksource/tango_xtal.c          |  2 +-
>  drivers/clocksource/tegra20_timer.c       |  4 ++--
>  drivers/clocksource/time-armada-370-xp.c  |  6 +++---
>  drivers/clocksource/time-efm32.c          |  4 ++--
>  drivers/clocksource/time-lpc32xx.c        |  2 +-
>  drivers/clocksource/time-orion.c          |  2 +-
>  drivers/clocksource/time-pistachio.c      |  2 +-
>  drivers/clocksource/timer-atlas7.c        |  2 +-
>  drivers/clocksource/timer-atmel-pit.c     |  2 +-
>  drivers/clocksource/timer-atmel-st.c      |  2 +-
>  drivers/clocksource/timer-digicolor.c     |  2 +-
>  drivers/clocksource/timer-imx-gpt.c       | 24 ++++++++++++------------
>  drivers/clocksource/timer-integrator-ap.c |  2 +-
>  drivers/clocksource/timer-keystone.c      |  2 +-
>  drivers/clocksource/timer-nps.c           |  4 ++--
>  drivers/clocksource/timer-oxnas-rps.c     |  4 ++--
>  drivers/clocksource/timer-prima2.c        |  2 +-
>  drivers/clocksource/timer-sp804.c         |  4 ++--
>  drivers/clocksource/timer-stm32.c         |  2 +-
>  drivers/clocksource/timer-sun5i.c         |  4 ++--
>  drivers/clocksource/timer-ti-32k.c        |  2 +-
>  drivers/clocksource/timer-u300.c          |  2 +-
>  drivers/clocksource/versatile.c           |  4 ++--
>  drivers/clocksource/vf_pit_timer.c        |  2 +-
>  drivers/clocksource/vt8500_timer.c        |  2 +-
>  drivers/clocksource/zevio-timer.c         |  2 +-
>  include/asm-generic/vmlinux.lds.h         |  2 --
>  include/linux/clocksource.h               |  5 +----
>  62 files changed, 98 insertions(+), 117 deletions(-)
> 
[..]

> diff --git a/drivers/clocksource/time-lpc32xx.c b/drivers/clocksource/time-lpc32xx.c
> index cb5b866..9649cfd 100644
> --- a/drivers/clocksource/time-lpc32xx.c
> +++ b/drivers/clocksource/time-lpc32xx.c
> @@ -311,4 +311,4 @@ static int __init lpc32xx_timer_init(struct device_node *np)
>  
>  	return ret;
>  }
> -CLOCKSOURCE_OF_DECLARE_RET(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);
> +CLOCKSOURCE_OF_DECLARE(lpc32xx_timer, "nxp,lpc3220-timer", lpc32xx_timer_init);

For LPC32xx driver:
Acked-by: Sylvain Lemieux <slemieux.tyco-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
