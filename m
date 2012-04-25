From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/4] kbuild: Move vmlinux link out of top-level Makefile
Date: Wed, 25 Apr 2012 03:01:45 -0700
Message-ID: <m2ipgom8om.fsf@firstfloor.org>
References: <20120424194148.GA2216@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:12137 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756861Ab2DYKBq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Apr 2012 06:01:46 -0400
In-Reply-To: <20120424194148.GA2216@merkur.ravnborg.org> (Sam Ravnborg's
	message of "Tue, 24 Apr 2012 21:41:48 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Michal Marek <mmarek@suse.cz>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

Sam Ravnborg <sam@ravnborg.org> writes:
>
> What we loose by the conversion:
> - We no longer rebuild if options to ld changes.

I think that's a problem. Can that be fixed somehow?

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
