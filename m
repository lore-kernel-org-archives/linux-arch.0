From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2 0/3] make Xilinx System ACE driver arch-independent
Date: Tue, 25 Jun 2013 04:15:59 +0000
Message-ID: <4881796E12491D4BB15146FE0209CE643F5FFB8E@DE02WEMBXB.internal.synopsys.com>
References: <1372062364-25861-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from alvesta.synopsys.com ([198.182.60.77]:45429 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab3FYEQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 00:16:04 -0400
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Mischa Jonker <Mischa.Jonker@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Michal Simek <monstr@monstr.eu>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Shevchenko <andy.shevchenko@gmail.com>

On 06/24/2013 12:26 PM, Alexey Brodkin wrote:
> In v2 I put together 3 patches:
> 1. Blind replace of PPC/Microblaze-specific accessors with generic ones.
> 2. Fix functions that access data via dedicated register in SystemACE controller
> so now CPU accesses data with native endianess.
> 3. Remove dependency on PPC/Microblaze - i.e. make driver arch-independent.

Any comments on this patch-set?

-Alexey
