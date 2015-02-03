Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41257 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbbBCItI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2015 03:49:08 -0500
Date: Tue, 3 Feb 2015 00:48:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] change non-atomic bitops method
Message-ID: <20150203004841.b48e84df.akpm@linux-foundation.org>
In-Reply-To: <20150203.004031.593368249759204527.davem@davemloft.net>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
	<35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
	<20150202223851.f30768d0.akpm@linux-foundation.org>
	<20150203.004031.593368249759204527.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: Yalin.Wang@sonymobile.com, kirill@shutemov.name, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
Message-ID: <20150203084841.DXMdEI2eAsOo2gjNsnm_2kpPK644tHY80Dn4VYPJ2RM@z>

On Tue, 03 Feb 2015 00:40:31 -0800 (PST) David Miller <davem@davemloft.net> wrote:

> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Mon, 2 Feb 2015 22:38:51 -0800
> 
> > It is only with both these ratios that we can work out whether the
> > patch is a net gain.  My suspicion is that set_bit on an already-set
> > bit is so rare that the patch will be a loss.
> 
> A common pattern is implementing a "referenced" bit, and in that case
> the bit is often already set, and in such a scenerio the proposed
> change is a huge win.

pagecache, dcache and icache already perform this optimisation (and
only pagecache uses bitops for it anyway).  I'm not sure what's left.

But there's really no point in speculating about this - it's trivial to
instrument the kernel and get real numbers.
