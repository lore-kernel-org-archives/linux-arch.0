Return-Path: <roland@redhat.com>
Received: from mail6.speakeasy.net ([216.254.0.206]:60897 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S262996AbUCXD6q
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 22:58:46 -0500
Date: Tue, 23 Mar 2004 19:58:38 -0800
Message-Id: <200403240358.i2O3wc1n013905@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: signal-race-fix.patch
In-Reply-To: David Mosberger's message of  Tuesday, 23 March 2004 17:54:57 -0800 <16480.60017.732846.886711@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>, davem@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Yeah, it only preseves the status quo (updating sa_handler without
> holding the lock) and it's presumably only a single-word store which
> is atomic, but it's not all that hard to imagine code that would break
> if sa_handler were to change underneath someone holding the
> sighand->siglock.

I can't really imagine the code that would make anything untoward happen in
the situation where the process is being forced to exit with SIGSEGV anyway.
