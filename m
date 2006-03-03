Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:51431 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932161AbWCCUR0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Mar 2006 15:17:26 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org> 
References: <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>  <32518.1141401780@warthog.cambridge.redhat.com> <1146.1141404346@warthog.cambridge.redhat.com> 
Subject: Re: Memory barriers and spin_unlock safety 
Date: Fri, 03 Mar 2006 20:17:07 +0000
Message-ID: <5041.1141417027@warthog.cambridge.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds <torvalds@osdl.org> wrote:

> Note that _normal_ writes never need an SFENCE, because they are ordered 
> by the core.
> 
> The reason to use SFENCE is because of _special_ writes.

I suspect, then, that x86_64 should not have an SFENCE for smp_wmb(), and that
only io_wmb() should have that.

David
