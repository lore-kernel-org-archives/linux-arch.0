From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [arc-linux-dev] Re: UAPI for new arches (was Re: [GIT PULL] User
 API Disintegrate: Preparatory patches)
Date: Wed, 14 Nov 2012 13:01:27 +0000
Message-ID: <50A39627.6020809@imgtec.com>
References: <50A0D634.20005@synopsys.com> <C2D7FE5348E1B147BCA15975FBA230750D9832@in01wembx1.internal.synopsys.com> <509251CA.8050008@synopsys.com> <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>,<8419.1352387261@warthog.procyon.org.uk> <14356.1352416788@warthog.procyon.org.uk> <9377.1352726040@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:51627 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422711Ab2KNNBa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 14 Nov 2012 08:01:30 -0500
In-Reply-To: <9377.1352726040@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi David,

The disintegration scripts strip out the #ifdef __KERNEL__ from the
headers in both uapi/ and the old directories. However there are still a
bunch of unexported headers through the tree which have #ifdef
__KERNEL__ in them, usually guarding the entire file (just grep
__KERNEL__ in arch/).

Is this something that you're already planning to eliminate? We have a
few in the metag tree too, and now that uapi/ is nicely separated I'm
not sure if it's worth removing the __KERNEL__ guards or keeping them to
match other architectures.

Thanks
James
