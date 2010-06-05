From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH 0/8] revised patch for arch/tile/ support
Date: Sat, 05 Jun 2010 09:30:40 -0400
Message-ID: <4C0A5180.9010702@tilera.com>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com>	<201005290333.o4T3Xjse029917@farm-0002.internal.tilera.com>	<201005291329.10941.arnd@arndb.de>	<201006032240.31963.arnd@arndb.de>	<4C097104.3080406@tilera.com> <20100605225605.4e44d4e4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from king.tilera.com ([72.1.168.226]:56939 "EHLO king.tilera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933319Ab0FENao (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Jun 2010 09:30:44 -0400
In-Reply-To: <20100605225605.4e44d4e4.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

On 6/5/2010 8:56 AM, Stephen Rothwell wrote:
> On Fri, 04 Jun 2010 17:32:52 -0400 Chris Metcalf <cmetcalf@tilera.com> wrote:
>   
>> I've set up a GIT tree for the Tilera architecture support here:
>> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git
>>
>> [...]
>>     
> That sounds pretty good.  I have added the master branch from that tree
> and it will appear in linux-next from Monday.
>   

Thanks, Stephen.  One question: has linux-next reached the point where
Linus pulls from it automatically during each merge window, or should I
still ask Linus explicitly to pull for the 2.6.36 merge window?

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
