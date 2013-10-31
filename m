From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Date: Thu, 31 Oct 2013 15:49:18 -0600
Message-ID: <5272D05E.1070207@wwwdotorg.org>
References: <20131031062708.520968323@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60559 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751940Ab3JaVtW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 31 Oct 2013 17:49:22 -0400
In-Reply-To: <20131031062708.520968323@linux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Domenico Andreoli <domenico.andreoli@linux.com>, linux-arch@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@lvger.kernel.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
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
>  2) unclear ownership/policy in case of multiple reset hooks
>     (currently almost nobody seems to care much)

I'm not sure how this patchset solves (2); even with the new API, it's
still the case that whichever code calls set_machine_reset() last wins,
just like before where whichever code wrote to pm_power_off won. I'm not
sure what this series attempts to solve.
