Return-Path: <roland@redhat.com>
Received: from mail2.speakeasy.net ([216.254.0.202]:4807 "EHLO
	mail2.speakeasy.net") by vger.kernel.org with ESMTP id S263188AbUCTAqY
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 19:46:24 -0500
Date: Fri, 19 Mar 2004 16:46:17 -0800
Message-Id: <200403200046.i2K0kH34022796@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: signal-race-fix.patch
In-Reply-To: David S. Miller's message of  Friday, 19 March 2004 15:49:28 -0800 <20040319154928.3b2d8820.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Corey Minyard <minyard@acm.org>, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> This still doesn't cut it, next the code in handle_signal() performs
> operations on ka->sa.sa_mask if SA_{NOMASK,NODEFER} is not set, then a
> recalc_sigpending() is made.

That just reads the sa_mask copy and that's all it needs to do.
That said, it would be cleaner if the sa_mask code were in a shared
function rather than being duplicated in every arch's handle_signal.

> I think we really need to pull the locking up a level or something like that.

As get_signal_to_deliver always takes the siglock on the way in, it
obviously wouldn't hurt any to instead have the lock taken by the caller.
But we do not want to hold that lock through the whole existing
handle_signal path, with page faults on the user stack and all.  So I'd say
the caller of get_signal_to_deliver ought to be doing the sigaction
diddling and releasing the lock before calling setup_{rt_,}frame.  If
that's what they should do, then might as well have common code do that,
e.g. by having get_signal_to_deliver handle sa_mask and SA_ONESHOT before
returning.  
