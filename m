Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57965 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934212AbcJXIr4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2016 04:47:56 -0400
Date: Mon, 24 Oct 2016 10:47:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/5] stop_machine: yield CPU during stop machine
Message-ID: <20161024084747.GE3102@twins.programming.kicks-ass.net>
References: <1477051138-1610-1-git-send-email-borntraeger@de.ibm.com>
 <1477051138-1610-3-git-send-email-borntraeger@de.ibm.com>
 <20161021120536.GC3142@twins.programming.kicks-ass.net>
 <20161022110636.410f20bd@roar.ozlabs.ibm.com>
 <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <251574ff-13ba-c0df-76c3-cb7df30894cb@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Noam Camus <noamc@ezchip.com>, virtualization@lists.linux-foundation.org, xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
Message-ID: <20161024084747.o0kPOJqHALY3BW77LAggUXbrtJKxJoOqFYmnbgORtcY@z>

On Mon, Oct 24, 2016 at 09:52:31AM +0200, Christian Borntraeger wrote:
> Peter, I will fixup the patch set (I forgot to remove the lowlatency
> in 2 places) and push it on my tree for linux-next. Lets see what happens.
> Would the tip tree be the right place if things work out ok?

I think so, you're touching a fair bit of kernel/locking/ and there's
bound to be some conflicts with work there. So carrying it in the
locking tree might be best.
