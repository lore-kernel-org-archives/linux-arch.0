From: David Miller <davem@davemloft.net>
Subject: Re: Arch maintainers Ahoy!
Date: Thu, 24 May 2012 01:56:40 -0400 (EDT)
Message-ID: <20120524.015640.40302347663199346.davem@davemloft.net>
References: <CA+55aFx1HNC5rd5dzuKpNiHKWvkhoc=-y6hsAW-L_X7sz5Taog@mail.gmail.com>
	<20120523.221150.620846999543569983.davem@davemloft.net>
	<20120524052545.GB9492@drongo>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:37010 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab2EXF5s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 01:57:48 -0400
In-Reply-To: <20120524052545.GB9492@drongo>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulus@samba.org
Cc: torvalds@linux-foundation.org, James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 24 May 2012 15:25:45 +1000

> On PowerPC we have the "count leading zeroes" instructions we could
> use to find the position of the leftmost zero byte,

I know, guess whose glibc strlen asm I got these formulas from?
:-)

> so if you can conveniently make the find_zero() function
> overridable, that would be good.

I'm sure a powerpc person can cons up a patch that does that once
my stuff goes in, and test it too.
