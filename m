Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:6618 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964787AbWF3OGP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 10:06:15 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Fri, 30 Jun 2006 16:05:53 +0200
References: <1151670404.11575.5.camel@localhost> <200606301509.16981.ak@suse.de> <1151674086.11575.24.camel@localhost>
In-Reply-To: <1151674086.11575.24.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301605.53258.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 30 June 2006 15:28, Martin Schwidefsky wrote:
> On Fri, 2006-06-30 at 15:09 +0200, Andi Kleen wrote:
> > > > I must say I still hate the negative !S390. It would be much better
> > > > to define something positive. If PCI doesn't work maybe something 
> > > > else.
> > > 
> > > Well, I don't like these negative !S390 depends as well. But I can't
> > > help it, there is no other existing config symbol that can be used for a
> > > positive dependency. Hardware that is built into the machine and is not
> > > attached via some kind of bus does not have any dependency. 
> > 
> > 
> > But one can be invented. 
> > 
> > DESKTOP_HARDWARE
> > SMALL_IRON
> > END_USER_PCI
> > ...
> > 
> > Chose one.
> 
> None of them seems appropriate. The things the patch deactives for s390
> are vastly different (ATA/IDE, Parallel port, Plug and Play, I2C, I2O
> and so on). You will end up adding a lot of new config options. 

ATA/IDE, parallel port, PNP could be PC_STYLE_HARDWARE. 

I2O should be definitely PCI

I2C is an oddball. 

> > What stops users from plugging a PCI sound card into your PCI slots 
> > BTW?
> 
> Which PCI slot? s390 doesn't have PCI slots.

Ah I thought it had. If not you can just make most of that stuff
dependent on PCI, no?


-Andi
