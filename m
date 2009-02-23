From: Helge Deller <deller@gmx.de>
Subject: Re: flock, FAGAIN, and FWOULDBLOCK
Date: Mon, 23 Feb 2009 18:49:24 +0100
Message-ID: <49A2E1A4.8010607@gmx.de>
References: <200902222252.45051.sf@sfritsch.de> <20090222224924.GA13157@bombadil.infradead.org> <20090223014224.GB13157@bombadil.infradead.org> <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com> <20090223030315.GC16891@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:51278 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752119AbZBWRtc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Feb 2009 12:49:32 -0500
In-Reply-To: <20090223030315.GC16891@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Carlos O'Donell <carlos@systemhalted.org>, Kyle McMartin <kyle@infradead.org>, linux-arch@vger.kernel.org, Stefan Fritsch <sf@sfritsch.de>, debian-hppa@lists.debian.org

Matthew Wilcox wrote:
> On Sun, Feb 22, 2009 at 09:43:36PM -0500, Carlos O'Donell wrote:
>>> ...
>>> but somehow I suspect this interchangeable use of EAGAIN and EWOULDBLOCK
>>> is going to reveal latent problems in this part of the kernel I would
>>> rather not delve into...
>> The ABI is fixed, so all we can do is cleanup the uses in the kernel,
>> and make sure we adhere to the documented APIs.
> 
> We actually can do better than this ...
> 
> #ifdef __KERNEL__
> #define EWOULDBLOCK	EAGAIN
> #else
> #define EWOULDBLOCK	/* whatever the fuck HPUX uses */
> #endif

Wouldn't this hurt us if we at some point in time want to finish 
the HPUX/Linux compat code in the parisc kernel?

Helge

> Now our kernel never returns -EWOULDBLOCK, only -EAGAIN.  Correct
> applications must check for both.  Incorrect applications tend to only
> check for AGAIN, not WOULDBLOCK.  Problem solved.
