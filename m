From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: SET_PERSONALITY and TASK_SIZE
Date: Thu, 22 Jan 2009 14:28:23 +1100
Message-ID: <1232594903.23611.96.camel@pasglop>
References: <20090118111831.GA4818@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35814 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbZAVD2s (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Jan 2009 22:28:48 -0500
In-Reply-To: <20090118111831.GA4818@osiris.boeblingen.de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Hugh Dickins <hugh@veritas.com>


> However we should use the PER_MASK if we want to check for PER_LINUX32,
> since there are more bits in the personality flags. In case any of the
> 'extra' bits is set we may incorrectly set personality to PER_LINUX even
> when we want PER_LINUX32.
> 
> Looks like more architectures should do something like:
> 
> 	if (personality(current->personality) != PER_LINUX32)

If you do gitk mm/memory.c, and look at the first 2 or 3 commits from
Hugh near the botto,, I -think- they may explain why you no longer see
the use of TASK_SIZE in there, ie, we may have fixed that in 2.6.12...

So from that point of view, it's quite possible that we no longer need
to defer the personality switch, which would allow to simplify things
quite a bit on ppc64, unless there is some -other- reason here...

Cheers,
Ben.
