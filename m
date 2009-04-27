Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:35727 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253AbZD0PKe (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2009 11:10:34 -0400
Date: Mon, 27 Apr 2009 17:12:41 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC 00/17] asm-generic ABI files for microblaze
Message-ID: <20090427151241.GA10558@uranus.ravnborg.org>
References: <200904271640.44445.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200904271640.44445.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, john.williams@petalogix.com, monstr@monstr.eu, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, liqin.chen@sunplusct.com, Remis Lima Baima <remis.developer@googlemail.com>
Message-ID: <20090427151241.vCw0-1yvhn3uQXRpx5YOcA5ApQ0FQrlS1c2kAU3ruEM@z>

On Mon, Apr 27, 2009 at 04:40:43PM +0200, Arnd Bergmann wrote:
> This is my attempt to do a generic system call ABI for
> all new architectures, including a port for microblaze,
> which has recently been merged into 2.6.30. The next
> architecture that is about to get merged will be score,
> so it would be good if they can move to the same ABI.
> 
> Please review the files and (in case of microblaze
> and score maintainers) test them on your architecture.

The submission is seriously broken.
- subject is missing
- reply-to-all is broken

Can you resend with this fixed, then it makes review easier.

	Sam
