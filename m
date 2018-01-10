Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44182 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753151AbeAJVUk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 16:20:40 -0500
Date: Wed, 10 Jan 2018 13:20:38 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 4/5] clk: sunxi: Use CLK_IS_CRITICAL flag for critical
 clks
Message-ID: <20180110212038.GR21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-5-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-5-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>
Message-ID: <20180110212038.zOEa_7Y6fMvf5KId6S_XWl0SoL9gb3ApywSN8KG-8bY@z>

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
