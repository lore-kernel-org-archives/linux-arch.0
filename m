Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel11.hp.com ([156.153.255.246]:40937 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262966AbUCXBzR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2004 20:55:17 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.60017.732846.886711@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 17:54:57 -0800
Subject: Re: signal-race-fix.patch
In-Reply-To: <20040323022020.3972af1d.akpm@osdl.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
	<20040319141258.338c91b1.davem@redhat.com>
	<405B773B.8010705@acm.org>
	<20040319154928.3b2d8820.davem@redhat.com>
	<405B8BE5.4070602@acm.org>
	<20040323022020.3972af1d.akpm@osdl.org>
Reply-To: davidm@hpl.hp.com
To: Andrew Morton <akpm@osdl.org>
Cc: Corey Minyard <minyard@acm.org>, davem@redhat.com, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Tue, 23 Mar 2004 02:20:20 -0800, Andrew Morton <akpm@osdl.org> said:

  Andrew> Are there any remaining concerns with Corey's final patch?

This looks rather dubious to me:

 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);

Yeah, it only preseves the status quo (updating sa_handler without
holding the lock) and it's presumably only a single-word store which
is atomic, but it's not all that hard to imagine code that would break
if sa_handler were to change underneath someone holding the
sighand->siglock.

I suppose I can just acquire/release the lock in the ia64-specific
code but since other arches have the same issue, perhaps that's not
the right level for the fix.

	--david
