From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 11/24] C6X: interrupt handling
Date: Tue, 23 Aug 2011 07:29:21 +1000
Message-ID: <1314048561.7662.41.camel@pasglop>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com>
	 <1314043785-2880-12-git-send-email-msalter@redhat.com>
	 <2384053.HX3gjK1Rxm@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:52942 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753740Ab1HVV3u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 22 Aug 2011 17:29:50 -0400
In-Reply-To: <2384053.HX3gjK1Rxm@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Grant Likely <grant@secretlab.ca>

On Mon, 2011-08-22 at 22:58 +0200, Arnd Bergmann wrote:
> On Monday 22 August 2011 16:09:32 Mark Salter wrote:
> > 
> > Most of the code in arch/c6x/kernel/irq.c which supports mapping of hardware
> > interrupts to virtual kernel interrupts was taken as-is from powerpc. Very
> > few changes were necessary for C6X, so separating that out into the generic
> > kernel interrupt code may be worthwhile for cases where other architectures
> > may want to use it.
> 
> What's the status on this? Did you talk about this with Thomas and/or BenH?

Grant (CC) has some patches already (upstream yet ?) tho they haven't
yet covered the full functionality of the ppc remapper, so I don't know
if they are enough for you at this point.

Cheers,
Ben.
