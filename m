Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:30089 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263124AbUCSWNF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 19 Mar 2004 17:13:05 -0500
Date: Fri, 19 Mar 2004 14:12:58 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: signal-race-fix.patch
Message-Id: <20040319141258.338c91b1.davem@redhat.com>
In-Reply-To: <20040319120151.380dcbc9.akpm@osdl.org>
References: <20040319120151.380dcbc9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, minyard@acm.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, 19 Mar 2004 12:01:51 -0800
Andrew Morton <akpm@osdl.org> wrote:

> We have an SMP race in the signal code.  A fix for x86 is below.  All archs
> need updating.

I think the fix may need fixing :-)

Now that we're passing a stack local k_sigaction into handle_signal()
the real sigaction is not being updated f.e. when SA_ONESHOT causes
ka->sa.sa_handler to be set to SIG_DFL.  Only the stack local copy
is going to be set like this, not the one in the signals struct which
is where it is needed.

I noticed this while coding up the sparc versions which I'll defer until
this is cleared up.
