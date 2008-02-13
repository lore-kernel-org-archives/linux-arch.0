Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:43341 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755585AbYBMJEo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Feb 2008 04:04:44 -0500
Date: Wed, 13 Feb 2008 10:04:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: distributed module configuration
Message-ID: <20080213090451.GA8319@uranus.ravnborg.org>
References: <20080212191552.GA20883@kroah.com> <20080212.164149.209357519.davem@davemloft.net> <20080213084541.GA8091@uranus.ravnborg.org> <20080213.005433.23276743.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080213.005433.23276743.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: greg@kroah.com, torvalds@linux-foundation.org, jeff@garzik.org, arjan@infradead.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kbuild@vger.kernel.org

On Wed, Feb 13, 2008 at 12:54:33AM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 13 Feb 2008 09:45:41 +0100
> 
> > So we could do:
> > 
> > config foo
> > 	tristate "do you want foo?"
> > 	depends on USB && BAR
> > 	module
> > 	  obj-$(CONFIG_FOO) += foo.o
> > 	  foo-y := file1.o file2.o
> > 	help
> > 	  foo will allow you to explode your PC
>  ...
> > Does this fit what you had in mind?
> 
> Yes it does.
> 
> Now I'll ask if you think embedding this information in one of the C
> files for a module would be even nicer?
I have no good idea for the syntax and I and not sure what is gained
by reducing a driver with one file.
Agreed - simple drivers would then be a single file - and thats a good argument.

> 
> Also, we need to make sure we can properly handle top-level
> container-like items.  For example, where would menuconfigs like
> NETDEV_10000 go if we adopt this kind of scheme?

If it makes sense to group stuff inside a menuconfig it would
also make sense to put the same modules in a subdirectory.
And then we would have the menuconfig in the Kconfig
file that would source the others.

So I do not see this as an issue for the 'embedded' syntax described above.

	Sam
