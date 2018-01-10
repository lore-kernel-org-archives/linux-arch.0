From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/5] clk: Prepare to remove asm-generic/clkdev.h
Date: Wed, 10 Jan 2018 13:20:28 -0800
Message-ID: <20180110212028.GP21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-3-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-3-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

On 01/02, Stephen Boyd wrote:
> Now that all the users of asm/clkdev.h have been replaced with
> the generic file we can get rid of the asm-generic file as well
> and implement that code directly where it's used.
> 
> We only have one caller of __clkdev_alloc(), in clkdev.c so we
> can easily remove that and drop the include of asm/clkdev.h in
> linux/clkdev.h by putting the __clk_get/__clk_put inlines in
> their respective location.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
