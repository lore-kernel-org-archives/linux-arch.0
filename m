From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: MMIO and gcc re-ordering issue
Date: Tue, 27 May 2008 09:28:30 -0600
Message-ID: <20080527092830.3535ee7b@bike.lwn.net>
References: <4833524C.3040207@freescale.com>
	<20080520.153947.84346222.davem@davemloft.net>
	<4833542E.3040608@freescale.com>
	<20080520.155326.195407196.davem@davemloft.net>
	<1211516683.8297.271.camel@pasglop>
	<Pine.LNX.4.64.0805221553400.8205@t2.domain.actdsltmp>
	<1211852026.3286.36.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vena.lwn.net ([206.168.112.25]:48222 "EHLO vena.lwn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756935AbYE0Pes (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 May 2008 11:34:48 -0400
In-Reply-To: <1211852026.3286.36.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: benh@kernel.crashing.org
Cc: Linux Arch list <linux-arch@vger.kernel.org>, David Miller <davem@davemloft.net>, scottwood@freescale.com, linuxppc-dev@ozlabs.org, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Trent Piepho <tpiepho@freescale.com>

On Tue, 27 May 2008 11:33:46 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> However, I'm using that as an excuse to bring back my pet subject,
> which is basically, should we instead just finally mandate the use of
> explicit rmb/wmb/mb's (which boils down to barrier() on x86) to
> drivers who want to order memory consistent accesses vs. MMIO ?

To me this seems like asking for a long series of weird bugs in
drivers.  Is the cost of a barrier in an MMIO operation so high that we
can't afford to just put them in?  Alan's suggestion of no-barrier
versions for people who know what they're doing (and who think there's a
reason to care) seems like a better way to go to me.

jon
