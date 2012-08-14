From: David Howells <dhowells@redhat.com>
Subject: Re: [GIT PULL] Disintegrate the User API from the kernel headers
Date: Tue, 14 Aug 2012 21:54:40 +0100
Message-ID: <8709.1344977680@warthog.procyon.org.uk>
References: <502A8A50.4080308@hartkopp.net> <5725.1343931663@warthog.procyon.org.uk> <27564.1343122707@warthog.procyon.org.uk> <31633.1344950521@warthog.procyon.org.uk>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37345 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757496Ab2HNUzU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Aug 2012 16:55:20 -0400
In-Reply-To: <502A8A50.4080308@hartkopp.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: dhowells@redhat.com, torvalds@osdl.org, mkl@pengutronix.de, arnd@arndb.de, tglx@linutronix.de, mtk.manpages@gmail.com, hpa@zytor.com, alan@lxorguk.ukuu.org.uk, fengguang.wu@intel.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Oliver Hartkopp <socketcan@hartkopp.net> wrote:

> The defines are relevant for upcoming tools and drivers (for hardware that
> will become available in Q4/2012). So we're currently not breaking any
> Userspace API. After it turned out that one of the bits was misleading i
> wanted to fix the bits ASAP, so that the final 3.6 will contain the agreed
> information and final userspace API for CAN FD.

That sounds fine, then.

David
