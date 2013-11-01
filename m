From: Domenico Andreoli <cavokz@gmail.com>
Subject: Re: [PATCH 00/11] RFC: Common machine reset handling
Date: Fri, 1 Nov 2013 06:16:10 +0100
Message-ID: <20131101051610.GA28233@glitch>
References: <20131031062708.520968323@linux.com>
 <5272D05E.1070207@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:57108 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941Ab3KAFQU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Nov 2013 01:16:20 -0400
Received: by mail-ee0-f49.google.com with SMTP id e52so1766661eek.36
        for <linux-arch@vger.kernel.org>; Thu, 31 Oct 2013 22:16:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5272D05E.1070207@wwwdotorg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Domenico Andreoli <domenico.andreoli@linux.com>, linux-arch@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org

On Thu, Oct 31, 2013 at 03:49:18PM -0600, Stephen Warren wrote:
> On 10/31/2013 12:27 AM, Domenico Andreoli wrote:
> > Hi,
> > 
> >   I've been looking for a solution to my bcm4760 watchdog based restart
> > hook when I noticed that the kernel reboot/shutdown mechanism is having
> > a few unaddressed issues.
> > 
> > Those I identified are:
> > 
> >  1) context pointer often needed by the reset hook
> >     (currently local static data is used for this pourpose)
> >  2) unclear ownership/policy in case of multiple reset hooks
> >     (currently almost nobody seems to care much)
> 
> I'm not sure how this patchset solves (2); even with the new API, it's
> still the case that whichever code calls set_machine_reset() last wins,
> just like before where whichever code wrote to pm_power_off won. I'm not
> sure what this series attempts to solve.

That's right, the last wins. But the previous has a chance to know.

I only supposed there is somebody in charge of selecting the best handler
for the machine. Don't know how fancy this decision is but at least for
the vexpress there is also a sysfs way to configure different reset methods
from user-space.

So cleaning up things after the handler is replaced seemed a sensible
thing to do.

Another "problem" this patch would solve is the registration of the
reset handler in a architecture independent way. Now an otherwise platform
generic gpio HW reset driver would need to do different things on different
architectures.

thanks,
Domenico
