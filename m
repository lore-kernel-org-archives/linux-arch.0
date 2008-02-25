Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37055 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010AbYBYNj1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Feb 2008 08:39:27 -0500
Date: Mon, 25 Feb 2008 13:38:46 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: regression: 2f569af (CONFIG_HIGHPTE vs. sub-page page tables.)
Message-ID: <20080225133846.GA9945@flint.arm.linux.org.uk>
References: <20080225132648.GA13791@digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20080225132648.GA13791@digi.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Mon, Feb 25, 2008 at 02:26:48PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> I see the following:
> 
> 	/ # for i in 1 2 3; do grep PageTables /proc/meminfo; done
> 	PageTables:          4 kB
> 	PageTables:   4294967292 kB
> 	PageTables:   4294967284 kB
> 
> and I bisected it down to 2f569af (CONFIG_HIGHPTE vs. sub-page page
> tables.)  This still happens in 2.6.25-rc3.
> 
> I have not investigated further, so I cannot tell if it's only the
> output in meminfo that is broken.
> 
> This is on ARCH=arm, on a Digi cc9p9360 with ns9xxx_defconfig.

Note that there's been other reports of this on other ARM platforms as
well.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
