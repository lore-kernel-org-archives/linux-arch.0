Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57552 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932598AbWCHV5L
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 16:57:11 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <24309.1141848971@warthog.cambridge.redhat.com>
References: <20060308161829.GC3669@elf.ucw.cz>
	 <31492.1141753245@warthog.cambridge.redhat.com>
	 <24309.1141848971@warthog.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 22:01:44 +0000
Message-Id: <1141855305.10606.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mer, 2006-03-08 at 20:16 +0000, David Howells wrote:
> The LOCK and UNLOCK functions presumably make at least one memory write apiece
> to manipulate the target lock (on SMP at least).

No they merely perform the bus transactions neccessary to perform an
update atomically. They are however "serializing" instructions which
means they do cause a certain amount of serialization (see the intel
architecture manual on serializing instructions for detail).

Athlon and later know how to turn it from locked memory accesses into
merely an exclusive cache line grab.

> > This makes it sound like pentium-III+ is incompatible with previous
> > CPUs. Is it really the case?
> 
> Yes - hence the alternative instruction stuff.

It is the case for certain specialist instructions and the fences are
provided to go with those but can also help in other cases. PIII and
later in particular support explicit non temporal stores.

