From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v1 17/40] metag: IRQ handling
Date: Wed, 19 Dec 2012 15:58:57 +0000
Message-ID: <201212191558.57271.arnd@arndb.de>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211201615.30481.arnd@arndb.de> <50D06EAF.4050200@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:65341 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113Ab2LSP7D (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 19 Dec 2012 10:59:03 -0500
In-Reply-To: <50D06EAF.4050200@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-arch@vger.kernel.org, Grant <grant.likely@secretlab.ca>

On Tuesday 18 December 2012, James Hogan wrote:
> > Anything that is probed as a platform device can get the interrupt numbers
> > using the device resources that are filled in by the device tree probe.
> > 
> > If you need something earlier, you can call irq_of_parse_and_map()
> > manually.
> 
> So does that leave any way for a non-GPL driver to simply get an IRQ
> number? Reading the code I can't find a way other than using legacy irq
> domains (are they acceptable for new architecture ports?).

Yes, I think that is correct. I assume it's also intentional, but I am
not completely sure since it is not my code.

> * I think the usual way is to specify an IRQ in a module parameter, but
> that no longer makes any sense as it would need mapping.

That is also a really bad interface in general. We stopped doing it this
way after linux-2.4 for in-kernel drivers.

> irq_create_mapping could have worked (maybe taking advantage of the
> irq_default_domain), but it's EXPORT_SYMBOL_GPL.
> * Using a platform driver isn't possible because
> platform_driver_register and friends are EXPORT_SYMBOL_GPL.
> * Similarly irq_of_parse_and_map is EXPORT_SYMBOL_GPL (except for sparc
> curiously enough).

Interestingly, the amba_driver interfaces don't have the GPL annotation.
I assume that at the time when platform_driver was introduced, nobody
considered the possibility that there would be a goood reason to
have this used in drivers ported from other operating systems under
an incompatible license. It's probably impossible to change that
now, given the number of individual contributions that have been
added to the platform driver infrastructure over the years.

> So what would be the expected way to do that with linear irq domains?

I think the best answer to that is "you're screwed".  There may be
a way to change the interfaces to just EXPORT_SYMBOL if you can make
a good case about a specific driver needing it, but my suspicion is
that that's not likely to be successful when coming from an imgtec.com
address or without details about the driver that needs it ;-)

	Arnd
