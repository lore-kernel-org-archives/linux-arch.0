Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([205.233.218.70]:26507 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751486AbWEUQQP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 21 May 2006 12:16:15 -0400
Subject: Re: [PATCH] move scatterlist accessors into scatterlist.h on ia64,
	sh and sh64
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1148228072.17239.14.camel@mulgrave.il.steeleye.com>
References: <1148221874.17239.3.camel@mulgrave.il.steeleye.com>
	 <1148227178.3875.308.camel@pmac.infradead.org>
	 <1148228072.17239.14.camel@mulgrave.il.steeleye.com>
Content-Type: text/plain
Date: Sun, 21 May 2006 17:16:06 +0100
Message-Id: <1148228166.3875.310.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: linux-arch@vger.kernel.org, lethal@linux-sh.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, 2006-05-21 at 11:14 -0500, James Bottomley wrote:
> I still think it matters from the point of view of logical
> correctness ... you shouldn't be calling virt_to_bus() on an already
> physical address, even if the operation happens to be idempotent on
> the architecture. 

True.

-- 
dwmw2

