Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:48095 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751398AbWCGRhU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2006 12:37:20 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <5041.1141417027@warthog.cambridge.redhat.com> 
References: <5041.1141417027@warthog.cambridge.redhat.com>  <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com> 
Subject: Re: Memory barriers and spin_unlock safety 
Date: Tue, 07 Mar 2006 17:36:59 +0000
Message-ID: <31420.1141753019@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, akpm@osdl.org, ak@suse.de, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells <dhowells@redhat.com> wrote:

> I suspect, then, that x86_64 should not have an SFENCE for smp_wmb(), and
> that only io_wmb() should have that.

Hmmm... We don't actually have io_wmb()... Should the following be added to
all archs?

	io_mb()
	io_rmb()
	io_wmb()

David
