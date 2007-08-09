Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:57266 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932890AbXHIRKU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2007 13:10:20 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/24] make atomic_read() behave consistently across all architectures
Date: Thu, 9 Aug 2007 17:30:16 +0200
References: <20070809131423.GA9927@shell.boston.redhat.com> <200708091441.28511.arnd@arndb.de> <46BB24CB.1040405@redhat.com>
In-Reply-To: <46BB24CB.1040405@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200708091730.19024.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

On Thursday 09 August 2007, Chris Snook wrote:
> a) chicken and egg: asm-generic/atomic.h depends on definitions in asm/atomic.h

Ok, I see.
 
> If you can find a way to reshuffle the code and make it simpler, I personally am 
> all for it. I'm skeptical that you'll get much to show for the effort. 

I guess it could  be done using more macros or new headers, but I don't see
a way that would actually improve the situation.

> b) The definitions aren't precisely identical between all architectures, so it 
> would be a mess of special cases, which gets us right back to where we are now.

Why are they not identical? Anything beyond the 32/64 bit difference should
be the same afaics, or it might cause more bugs.

	Arnd <><
