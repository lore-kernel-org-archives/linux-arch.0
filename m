Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:31428 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263152AbUCSXtd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 18:49:33 -0500
Date: Fri, 19 Mar 2004 15:49:28 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: signal-race-fix.patch
Message-Id: <20040319154928.3b2d8820.davem@redhat.com>
In-Reply-To: <405B773B.8010705@acm.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Corey Minyard <minyard@acm.org>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 19 Mar 2004 16:42:03 -0600
Corey Minyard <minyard@acm.org> wrote:

> BTW, here is a new patch that covers that problem.

This still doesn't cut it, next the code in handle_signal() performs operations
on ka->sa.sa_mask if SA_{NOMASK,NODEFER} is not set,
then a recalc_sigpending() is made.

I think we really need to pull the locking up a level or something like that.
