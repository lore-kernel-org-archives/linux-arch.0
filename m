From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 20/25] sparc: Use Kbuild infrastructure to handle
 asm-generic headers
Date: Sat, 13 Oct 2012 17:54:00 -0400 (EDT)
Message-ID: <20121013.175400.1525893639346240797.davem@davemloft.net>
References: <20121013022955.307620438@goodmis.org>
	<20121012.231941.1930318153077157651.davem@davemloft.net>
	<1350136440.24256.95.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:59887 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2JMVyB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 13 Oct 2012 17:54:01 -0400
In-Reply-To: <1350136440.24256.95.camel@gandalf.local.home>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Sat, 13 Oct 2012 09:54:00 -0400

> On Fri, 2012-10-12 at 23:19 -0400, David Miller wrote:
>> From: Steven Rostedt <rostedt@goodmis.org>
>> Date: Fri, 12 Oct 2012 22:26:52 -0400
>> 
>> > From: Steven Rostedt <srostedt@redhat.com>
>> > 
>> > Use Kbuild infrastructure to handle the asm-generic headers
>> > and remove the wrapper headers that call them.
>> > 
>> > This only affects headers that do nothing but include the generic
>> > equivalent. It does not touch any header that does a little more.
>> > 
>> > Cc: linux-kbuild@vger.kernel.org
>> > Cc: sparclinux@vger.kernel.org
>> > Cc: "David S. Miller" <davem@davemloft.net>
>> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
>> 
>> Acked-by: David S. Miller <davem@davemloft.net>
> 
> David,
> 
> Would you like to take this patch? It's not dependent on any of the
> other patches. Otherwise I'll probably ask Andrew to pull it into his
> tree. Or I can just set up a branch and have it go into linux-next for
> the next merge window.

I really would like to take less rather than take more.

This whole UAPI, Kbuild, etc. stuff is just bogging subsystem
maintainers down.  This kind of stuff should just go via the person
who does all the work and knows how it all ties together and knows
what dependencies, if any, exist in the series.

So please merge this yourself, thanks.
