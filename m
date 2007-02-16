Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55904 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945943AbXBPPux (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Feb 2007 10:50:53 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [RFC] killing the NR_IRQS arrays.
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com>
	<20070216124117.GB4218@elte.hu>
Date: Fri, 16 Feb 2007 08:49:43 -0700
In-Reply-To: <20070216124117.GB4218@elte.hu> (Ingo Molnar's message of "Fri,
	16 Feb 2007 13:41:17 +0100")
Message-ID: <m13b56drvs.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

Ingo Molnar <mingo@elte.hu> writes:
>
> or am i missing something fundamental?

One piece.

At the driver level this not a big scary change.  
This is just a change with widespread effect.

It should be no worse than enabling a very revealing new compiler
warning.

Every fix should be purely mechanical.  There should be no need at
all to think to get it right (unless things are broken today and we
just don't see it.).

Yes typo's and the like will happen.  There will be issues.  But 99%
of them will be the code doesn't compile, for an obvious reason.  

Eric
