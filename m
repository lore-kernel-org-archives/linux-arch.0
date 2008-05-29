Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56074 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbYE2HKn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 03:10:43 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 09:10:06 +0200
References: <1211852026.3286.36.camel@pasglop> <alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org> <1211926779.3286.104.camel@pasglop>
In-Reply-To: <1211926779.3286.104.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200805290910.07207.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, tpiepho@freescale.com
Message-ID: <20080529071006.DF2CEgOzNlNGXOyL6Xa4eMtg6S8IM60zqgfIaYFRO04@z>

On Wednesday 28 May 2008, Benjamin Herrenschmidt wrote:
> On Tue, 2008-05-27 at 14:55 -0700, Linus Torvalds wrote:
> > 
> > On Wed, 28 May 2008, Benjamin Herrenschmidt wrote:
> > > 
> > > A problem with __raw_ though is that they -also- don't do byteswap,
> > 
> > Well, that's why there is __readl() and __raw_readl(), no?
> 
> As I replied to somebody else, __readl() is news to me :-) we dont' have
> those on powerpc.
> 

It's not exactly a well-established interface. Only five architectures
define these functions, and there is not a single user in the kernel
source outside of these architecture's io.h files.

	Arnd <><
