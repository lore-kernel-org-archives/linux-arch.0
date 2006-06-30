Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:28895 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S932115AbWF3OOA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 30 Jun 2006 10:14:00 -0400
Date: Fri, 30 Jun 2006 10:13:51 -0400
From: Kyle McMartin <kyle@parisc-linux.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Message-ID: <20060630141351.GA27102@athena.road.mcmartin.ca>
References: <1151670404.11575.5.camel@localhost> <200606301444.26446.ak@suse.de> <1151672682.11575.16.camel@localhost> <200606301509.16981.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606301509.16981.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jun 30, 2006 at 03:09:16PM +0200, Andi Kleen wrote:
> But one can be invented. 
> 

I'd also like to propose a BROKEN_ON_BIG_ENDIAN or alternatively just a
config LITTLE_ENDIAN, while we're at it. A whole pile of poorly
written drivers in isdn/ and, iirc, net/ fail to build (#error?) on
big endian machines...

Cheers,
	Kyle.
