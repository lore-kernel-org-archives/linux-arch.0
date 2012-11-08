From: David Howells <dhowells@redhat.com>
Subject: Re: UAPI for new arches (was Re: [GIT PULL] User API Disintegrate: Preparatory patches)
Date: Thu, 08 Nov 2012 15:07:41 +0000
Message-ID: <8419.1352387261@warthog.procyon.org.uk>
References: <509251CA.8050008@synopsys.com> <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2KHPIF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Nov 2012 10:08:05 -0500
In-Reply-To: <509251CA.8050008@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: dhowells@redhat.com, James Hogan <james@albanarts.com>, torvalds@osdl.org, arnd@arndb.de, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> I'm planning to submit ARC Linux kernel port (from Synopsys) for review
> on lkml and arch mailing lists. I already have a a 3.7-rc3 based kernel
> (modulo the arch UAPI split). What would be the best way to get the UAPI
> split done.
> 
> Can you point me to the latest scripts and the best way to use them (so
> we have consistent automated split of headers). Otherwise if you like,
> you could take a stab at it yourself via my tree at
> 
> git://github.com/organizations/foss-for-synopsys-dwc-arc-processors/linux.git
> arc-3.7-rc3-newport

If you look at:

	http://git.infradead.org/users/dhowells/linux-headers.git/shortlog/refs/tags/disintegrate-arc-20121108

You'll find a branch with a patch that does the UAPI disintegration for you as
one piece.  I've merged your branch onto Linus's latest before doing the
disintegration.  If you'd prefer it directly on your branch, that should be
possible too.

David
