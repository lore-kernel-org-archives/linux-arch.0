Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44100 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753396AbeAJVUf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 16:20:35 -0500
Date: Wed, 10 Jan 2018 13:20:33 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 3/5] arch: Remove clkdev.h asm-generic from Kbuild
Message-ID: <20180110212033.GQ21040@codeaurora.org>
References: <20180103013516.18844-1-sboyd@codeaurora.org>
 <20180103013516.18844-4-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103013516.18844-4-sboyd@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Turquette <mturquette@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20180110212033._igOu0OsrtgXsWARXGfb--XQZiViAbTe4NuCB4YFhBk@z>

On 01/02, Stephen Boyd wrote:
> Now that every architecture is using the generic clkdev.h file
> and we no longer include asm/clkdev.h anywhere in the tree, we
> can remove it.
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <linux-arch@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
