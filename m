From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Make most arch asm/module.h files use
	asm-generic/module.h
Date: Wed, 18 Jul 2012 15:41:50 +0200
Message-ID: <20120718134150.GA25202@merkur.ravnborg.org>
References: <32350.1342615619@warthog.procyon.org.uk> <2597.1342617840@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:18923 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753136Ab2GRNlx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jul 2012 09:41:53 -0400
Content-Disposition: inline
In-Reply-To: <2597.1342617840@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>

On Wed, Jul 18, 2012 at 02:24:00PM +0100, David Howells wrote:
> David Howells <dhowells@redhat.com> wrote:
> 
> > Hi Rusty, Arnd,
> > 
> > Here's a patch to asm-genericise the arch asm/module.h files.  It allows four
> > of them to be deleted outright.  MIPS is the only weirdo of the bunch.
> > 
> > The patch can also be found here:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-modsign.git;a=shortlog;h=refs/heads/for-rusty
> > 
> > David
> 
> No sooner had I pushed that than Fengguang Wu found a bug in it.  I've pushed a
> new version to the GIT tree which will find its way to gitweb at some point.
> 
> The problem was that I defined the new config options within the:
> 
> 	if MODULES
> 	...
> 	endif # MODULES
> 
> section within init/Kconfig - but they're statements of fact about the arch and
> are not dependent on whether or not modules are configured.

Stuff like this is better situated in arch/Kconfig.
This is not related to the init part but to the configuration of the
architecture.
For historical reasons we used to use init/Kconfig for this in
the past - but now that we have arch/Kconfig let's use it.

	Sam
