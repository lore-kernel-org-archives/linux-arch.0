From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical
 clks
Date: Wed, 3 Jan 2018 09:01:30 -0800
Message-ID: <20180103170130.GW7997@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-5-sboyd@codeaurora.org>
 <CAGb2v67s6JR87nvZ4s1MQ0jG7xj7y0s4C257YWB66xaVCR3c0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53162 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeACRBc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jan 2018 12:01:32 -0500
Content-Disposition: inline
In-Reply-To: <CAGb2v67s6JR87nvZ4s1MQ0jG7xj7y0s4C257YWB66xaVCR3c0Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Michael Turquette <mturquette@baylibre.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>

On 01/03, Chen-Yu Tsai wrote:
> On Wed, Jan 3, 2018 at 9:35 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > We'd like to privatize __clk_get(), but the sunxi clk driver is
> > calling this function to keep a reference held on the clk and
> > call clk_prepare_enable() on it. We support this design in the
> > clk core now with the CLK_IS_CRITICAL flag, so let's just use
> > that instead.
> >
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  drivers/clk/sunxi/clk-factors.c    | 26 +++++++++++++++++++++-----
> >  drivers/clk/sunxi/clk-factors.h    |  4 ++++
> >  drivers/clk/sunxi/clk-mod0.c       |  9 ++-------
> >  drivers/clk/sunxi/clk-sun8i-mbus.c |  7 ++-----
> >  drivers/clk/sunxi/clk-sun9i-core.c |  9 ++-------
> >  drivers/clk/sunxi/clk-sunxi.c      | 36 +++++++++++++-----------------------
> >  6 files changed, 44 insertions(+), 47 deletions(-)
> >
> > diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
> > index 856fef65433b..f6f4757d2dd1 100644
> > --- a/drivers/clk/sunxi/clk-factors.c
> > +++ b/drivers/clk/sunxi/clk-factors.c
> > @@ -176,10 +176,10 @@ static const struct clk_ops clk_factors_ops = {
> >         .set_rate = clk_factors_set_rate,
> >  };
> >
> > -struct clk *sunxi_factors_register(struct device_node *node,
> > -                                  const struct factors_data *data,
> > -                                  spinlock_t *lock,
> > -                                  void __iomem *reg)
> > +struct clk *__sunxi_factors_register(struct device_node *node,
> 
> This looks like it's only used within the file by the two wrapper
> functions. Mark it static?

Ah thanks. I hadn't run sparse yet.

> 
> Otherwise
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> 
> Looks like you picked the easiest (least code changes) for each type
> of clock?

Yep.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
