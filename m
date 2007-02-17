Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.174]:60386 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946362AbXBQBiI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 16 Feb 2007 20:38:08 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] killing the NR_IRQS arrays.
Date: Sat, 17 Feb 2007 02:37:42 +0100
References: <m1ire2e20p.fsf@ebiederm.dsl.xmission.com> <20070216195256.GE2572@flint.arm.linux.org.uk> <1171665426.5644.99.camel@localhost.localdomain>
In-Reply-To: <1171665426.5644.99.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702170237.42910.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-ID: <linux-arch.vger.kernel.org>

On Friday 16 February 2007 23:37, Benjamin Herrenschmidt wrote:
> You might want to have a look at the powerpc API with it's remaping
> capabilities. It's very nice for handling multiple domain spaces. It
> might be of some use for you.

I don't consider the powerpc virtual IRQs a solution for the problem.
While I believe you did the right thing for powerpc with generalizing
this over all its platforms, it really isn't more than a workaround
for the problem that we can't deal well with the static irq_desc
array.

When that problem is now getting worse on other architectures, we
should try to get it right on all of them, rather than spreading
the workaround further.

	Arnd <><
