From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: [RFC] gpiolib: introduce descriptor-based GPIO interface
Date: Fri, 7 Dec 2012 11:06:34 +0900
Message-ID: <1985305.LiOKDTFPq4@percival>
References: <1354779918-4028-1-git-send-email-acourbot@nvidia.com> <1354779918-4028-2-git-send-email-acourbot@nvidia.com> <20121206144259.136693E0950@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:12665 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422905Ab2LGCGf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Dec 2012 21:06:35 -0500
In-Reply-To: <20121206144259.136693E0950@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gnurou@gmail.com" <gnurou@gmail.com>

On Thursday 06 December 2012 22:42:59 Grant Likely wrote:
> how about "gpio_chip_hwnum()" to somewhat match irqdomain convention?

Sure, matching existing interfaces is better. "git grep hwnum" does not seem 
to reveal much related to irqdomain though?

> I've only lightly scanned this patch, but I like what I see. I would
> keep going with it.

Fantastic then - I just wanted to make sure things were not completely broken 
from the beginning. Since you and Linus W. seem to approve this, I will flush 
what I have in my head and publish a proper series for review.

Thanks!
Alex.
