Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:1470 "EHLO
	hiauly1.hia.nrc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760717Ab0J1SLk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 28 Oct 2010 14:11:40 -0400
Subject: Re: [PATCH] parisc: fix compile failure with kmap_atomic changes
Date: Thu, 28 Oct 2010 14:11:38 -0400 (EDT)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
In-Reply-To: <1288287580.3043.159.camel@mulgrave.site> from "James Bottomley" at Oct 28, 2010 12:39:40 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-ID: <20101028181139.558BE4D30@hiauly1.hia.nrc.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, peterz@infradead.org
Message-ID: <20101028181138.w4Dn5IH6P2NuVEnkuEyByPHl0GHjZAZ4D6BNDu3YG-M@z>

> The specific problem is that kmap_atomic no longer takes the index
> argument because Peter moved it to a stack based implementation.  All
> our kmap_atomic primitives in asm/cacheflush.h still have the extra
> index argument which causes a compile failure.

Sorry, missed that.  The issue I was trying to address was the lack of
calls to pagefault_disable() and pagefault_enable().

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
