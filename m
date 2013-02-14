Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:39341 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757387Ab3BNKXd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Feb 2013 05:23:33 -0500
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 14 Feb 2013 10:21:36 -0000
Date: Thu, 14 Feb 2013 11:23:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC][CFT] what's in signal.git queue
Message-ID: <20130214112306.30ab728c@mschwide>
In-Reply-To: <20130214012539.GQ4503@ZenIV.linux.org.uk>
References: <20130214012539.GQ4503@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Jesper Nilsson <jesper.nilsson@axis.com>, David Howells <dhowells@redhat.com>, Tony Luck <tony.luck@intel.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, Jonas Bonn <jonas@southpole.se>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Richard Kuo <rkuo@codeaurora.org>, Lennox Wu <lennox.wu@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, Chris Zankel <chris@zankel.net>, Chris Metcalf <cmetcalf@tilera.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Russell King <linux@arm.linux.org.uk>
Message-ID: <20130214102306.kEG7xQHlZrqrgKEpR3QHpckAvd6buf5miwe2YyV9-DU@z>

On Thu, 14 Feb 2013 01:25:39 +0000
Al Viro <viro@ZenIV.linux.org.uk> wrote:

> At that point the common stem ends; as far as I'm concerned, this part is
> in never-rebase mode by now.  Then comes a bunch of per-architecture branches;
> all subject to ACK by maintainers (ones who are not MIA, that is ;-/).  Once
> maintainer(s) are OK with a branch, it's in no-rebase mode as well.  Branch
> names are of form arch-<arch name>, same as the last time around.

Just tested the signal.git master branch (didn't see any additional commit on
the arch-s390 branch). Works for me and the test suite of gdb does not come up
with any new unexpected failures. So for the s390 parts:

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

