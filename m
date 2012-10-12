From: Paul Mackerras <paulus@samba.org>
Subject: Re: [git pull] signal.git, pile 2 (was Re: [RFC][CFT][CFReview]
 execve and kernel_thread unification work)
Date: Fri, 12 Oct 2012 16:32:48 +1100
Message-ID: <20121012053248.GA24293@drongo>
References: <20121001213809.GA31155@ZenIV.linux.org.uk>
 <20121011090023.GA28427@bloggs.ozlabs.ibm.com>
 <20121011125306.GF2616@ZenIV.linux.org.uk>
 <20121012001633.GA29883@bloggs.ozlabs.ibm.com>
 <20121012010958.GG2616@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51339 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335Ab2JLFcz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Oct 2012 01:32:55 -0400
Content-Disposition: inline
In-Reply-To: <20121012010958.GG2616@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Fri, Oct 12, 2012 at 02:09:58AM +0100, Al Viro wrote:
> 
> How granular are you planning to make that?  I mean, we are talking about
> 3 objects here - init/main.o, kernel/kthread.o and kernel/kmod.o.  Do they
> get TOC separate from that of arch/powerpc/kernel/entry_64.o?

Potentially, yes, it would be up to the linker.

> Anyway, if ppc folks can live with that stuff in its current form for now,

Yes, we can.

Paul.
