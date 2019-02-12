Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:41053 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbfBLECe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 23:02:34 -0500
Message-ID: <d2ac1cab3b3bd7de05b6a29feda5d74a591c0081.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] docs/memory-barriers.txt: Rewrite "KERNEL I/O
 BARRIER EFFECTS" section
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 12 Feb 2019 15:01:13 +1100
In-Reply-To: <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
References: <20190211172948.3322-1-will.deacon@arm.com>
         <CAHk-=wiP42aqBApAUJbLAB43u5ips9ArgLxXn5L1r74bowxdow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>
Message-ID: <20190212040113.SJotzSZHIFEDmR74I0Beh4X67265P8dJVB-NApQsVNk@z>

On Mon, 2019-02-11 at 14:34 -0800, Linus Torvalds wrote:
> On Mon, Feb 11, 2019 at 9:30 AM Will Deacon <will.deacon@arm.com> wrote:
> > +
> > +     1. All readX() and writeX() accesses to the same peripheral are ordered
> > +        with respect to each other. For example, this ensures that MMIO register
> > +       writes by the CPU to a particular device will arrive in program order.
> 
> Hmm. I'd like more people look at strengthening this one wrt across
> CPUs and locking.
> 
> Right now we document mmiowb(), but that "documentation" is really
> just a fairy tale. Very *very* few drivers actually do mmiowb() on
> their own.
> 
> IOW, we should seriously just consider making the rule be that locking
> will order mmio too. Because that's practically the rule anyway.
> 
> Powerpc already does it. IO within a locked region will serialize with the lock.

Yup. It's a bit ugly but I felt back then that getting drivers to use
mmiowb() properly was going to be a losing battle.

Cheers,
Ben.
