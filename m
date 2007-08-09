Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:43749 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbXHJLFL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Aug 2007 07:05:11 -0400
Date: Thu, 9 Aug 2007 21:09:27 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 13/24] make atomic_read() behave consistently on mips
Message-ID: <20070809200927.GA17855@linux-mips.org>
References: <20070809140004.GA17112@shell.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070809140004.GA17112@shell.boston.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 09, 2007 at 10:00:04AM -0400, Chris Snook wrote:

> Purify volatile use for atomic[64]_t on mips.
> 
> Signed-off-by: Chris Snook <csnook@redhat.com>

Acked-by: Ralf Baechle <ralf@linux-mips.org>
