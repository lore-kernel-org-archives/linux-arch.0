From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RESEND] bug: When !CONFIG_BUG, simplify WARN_ON_ONCE and family
Date: Mon, 24 Feb 2014 14:39:46 +0100
Message-ID: <16994526.0QcMcz0xo0@wuerfel>
References: <20140224084437.GG20680@thin> <1747419.6FxgzfPen0@wuerfel> <20140224131605.3bd7febc@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.13]:52328 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbaBXNp3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2014 08:45:29 -0500
In-Reply-To: <20140224131605.3bd7febc@alan.etchedpixels.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, Josh Triplett <josh@joshtriplett.org>, Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 February 2014 13:16:05 One Thousand Gnomes wrote:
> 
> While I agree defining it as do {} while(1); would be a lot smarter,
> simply making it required that a platform provides an implementation of
> BUG() would be even better. 

But how do we get there? The majority of architectures define BUG()
already, but a lot of them only if CONFIG_BUG is enabled. That is
of course trivial do change, and it is what my older patch does
for ARM and x86.

We also have seven architectures without a BUG() implementation (c6x,
m32r, meta, microblaze, score, sh, unicore32) and six more (arm64,
hexagon openrisc tile um xtensa) that have no bug.h at all.

	Arnd
