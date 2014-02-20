Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:57905 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315AbaBTSea (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2014 13:34:30 -0500
Date: Thu, 20 Feb 2014 13:34:29 -0500 (EST)
Message-ID: <20140220.133429.225365208847105257.davem@davemloft.net>
Subject: Re: [PATCH 2/4] Sparc: sparc_cpu_model isn't in asm/system.h any
 more [ver #2]
From: David Miller <davem@davemloft.net>
In-Reply-To: <17732.1392912492@warthog.procyon.org.uk>
References: <20140212154559.2405.3104.stgit@warthog.procyon.org.uk>
	<17732.1392912492@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Message-ID: <20140220183429.m0sMPIxvl-NRvlhLn2D-Sajm5khp3FszJcW15Jrfqhc@z>

From: David Howells <dhowells@redhat.com>
Date: Thu, 20 Feb 2014 16:08:12 +0000

> sparc_cpu_model isn't in asm/system.h any more, so remove a comment about it.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

Applied, thanks David.
