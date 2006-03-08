Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:10122 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932607AbWCHWK6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2006 17:10:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17423.21837.304330.623519@cargo.ozlabs.ibm.com>
Date: Thu, 9 Mar 2006 09:06:05 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Document Linux's memory barriers
In-Reply-To: <200603080925.19425.duncan.sands@math.u-psud.fr>
References: <1141756825.31814.75.camel@localhost.localdomain>
	<31492.1141753245@warthog.cambridge.redhat.com>
	<9551.1141762147@warthog.cambridge.redhat.com>
	<200603080925.19425.duncan.sands@math.u-psud.fr>
Sender: linux-arch-owner@vger.kernel.org
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org, mingo@redhat.com, linuxppc64-dev@ozlabs.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

Duncan Sands writes:

> On UP you at least need compiler barriers, right?  You're in trouble if you think
> you are writing in a certain order, and expect to see the same order from an
> interrupt handler, but the compiler decided to rearrange the order of the writes...

I'd be interested to know what the C standard says about whether the
compiler can reorder writes that may be visible to a signal handler.
An interrupt handler in the kernel is logically equivalent to a signal
handler in normal C code.

Surely there are some C language lawyers on one of the lists that this
thread is going to?

Paul.
