From: Jes Sorensen <jes@sgi.com>
Subject: Re: [rfc] add io barriers, remove mmiowb
Date: 22 May 2008 04:34:51 -0400
Message-ID: <yq0fxsaivo4.fsf@jaguar.mkp.net>
References: <20080521152855.GE8897@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from jaguar.mkp.net ([192.139.46.146]:49817 "EHLO jaguar.mkp.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756541AbYEVIew (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 May 2008 04:34:52 -0400
In-Reply-To: <20080521152855.GE8897@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-arch@vger.kernel.org, jbarnes@virtuousgeek.org, Linus Torvalds <torvalds@linux-foundation.org>

>>>>> "Nick" == Nick Piggin <npiggin@suse.de> writes:

Nick> mb and wmb are now no longer guaranteed to order system memory
Nick> operations with device memory stores. mmiowb has been introduced
Nick> to provide this ordering (when combined with a mb, wmb, or
Nick> spin_unlock). Unfortunately, it appears to be rather less well
Nick> understood among both users and implementors than even the old
Nick> memory barrier scheme. It also subtly breaks existing code that
Nick> uses mb or wmb (if only on sn2). I really think it is not a good
Nick> solution.

Nick> The alternative I propose is to restore mb and wmb to their full
Nick> strength.  This does mean that sn2 has to do the equivalent of
Nick> mb+mmiowb, wmb+mmiowb respectively, but that's the price you pay
Nick> for weak memory ordering.

Nick,

Introducing this constraint would make me less than pleased I have to
admit. It's a very expensive operation to do since it requires going
out talking to the PCI bridge, doing that on every wmb() is going to
really hurt :-(

Cheers,
Jes
