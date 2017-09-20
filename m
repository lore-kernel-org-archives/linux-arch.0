From: Andy Lutomirski <luto@kernel.org>
Subject: Re: Rough notes from sys_membarrier() lightning BoF
Date: Wed, 20 Sep 2017 11:18:47 -0700
Message-ID: <CALCETrVVxMm25SzYmtRaE4WpRyNeyCwUyw7SHVEYaybDrDpPKg@mail.gmail.com>
References: <20170917223608.GA14577@linux.vnet.ibm.com> <CALCETrUta2LvC=e7DNDDo_F5_OuEtehFoZJg1MUwUigTT5K7xw@mail.gmail.com>
 <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751307AbdITSTJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Sep 2017 14:19:09 -0400
Received: from mail-io0-f170.google.com (mail-io0-f170.google.com [209.85.223.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 605A021EAC
        for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2017 18:19:08 +0000 (UTC)
Received: by mail-io0-f170.google.com with SMTP id g32so5566514ioj.2
        for <linux-arch@vger.kernel.org>; Wed, 20 Sep 2017 11:19:08 -0700 (PDT)
In-Reply-To: <1264439870.15044.1505931230400.JavaMail.zimbra@efficios.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, Alan Stern <stern@rowland.harvard.edu>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Dave Watson <davejwatson@fb.com>, maged michael <maged.michael@gmail.com>

On Wed, Sep 20, 2017 at 11:13 AM, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Sep 20, 2017, at 12:02 PM, Andy Lutomirski luto@kernel.org wrote:
>
> > On Sun, Sep 17, 2017 at 3:36 PM, Paul E. McKenney
> > <paulmck@linux.vnet.ibm.com> wrote:
> >> Hello!
> >>
> >> Rough notes from our discussion last Thursday.  Please reply to the
> >> group with any needed elaborations or corrections.
> >>
> >> Adding Andy and Michael on CC since this most closely affects their
> >> architectures.  Also adding Dave Watson and Maged Michael because
> >> the preferred approach requires that processes wanting to use the
> >> lightweight sys_membarrier() do a registration step.
> >
> > Not to be too much of a curmudgeon, but I think that there should be a
> > real implementation of the isync membarrier before this get merged.
> > This series purports to solve two problems, ppc barriers and x86
> > exit-without-isync, but it's very hard to evaluate whether it actually
> > solves the latter problem given the complete lack of x86 or isync code
> > in the current RFC.
> >
> > It still seems to me that you won't get any particular advantage for
> > using this registration mechanism on x86 even when you implement
> > isync.  Unless I've misunderstood, the only real issue on x86 is that
> > you need a helper like arch_force_isync_before_usermode(), and that
> > helper doesn't presently exist.  That means that this whole patchset
> > is standing on very dangerous ground: you'll end up with an efficient
> > implementation that works just fine without even requesting
> > registration on every architecture except ppc.  That way lies
> > userspace bugs.
>
> My proposed RFC for private expedited membarrier enforces that all
> architectures perform the registration step. Using the "PRIVATE_EXPEDITED"
> command without prior process registration returns an error on all
> architectures. The goal here is to make all architectures behave in the
> same way, and it allows us to rely on process registration to deal
> with future arch-specific optimizations.

Fair enough.

That being said, on same architectures (which may well be all but
PPC), it might be nice if the registration call literally just sets a
flag in the mm saying that it happened so that the registration
enforcement can be done.

>
>
> Adding the "core_sync" behavior could then be done for the next kernel
> merge window. I'm currently foreseeing two possible ABI approaches to
> expose it:
>
> Approach 1:
>
> Add MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE and
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE commands. This
> allows us to return their availability through MEMBARRIER_CMD_QUERY.
>
> Approach 2:
>
> Add a "MEMBARRIER_FLAG_SYNC_CORE" as flag parameter. It could be set
> when issuing both MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED and
> MEMBARRIER_CMD_PRIVATE_EXPEDITED, thus ensuring core serializing
> behavior. Querying whether core serialization is supported could
> be done by issuing the MEMBARRIER_CMD_QUERY command with the
> MEMBARRIER_FLAG_SYNC_CORE flag set.
>
> Any other ideas ? Any approach seems better ?


It doesn't seem to make much difference to me.
