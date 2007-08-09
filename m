Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53085 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762869AbXHIQy2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Aug 2007 12:54:28 -0400
Date: Thu, 9 Aug 2007 17:06:49 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2/24] make atomic_read() behave consistently on arm
Message-ID: <20070809160649.GA16405@flint.arm.linux.org.uk>
References: <20070809133028.GA13241@shell.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070809133028.GA13241@shell.boston.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Chris Snook <csnook@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, netdev@vger.kernel.org, akpm@linux-foundation.org, ak@suse.de, heiko.carstens@de.ibm.com, davem@davemloft.net, schwidefsky@de.ibm.com, wensong@linux-vs.org, horms@verge.net.au, wjiang@resilience.com, cfriesen@nortel.com, zlynx@acm.org, rpjday@mindspring.com, jesper.juhl@gmail.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 09, 2007 at 09:30:28AM -0400, Chris Snook wrote:
> From: Chris Snook <csnook@redhat.com>
> 
> Purify volatile use for atomic_t on arm.
> 
> Signed-off-by: Chris Snook <csnook@redhat.com>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
