Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:26276 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262810AbUCWUSQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 15:18:16 -0500
Date: Tue, 23 Mar 2004 12:18:11 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: signal-race-fix.patch
Message-Id: <20040323121811.488511bb.davem@redhat.com>
In-Reply-To: <200403231935.i2NJZ99O005609@magilla.sf.frob.com>
References: <20040323022020.3972af1d.akpm@osdl.org>
	<200403231935.i2NJZ99O005609@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>
Cc: akpm@osdl.org, minyard@acm.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 23 Mar 2004 11:35:09 -0800
Roland McGrath <roland@redhat.com> wrote:

> There is nothing wrong with this patch.  But while we are at it (and every
> arch will be required to update anyway), I would favor moving the sa_mask
> processing into common code in get_signal_to_deliver right next to where
> Corey has moved the SA_ONESHOT handling.

I agree, but we can do that with a follow on patch.  I think it's
more important to get this fix into Linus's tree soon than to combine
the two changes into one.

We've already spent enough time on what should have been a quick and
easy fix :-)
