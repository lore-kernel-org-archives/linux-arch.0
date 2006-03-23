Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:9089 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1422649AbWCWSeo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Mar 2006 13:34:44 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060316231723.GB1323@us.ibm.com> 
References: <20060316231723.GB1323@us.ibm.com>  <16835.1141936162@warthog.cambridge.redhat.com> <18351.1142432599@warthog.cambridge.redhat.com> 
Subject: Re: [PATCH] Document Linux's memory barriers [try #5] 
Date: Thu, 23 Mar 2006 18:34:27 +0000
Message-ID: <895.1143138867@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: paulmck@us.ibm.com, davem@redhat.com
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Paul E. McKenney <paulmck@us.ibm.com> wrote:

> smp_mb__before_atomic_dec() and friends as well?

These seem to be something Sparc64 related; or, at least, Sparc64 seems to do
something weird with them.

What are these meant to achieve anyway? They seems to just be barrier() on a
lot of systems, even SMP ones.

> Some architectures have more expansive definition of data dependency,
> including then- and else-clauses being data-dependent on the if-condition,
> but this is probably too much detail.

Linus calls that a "control dependency" and doesn't seem to think that's a
problem as it's sorted out by branch prediction.  What you said makes me
wonder about conditional instructions (such as conditional move).


Anyway, I've incorporated your comments as well as reworking the document,
which I'll shortly push upstream once again.

David
