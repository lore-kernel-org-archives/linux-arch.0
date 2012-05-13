From: Sam Ravnborg <sam@ravnborg.org>
Subject: Do we use runtime patching of function calls somewhere?
Date: Sun, 13 May 2012 14:16:00 +0200
Message-ID: <20120513121600.GA15708@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:46247 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab2EMMQB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 13 May 2012 08:16:01 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux arch <linux-arch@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>

Do we have any archs that does runtime patching of function calls?

On sparc32 we have infrastructure to do so but this
requires an additional step after the final link
that I like to get rid of.

Basically what is required is to locate all
call-sites that for example call:

     cache_flush_all();

and replace this with a

    srmmu_cache_flush_all();

sparc32 has ~30 calls that is eligble for runtime patching.
sparc-next has seen some nice cleanup in this area,
so your regular kernel has much more.

We know early on the what to patch with as the only
paramters involved are platform and MMU type.

I could try to come up with something myself - but if we already
have it somewhere maybe there is something to be inspired by.

	Sam
