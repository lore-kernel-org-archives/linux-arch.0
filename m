From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 2/9] percpu: use dynamic percpu allocator as the
	default percpu allocator
Date: Wed, 17 Jun 2009 09:32:51 -0400
Message-ID: <20090617133251.GB19032@bombadil.infradead.org>
References: <1245210060-24344-1-git-send-email-tj@kernel.org> <1245210060-24344-3-git-send-email-tj@kernel.org> <1245242459.4503.4.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:34714 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbZFQNdA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Jun 2009 09:33:00 -0400
Content-Disposition: inline
In-Reply-To: <1245242459.4503.4.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>, Parisc List <linux-parisc@vger.kernel.org>

On Wed, Jun 17, 2009 at 08:40:59AM -0400, James Bottomley wrote:
> > * parisc (broken, under investigation)
> 
> I haven't seen anything of this on the parisc list ... what's the
> problem?  and do you need systems or any other help to fix it?
> 

Ah, maybe that was only on linux-kernel or in private mail; we're
oops-ing again in the oops-handler... I almost had this debugged last
weekend, but ran out of time.
