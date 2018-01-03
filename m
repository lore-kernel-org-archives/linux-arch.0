From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical clks
Date: Wed, 3 Jan 2018 10:58:26 +0800
Message-ID: <CAGb2v67s6JR87nvZ4s1MQ0jG7xj7y0s4C257YWB66xaVCR3c0Q@mail.gmail.com>
References: <20180103013516.18844-1-sboyd@codeaurora.org> <20180103013516.18844-5-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.csie.ntu.edu.tw ([140.112.30.61]:52432 "EHLO
        smtp.csie.ntu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeACC6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Jan 2018 21:58:52 -0500
In-Reply-To: <20180103013516.18844-5-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>

On Wed, Jan 3, 2018 at 9:35 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> We'd like to privatize __clk_get(), but the sunxi clk driver is
> calling this function to keep a reference held on the clk and
> call clk_prepare_enable() on it. We support this design in the
> clk core now with the CLK_IS_CRITICAL flag, so let's just use
> that instead.
>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  drivers/clk/sunxi/clk-factors.c    | 26 +++++++++++++++++++++-----
>  drivers/clk/sunxi/clk-factors.h    |  4 ++++
>  drivers/clk/sunxi/clk-mod0.c       |  9 ++-------
>  drivers/clk/sunxi/clk-sun8i-mbus.c |  7 ++-----
>  drivers/clk/sunxi/clk-sun9i-core.c |  9 ++-------
>  drivers/clk/sunxi/clk-sunxi.c      | 36 +++++++++++++-----------------------
>  6 files changed, 44 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> index 856fef65433b..f6f4757d2dd1 100644
> --- a/drivers/clk/sunxi/clk-factors.c
> +++ b/drivers/clk/sunxi/clk-factors.c
> @@ -176,10 +176,10 @@ static const struct clk_ops clk_factors_ops = {
>         .set_rate = clk_factors_set_rate,
>  };
>
> -struct clk *sunxi_factors_register(struct device_node *node,
> -                                  const struct factors_data *data,
> -                                  spinlock_t *lock,
> -                                  void __iomem *reg)
> +struct clk *__sunxi_factors_register(struct device_node *node,

This looks like it's only used within the file by the two wrapper
functions. Mark it static?

Otherwise

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Looks like you picked the easiest (least code changes) for each type
of clock?
