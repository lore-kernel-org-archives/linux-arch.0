Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S270158AbUJTHby@vger.kernel.org>
Received: from baythorne.infradead.org ([81.187.226.107]:22150 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S270067AbUJTHTF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Oct 2004 03:19:05 -0400
Subject: Re: All archs: NO_IRQ definition
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1098242818.25295.4.camel@gaston>
References: <1098169077.11400.51.camel@gaston>
	 <20041019092238.GK16153@parcelfarce.linux.theplanet.co.uk>
	 <1098178059.13633.1071.camel@hades.cambridge.redhat.com>
	 <1098242818.25295.4.camel@gaston>
Content-Type: text/plain
Message-Id: <1098256674.3872.22.camel@baythorne.infradead.org>
Mime-Version: 1.0
Date: Wed, 20 Oct 2004 08:17:54 +0100
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linux Arch list <linux-arch@vger.kernel.org>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-10-20 at 13:26 +1000, Benjamin Herrenschmidt wrote:
> So what should I do ? Fix probe_irq_off() & friends to return NO_IRQ
> and fix as many drivers as I can find ?

Yes, I think so.

-- 
dwmw2
