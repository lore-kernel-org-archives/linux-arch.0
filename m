From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical
 clks
Date: Wed, 10 Jan 2018 13:20:38 -0800
Message-ID: <20180110212038.GR21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-5-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-5-sboyd@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
List-Id: linux-arch.vger.kernel.org

On 01/02, Stephen Boyd wrote:
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

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
