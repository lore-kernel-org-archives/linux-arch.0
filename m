Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:12764 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751000AbWF3OUf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 10:20:35 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Date: Fri, 30 Jun 2006 16:20:15 +0200
References: <1151670404.11575.5.camel@localhost> <200606301509.16981.ak@suse.de> <20060630141351.GA27102@athena.road.mcmartin.ca>
In-Reply-To: <20060630141351.GA27102@athena.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606301620.15505.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Friday 30 June 2006 16:13, Kyle McMartin wrote:
> On Fri, Jun 30, 2006 at 03:09:16PM +0200, Andi Kleen wrote:
> > But one can be invented. 
> > 
> 
> I'd also like to propose a BROKEN_ON_BIG_ENDIAN or alternatively just a
> config LITTLE_ENDIAN, while we're at it. A whole pile of poorly
> written drivers in isdn/ and, iirc, net/ fail to build (#error?) on
> big endian machines...

Fine by me. Just submit patches.


-Andi

