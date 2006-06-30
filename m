Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:17119 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932624AbWF3NJW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 09:09:22 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Fri, 30 Jun 2006 15:09:16 +0200
References: <1151670404.11575.5.camel@localhost> <200606301444.26446.ak@suse.de> <1151672682.11575.16.camel@localhost>
In-Reply-To: <1151672682.11575.16.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301509.16981.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 30 June 2006 15:04, Martin Schwidefsky wrote:
> On Fri, 2006-06-30 at 14:44 +0200, Andi Kleen wrote:
> > On Friday 30 June 2006 14:26, Martin Schwidefsky wrote:
> > > Hi folks,
> > > it has been a few weeks since the s390 kconfig discussion died down.
> > > I have put together a new patch that includes all of the suggestions
> > > made so far. With this patch "make allyesconfig" and "make allmodconfig"
> > > now works on s390.
> > > 
> > > Please check that it does not break anything on your favorite 
> > > architecture. It really shouldn't but you never know. I want to push
> > > this patch soon.
> > 
> > I must say I still hate the negative !S390. It would be much better
> > to define something positive. If PCI doesn't work maybe something 
> > else.
> 
> Well, I don't like these negative !S390 depends as well. But I can't
> help it, there is no other existing config symbol that can be used for a
> positive dependency. Hardware that is built into the machine and is not
> attached via some kind of bus does not have any dependency. 


But one can be invented. 

DESKTOP_HARDWARE
SMALL_IRON
END_USER_PCI
...

Chose one.

What stops users from plugging a PCI sound card into your PCI slots 
BTW?

Initially it can be set dependent on !S390 and then later migrated
into all the architectures (you can probably recruit someone on l-k
to do it if you don't want to do it yourself ...) 

-Andi
