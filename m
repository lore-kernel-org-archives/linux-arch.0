From: David Howells <dhowells@redhat.com>
Subject: Re: [arc-linux-dev] Re: UAPI for new arches (was Re: [GIT PULL] User API Disintegrate: Preparatory patches)
Date: Wed, 14 Nov 2012 16:28:57 +0000
Message-ID: <17758.1352910537@warthog.procyon.org.uk>
References: <50A39627.6020809@imgtec.com> <50A0D634.20005@synopsys.com> <C2D7FE5348E1B147BCA15975FBA230750D9832@in01wembx1.internal.synopsys.com> <509251CA.8050008@synopsys.com> <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>,<8419.1352387261@warthog.procyon.org.uk> <14356.1352416788@warthog.procyon.org.uk> <9377.1352726040@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964820Ab2KNQ3H (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2012 11:29:07 -0500
In-Reply-To: <50A39627.6020809@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: dhowells@redhat.com, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

James Hogan <james.hogan@imgtec.com> wrote:

> The disintegration scripts strip out the #ifdef __KERNEL__ from the
> headers in both uapi/ and the old directories. However there are still a
> bunch of unexported headers through the tree which have #ifdef
> __KERNEL__ in them, usually guarding the entire file (just grep
> __KERNEL__ in arch/).
> 
> Is this something that you're already planning to eliminate? We have a
> few in the metag tree too, and now that uapi/ is nicely separated I'm
> not sure if it's worth removing the __KERNEL__ guards or keeping them to
> match other architectures.

I would like to remove the __KERNEL__ guards from KAPI files - they should not
be necessary there.

In the UAPI files, it will, unfortunately, be necessary to keep some of the
__KERNEL__ guards that remain.

David
