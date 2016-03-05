From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
Date: Fri, 4 Mar 2016 16:43:36 -0800
Message-ID: <20160305004336.GG55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com>
 <5158260.vK2YuWzYIn@wuerfel>
 <20160305002203.GF55664@google.com>
 <1457137718.43867.266.camel@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34297 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759049AbcCEAnj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 19:43:39 -0500
Content-Disposition: inline
In-Reply-To: <1457137718.43867.266.camel@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org

On Sat, Mar 05, 2016 at 12:28:38AM +0000, David Woodhouse wrote:
> On Fri, 2016-03-04 at 16:22 -0800, Brian Norris wrote:
> > 
> > ...but, does anyone care about XIP / MTD_XIP then, if the first two
> > examples we have both have long-standing build issues?
> 
> I think there are people trying to make it work on other platforms,
> yes.

OK... can we kill the broken platforms though? I'm not confident that my
and Arnd's workaround attempts will yield anything more than a pat on
our own backs to say "yay, it compiles!" And given the number of
practically unused things we're already maintaining in MTD, I'm always
happy for an excuse to kill off some of it.

Brian
