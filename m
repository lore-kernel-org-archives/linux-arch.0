From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 0/8] revised patch for arch/tile/ support
Date: Thu, 03 Jun 2010 17:48:46 -0400
Message-ID: <4C08233E.6080405@tilera.com>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com> <201005290333.o4T3Xjse029917@farm-0002.internal.tilera.com> <201005291329.10941.arnd@arndb.de> <201006032240.31963.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from king.tilera.com ([72.1.168.226]:16030 "EHLO king.tilera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753745Ab0FCVtO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Jun 2010 17:49:14 -0400
In-Reply-To: <201006032240.31963.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, Stephen Rothwell <sfr@canb.auug.org.au>

On 6/3/2010 4:40 PM, Arnd Bergmann wrote:
> You evidently didn't make it into -rc1, probably because Linus considered
> your submission to be too late, or possibly because some of the bigger
> patches got lost in an email filter.
>
> To go forward with your architecture, I suggest that you start adding it
> to the linux-next tree. Until you have a git tree, the easiest way
> to do that is to put a tarball in quilt format at a http url under
> your control, and ask Stephen to include that.
>
> Feel free to add a 'Reviewed-by: Arnd Bergmann <arnd@arndb.de>' to your
> existing patches, and do your further work as patches on top of that.
>   

I will plan to push the commits I have mailed to LKML up to a tree on
kernel.org, since I now have an account there, probably tomorrow.  I'll
send an email to Stephen with a pointer and see where it goes from there.

And Arnd, many thanks -- it's confusing to navigate the jungle of how
code actually makes it into the kernel, and a little help goes a long way!

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
