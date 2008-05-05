From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/2] OF: Fix coding style violation in of_device.c and
 of_platform.c
Date: Sun, 04 May 2008 17:06:11 -0700 (PDT)
Message-ID: <20080504.170611.112259062.davem@davemloft.net>
References: <1209824532-7939-1-git-send-email-monstr@seznam.cz>
	<765c6c8053679c45eb370255a110f7bc680a8f25.1209824033.git.monstr@monstr.eu>
	<20080505095649.fccb57bf.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50974
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752537AbYEEAGL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 May 2008 20:06:11 -0400
In-Reply-To: <20080505095649.fccb57bf.sfr@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: sfr@canb.auug.org.au
Cc: monstr@seznam.cz, paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, monstr@monstr.eu

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 5 May 2008 09:56:49 +1000

> Any changes to the drivers of files should be cc'd to me (who did the
> initial splitup) and Dave Miller since you may impact the sparc code
> (which is the other user).

I tried to stitch these patches together and apply them to Linus's
tree for some sparc test builds the other day, but failed.

I can't figure out what this mess is against. :-/
