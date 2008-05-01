From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Change long to unsigned long in ptrace functions to fix
 sparse warnings
Date: Thu, 1 May 2008 16:52:17 -0700
Message-ID: <20080501165217.a571d902.akpm@linux-foundation.org>
References: <18458.19939.138289.173048@cargo.ozlabs.ibm.com>
	<20080501.161608.150609265.davem@davemloft.net>
	<20080501231942.2B5C426FA07@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:56664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754076AbYEAXxg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 May 2008 19:53:36 -0400
In-Reply-To: <20080501231942.2B5C426FA07@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: davem@davemloft.net, paulus@samba.org, linux-arch@vger.kernel.org

On Thu,  1 May 2008 16:19:41 -0700 (PDT)
Roland McGrath <roland@redhat.com> wrote:

> I don't know of any problems off hand, but I would testify that there
> aren't any niggling bits there.  Paranoia would suggest comparing object
> code before/after on each arch, since it should not change.
> 

oh gee, it's a ton of code to review, isn't it?  And it's _hard_ review :(

(reviews a bit)

h8300's arch_ptrace() does

	if ((addr & 3) || addr < 0 || addr >= sizeof(struct user)) {

ok, the third comparison saved us.  Lucky...

In fact most architectures seem to have copy-n-pasted that test.  I guess
that going from signed to unsigned is safer than vice-versa.



Now what about frv?

	case PTRACE_PEEKUSR: {
		tmp = 0;
		ret = -EIO;
		if ((addr & 3) || addr < 0)
			break;

we broke that.  Maybe it doesn't matter, don't know.



So yeah, it's _probably_ OK, but I'm not sure that it would be smart to
merge it and hope.  Nor would it be a good use of time to check all that
code just to fix a sparse warning.
