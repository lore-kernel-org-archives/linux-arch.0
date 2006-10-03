Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44455 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964848AbWJCJyJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Oct 2006 05:54:09 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <18466.1159834225@ocs3.ocs.com.au> 
References: <18466.1159834225@ocs3.ocs.com.au> 
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
Date: Tue, 03 Oct 2006 10:54:04 +0100
Message-ID: <10074.1159869244@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Keith Owens <kaos@sgi.com>
Cc: David Howells <dhowells@redhat.com>, mingo@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Keith Owens <kaos@sgi.com> wrote:

> >	http://people.redhat.com/~dhowells/irq-global-regs.diff.bz2

I'd forgotten about that.  Try:

	http://people.redhat.com/~dhowells/34-irq-global-regs.diff

instead.  That's the uptodate one.

David
