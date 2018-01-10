Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44030 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeAJVUa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 16:20:30 -0500
Date: Wed, 10 Jan 2018 13:20:28 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/5] clk: Prepare to remove asm-generic/clkdev.h
Message-ID: <20180110212028.GP21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-3-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-3-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Message-ID: <20180110212028.946EcxGjIs2u-fdPz7mx9VNzXQNre6LpdoiuUlDwwYQ@z>

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
