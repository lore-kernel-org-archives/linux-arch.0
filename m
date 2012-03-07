From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 08/29] Disintegrate asm/system.h for C6X
Date: Wed, 07 Mar 2012 21:36:31 +0000
Message-ID: <18700.1331156191@redhat.com>
References: <1331155726.12805.16.camel@deneb.redhat.com> <20120307194548.15987.36073.stgit@warthog.procyon.org.uk> <20120307194725.15987.99209.stgit@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:11716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932369Ab2CGVgo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Mar 2012 16:36:44 -0500
In-Reply-To: <1331155726.12805.16.camel@deneb.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: dhowells@redhat.com, paul.gortmaker@windriver.com, hpa@zytor.com, torvalds@linux-foundation.org, sfr@canb.auug.org.au, mingo@redhat.com, arnd@arndb.de, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Mark Salter <msalter@redhat.com> wrote:

> > Disintegrate asm/system.h for C6X.  Not compiled.  Appears to be missing
> > asm/atomic.h and asm/bug.h.
> 
> Not missing. C6X uses the asm-generic versions which makes me think that
> at least the atomic.h and barrier.h bits could have reasonable generic
> versions for UP-only systems.

How does this work?  Looking at linux/atomic.h, it should fail to build as
pretty much the first thing it does is include asm/atomic.h - which doesn't
exist for C6X.  Shouldn't it at least have a #inclusion to the asm-generic
header?

David
