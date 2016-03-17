Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:50884 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935075AbcCQP53 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 11:57:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Thu, 17 Mar 2016 16:56:33 +0100
Message-ID: <4420020.GISMAEPJsq@wuerfel>
In-Reply-To: <20160305004336.GG55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de> <1457137718.43867.266.camel@infradead.org> <20160305004336.GG55664@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arch@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20160317155633.YDIAHeLEPsvIzd90HWTkCOnqswfAar-Z6UghHb6iJxU@z>

On Friday 04 March 2016 16:43:36 Brian Norris wrote:
> On Sat, Mar 05, 2016 at 12:28:38AM +0000, David Woodhouse wrote:
> > On Fri, 2016-03-04 at 16:22 -0800, Brian Norris wrote:
> > > 
> > > ...but, does anyone care about XIP / MTD_XIP then, if the first two
> > > examples we have both have long-standing build issues?
> > 
> > I think there are people trying to make it work on other platforms,
> > yes.
> 
> OK... can we kill the broken platforms though? I'm not confident that my
> and Arnd's workaround attempts will yield anything more than a pat on
> our own backs to say "yay, it compiles!" And given the number of
> practically unused things we're already maintaining in MTD, I'm always
> happy for an excuse to kill off some of it.

Sorry for the late reply.

As the three platforms that use this have all been broken for around
ten years, it seems reasonable to assume nobody is going to miss the
current implementation, but I'd leave it up to the individual platform
maintainers.

If we remove all three, that would also give us more flexibility
regarding the interface definition for any future users of the feature.
I think the most likely to use it is the Renesas RZ/A1H platform
with its 10MB of on-chip SRAM, and this one doesn't work with the
current method anyway.

	Arnd
