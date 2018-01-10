From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/5] clk: Move __clk_{get,put}() into private clk.h API
Date: Wed, 10 Jan 2018 13:20:41 -0800
Message-ID: <20180110212041.GS21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-6-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-6-sboyd@codeaurora.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

On 01/02, Stephen Boyd wrote:
> We can move these APIs into the private header file now that we
> don't have any users of the __clk_get() and __clk_put() APIs
> outside of clkdev.c and clk.c.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
