Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stat9.steeleye.com ([209.192.50.41]:7596 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751432AbWEUQOn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 12:14:43 -0400
Subject: Re: [PATCH] move scatterlist accessors into scatterlist.h on ia64,
	sh and sh64
From: James Bottomley <James.Bottomley@steeleye.com>
In-Reply-To: <1148227178.3875.308.camel@pmac.infradead.org>
References: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
	 <1148227178.3875.308.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Sun, 21 May 2006 11:14:32 -0500
Message-Id: <1148228072.17239.14.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, lethal@linux-sh.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-05-21 at 16:59 +0100, David Woodhouse wrote:
> It doesn't matter for kernel addresses on CPUs like SH and MIPS,
> because
> it's just a mask anyway. There's a 1:1 mapping from virtual<->physical
> addresses, and all you have to do to get a physical address is mask
> out
> the top bits.

I still think it matters from the point of view of logical
correctness ... you shouldn't be calling virt_to_bus() on an already
physical address, even if the operation happens to be idempotent on the
architecture.

James


