From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Date: Thu, 31 Oct 2013 10:21:48 +0000
Message-ID: <20131031102148.GW16735@n2100.arm.linux.org.uk>
References: <20131031062708.520968323@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42141 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754043Ab3JaKWH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 06:22:07 -0400
Content-Disposition: inline
In-Reply-To: <20131031062708.520968323@linux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@lvger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Ralf Baechle <ralf@linux-mips.org>

On Thu, Oct 31, 2013 at 07:27:08AM +0100, Domenico Andreoli wrote:
> Hi,
> 
>   I've been looking for a solution to my bcm4760 watchdog based restart
> hook when I noticed that the kernel reboot/shutdown mechanism is having
> a few unaddressed issues.
> 
> Those I identified are:
> 
>  1) context pointer often needed by the reset hook
>     (currently local static data is used for this pourpose)

I don't think that's a problem at all.

> I don't see these impressive diffstats but at least it's possible to free
> some static data along the way. Maybe there are some other desiderata that
> could be satisfied?

If that's the only benefit, then I don't think this is worth the churn,
sorry.
