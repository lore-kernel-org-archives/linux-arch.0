Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:1483 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751462AbWJEO1C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Oct 2006 10:27:02 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <19038.1160058251@warthog.cambridge.redhat.com> 
References: <19038.1160058251@warthog.cambridge.redhat.com>  <20655.1159932383@kao2.melbourne.sgi.com> 
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
Date: Thu, 05 Oct 2006 15:26:58 +0100
Message-ID: <19135.1160058418@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Keith Owens <kaos@sgi.com>, mingo@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:

> > That is the one that I am using, and it blows up immediately on IA64.
> > There is no automatic default to scan include/asm-generic after
> > asm-$(ARCH).
> 
> Sigh.  Forgot to tell StGIT to add the new files again.  Sorry about that.
> I'll post a new patch soon.

See:

	http://git.infradead.org/?p=users/dhowells/irq-2.6.git;a=shortlog

Or:

	git://git.infradead.org/~dhowells/irq-2.6.git

David
