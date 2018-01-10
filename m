Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44248 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753288AbeAJVUm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 16:20:42 -0500
Date: Wed, 10 Jan 2018 13:20:41 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 5/5] clk: Move __clk_{get,put}() into private clk.h API
Message-ID: <20180110212041.GS21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-6-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-6-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Message-ID: <20180110212041.WxEzzJqkrur0jucRDVnW1-qYVzskpbBQmvB-aLnnKCs@z>

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
