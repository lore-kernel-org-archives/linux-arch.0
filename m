From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tile: support GENERIC_KERNEL_THREAD and
 GENERIC_KERNEL_EXECVE
Date: Tue, 23 Oct 2012 23:25:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210232307480.2756@ionos>
References: <20121016223508.GR2616@ZenIV.linux.org.uk> <201210192041.q9JKf7jD003998@farm-0010.internal.tilera.com> <20121019213548.GR2616@ZenIV.linux.org.uk> <5082A1F1.3080303@tilera.com> <20121020153401.GT2616@ZenIV.linux.org.uk> <20121020171643.GU2616@ZenIV.linux.org.uk>
 <5086D432.4070008@tilera.com> <20121023184122.GZ2616@ZenIV.linux.org.uk> <alpine.LFD.2.02.1210232232070.2756@ionos> <20121023205119.GA27729@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:47215 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756855Ab2JWVZO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2012 17:25:14 -0400
In-Reply-To: <20121023205119.GA27729@sigill.intra.peff.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff King <peff@peff.net>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Chris Metcalf <cmetcalf@tilera.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>

On Tue, 23 Oct 2012, Jeff King wrote:

> On Tue, Oct 23, 2012 at 10:47:28PM +0200, Thomas Gleixner wrote:
> 
> > I agree that this is a common issue. Acked-by/Reviewed-by mails come
> > in after the fact that the patch has been committed to an immutable
> > (i.e no-rebase mode) branch or if the change in question already hit
> > Linus tree.
> > 
> > Still it would be nice to have a recording of that in the git tree
> > itself.
> > 
> > Something like: "git --attach SHA1 <comment>" would be appreciated!
> 
> It is spelled:
> 
>   git notes add -m <comment> SHA1

Cool!

> The resulting notes are stored in a separate revision-controlled branch

Which branch(es) is/are that ? What are the semantics of that?

Assume I commit something to branch "foo"

Now I get that late Ack/Reviewed-by and want to associate that to that
commit in branch "foo". Does that go into "notes/foo" ?

If yes, good. (Any other sensible prefix is good as well). If no,
where does it go to?

Later when I send a pull request to my upstream maintainer for branch
"foo" does he get "notes/foo" automagically or do I have to request to
pull him that separately?

Either way is fine for me, though something which lets me "automate"
that would be appreciated. I can work around that easily as my pull
requests are generated via scripts, so I can add the secondary one for
the dependent "notes" branch if necessary. Though it would be nice to
avoid that. Avoiding that, i.e having a straight connection (maybe
configurable) between "foo" and "notes/foo" and the commits which have
not yet hit my upstream maintainer would make my life easier. I.e. I
just have to check "foo" for stuff which is not upstream yet instead
of checking both, but that might just be my laziness.

Thoughts?

	tglx
