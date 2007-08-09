Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:32842 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763189AbXHIQlS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Aug 2007 12:41:18 -0400
Date: Fri, 10 Aug 2007 01:40:13 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 17/24] make atomic_read() behave consistently on sh64
Message-ID: <20070809164013.GA28113@linux-sh.org>
References: <20070809141034.GA18253@shell.boston.redhat.com> <20070809140908.GA18208@shell.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070809141034.GA18253@shell.boston.redhat.com> <20070809140908.GA18208@shell.boston.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 09, 2007 at 10:09:08AM -0400, Chris Snook wrote:
> Purify volatile use for atomic_t on sh64.
> 
> Signed-off-by: Chris Snook <csnook@redhat.com>

On Thu, Aug 09, 2007 at 10:10:34AM -0400, Chris Snook wrote:
> Purify volatile use for atomic_t on sh.
> 
> Signed-off-by: Chris Snook <csnook@redhat.com>

Acked-by: Paul Mundt <lethal@linux-sh.org>
