From: David Howells <dhowells@redhat.com>
Subject: Re: UAPI for new arches (was Re: [GIT PULL] User API Disintegrate: Preparatory patches)
Date: Thu, 08 Nov 2012 12:38:31 +0000
Message-ID: <1171.1352378311@warthog.procyon.org.uk>
References: <509251CA.8050008@synopsys.com> <18137.1349203013@warthog.procyon.org.uk> <CAAG0J9_gYLn5+4j9WUnPmxWyJfQK_b8e5xjxZdRPG21euXoCFg@mail.gmail.com> <CAAG0J9_LZ5Q1fNdcbSOyieesabkqcTMT0ueEDLXmemV2C_+F=g@mail.gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16516 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751118Ab2KHMix (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Nov 2012 07:38:53 -0500
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

Do you want the headers to be split in the patches that add them, or would you
be happy with one patch stacked on the end to do the whole lot?  The last is
easiest for me to do.

However, I could 'uncommit' your patches using stgit, do the headers
individually and recommit them if you'd prefer.

David
