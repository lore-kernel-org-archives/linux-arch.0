Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:28293 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752044AbWCNX7q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Mar 2006 18:59:46 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <17431.14867.211423.851470@cargo.ozlabs.ibm.com> 
References: <17431.14867.211423.851470@cargo.ozlabs.ibm.com>  <m1veujy47r.fsf@ebiederm.dsl.xmission.com> <16835.1141936162@warthog.cambridge.redhat.com> <32068.1142371612@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
Date: Tue, 14 Mar 2006 23:59:28 +0000
Message-ID: <2301.1142380768@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: David Howells <dhowells@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

Paul Mackerras <paulus@samba.org> wrote:

> No, that's not the problem.  The problem is that you can get q == &b
> and d == 1, believe it or not.  That is, you can see the new value of
> the pointer but the old value of the thing pointed to.

But that doesn't make any sense!

That would mean we that we'd've read b into d before having read the new value
of p into q, and thus before having calculated the address from which to read d
(ie: &b) - so how could we know we were supposed to read d from b and not from
a without first having read p?

Unless, of course, the smp_wmb() isn't effective, and the write to b happens
after the write to p; or the Alpha's cache isn't fully coherent.

David
