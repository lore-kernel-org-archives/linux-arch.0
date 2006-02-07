Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fmr21.intel.com ([143.183.121.13]:56221 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S964831AbWBGSVl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Feb 2006 13:21:41 -0500
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [patch 1/1] Fix spinlock debugging delays to not time out too early
Date: Tue, 7 Feb 2006 10:20:43 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F05A3DB05@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org, linux-arch@vger.kernel.org
Cc: mingo@elte.hu, ak@muc.de
List-ID: <linux-arch.vger.kernel.org>

> The fix is to include a __delay(1) call in the loop, to correctly approximate
> the intended delay timeout of 1 second.  The code assumes that every
> architecture implements __delay(1) to last around 1/(loops_per_jiffy*HZ)
> seconds.

But we calculate loops_per_jiffy based on somewhat larger vales passed
to __delay() ... where the function call overhead is amortized away.

I'd expect that __delay(1) would last quite a bit longer than
1/(loops_per_jiffy * HZ) ... so we'll wait a lot more than a
second.

-Tony
