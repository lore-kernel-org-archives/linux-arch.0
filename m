Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:7108 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261955AbUB2Acq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 19:32:46 -0500
Date: Sat, 28 Feb 2004 16:29:43 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: remove irq_enter()/irq_exit() from hardirq.h
Message-Id: <20040228162943.5ce74e15.davem@redhat.com>
In-Reply-To: <200402272239.i1RMdU7E015674@napali.hpl.hp.com>
References: <200402272239.i1RMdU7E015674@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 27 Feb 2004 14:39:30 -0800
David Mosberger <davidm@napali.hpl.hp.com> wrote:

> but I'm wondering whether
> leaving irq_enter()/irq_exit() in hardirq.h might invite someone to
> use it outside of architecture-specific code (which is not the case at
> the moment, as far as I can see).

I agree with you, it shouldn't be publicly visible.  The s390 guys will
need to do some work as their drivers reference these two routines (ie.
grep under drivers/s390/)
