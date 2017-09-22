From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Fri, 22 Sep 2017 11:33:29 +0200
Message-ID: <20170922093329.wizest62uolktwc7@hirez.programming.kicks-ass.net>
References: <20170917223608.GA14577@linux.vnet.ibm.com>
 <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
 <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
 <20170921130950.nwfbyiil34psoyua@hirez.programming.kicks-ass.net>
 <1506014619.3848.59.camel@HansenPartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:51340 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdIVJdo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Sep 2017 05:33:44 -0400
Content-Disposition: inline
In-Reply-To: <1506014619.3848.59.camel@HansenPartnership.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

On Thu, Sep 21, 2017 at 10:23:39AM -0700, James Bottomley wrote:

>  We have one system that locks up if
> multiple CPUs have outstanding coherency operations on the private bus,
> but that's only one annoying CPU (which we manage with a special lock
> inside the PA-RISC mmu code).

Hehe, yeah. I saw that code recently and had a WTF moment ;-)
