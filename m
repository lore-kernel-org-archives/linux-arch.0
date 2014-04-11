From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 03/15] arm: add renameat2 syscall
Date: Fri, 11 Apr 2014 13:39:17 -0400 (EDT)
Message-ID: <20140411.133917.994491919904460059.davem@davemloft.net>
References: <1397211951-20549-4-git-send-email-miklos@szeredi.hu>
	<20140411103507.GK16119@n2100.arm.linux.org.uk>
	<CAJfpegsbS8M4L7jKUfgw88wWnt7NYtSe5LHTsVF_oTL94xm=Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:57107 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaDKRjT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Apr 2014 13:39:19 -0400
In-Reply-To: <CAJfpegsbS8M4L7jKUfgw88wWnt7NYtSe5LHTsVF_oTL94xm=Fw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: miklos@szeredi.hu
Cc: linux@arm.linux.org.uk, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mszeredi@suse.cz

From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 11 Apr 2014 13:48:05 +0200

> It would probably have been a good idea to CC all maintainers on the
> cover letter, but I don't know how I could do that with "git
> send-email".

I strongly suggest that this _not_ be done.

There is a 1024 character limit imposed for email header fields in order
to reduce spam at vger.kernel.org

We have lists like linux-arch for a reason, CC:'ing tons of people who
should absolutely be on that list doesn't make any sense at all and
as I just described is not going to work.
