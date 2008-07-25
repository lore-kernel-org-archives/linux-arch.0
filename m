From: Jack Steiner <steiner@sgi.com>
Subject: Re: MMU notifiers review and some proposals
Date: Fri, 25 Jul 2008 18:29:09 -0500
Message-ID: <20080725232907.GA243187@sgi.com>
References: <20080724143949.GB12897@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:56363 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752610AbYGYX3L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jul 2008 19:29:11 -0400
Content-Disposition: inline
In-Reply-To: <20080724143949.GB12897@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Memory Management List <linux-mm@kvack.org>, linux-arch@vger.kernel.org, andrea@qumranet.com, cl@linux-foundation.org

> 
> I also think we should be cautious to make this slowpath so horribly
> slow. For KVM it's fine, but perhaps for GRU we'd actually want to
> register quite a lot of notifiers, unregister them, and perhaps even
> do per-vma registrations if we don't want to slow down other memory
> management operations too much (eg. if it is otherwise just some
> regular processes just doing accelerated things with GRU).

I can't speak for other possible users of the mmu notifier mechanism
but the GRU will only register a single notifier for a process.
The notifier is registered when the GRU is opened and (currently)
unregistered when the GRU is closed.

If a task opens multiple GRUs (quite possible for threaded apps), all
shared the same notifier. Regardless of the number of threads/opens,
there will be a single notifier. 


At least one version of mmu notifiers did not support unregistration.
The notifier was left in the chain until the task exited. This
also worked for the GRU. If the gru was subsequently reopened
the notifier was reused. Providing the ability to unregister is the
right thing to do if the cost is not excessive. From a practical
standpoint, for the GRU usage, unregistration is not a big issue
either way.

--- jack
