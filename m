From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 14:07:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908161406060.3162@localhost.localdomain>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com> <20090816180631.GA23448@elte.hu> <alpine.LFD.2.01.0908161123250.3162@localhost.localdomain>
 <20090816202431.GA27764@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43363 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755994AbZHPVIg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 17:08:36 -0400
In-Reply-To: <20090816202431.GA27764@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>



On Sun, 16 Aug 2009, Ingo Molnar wrote:
> 
> We do that already for that reason:

Ahh, we do. I was mislead by the fact that we still generate the 
out-of-line ones, even though we don't use them. Which is fine, of course.

It doesn't do the irqrestore versions, but that's probably not a big deal.

			Linus
