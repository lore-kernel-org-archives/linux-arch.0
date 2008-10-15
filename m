From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] remove ibcs2/PER_SVR4 from SET_PERSONALITY
Date: Wed, 15 Oct 2008 19:17:19 +0100
Message-ID: <20081015181719.GA10387@flint.arm.linux.org.uk>
References: <1224072352.16990.18.camel@localhost> <20081015121445.GB21756@flint.arm.linux.org.uk> <1224075143.16990.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59682 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbYJOSSN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Oct 2008 14:18:13 -0400
Content-Disposition: inline
In-Reply-To: <1224075143.16990.25.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org

On Wed, Oct 15, 2008 at 02:52:23PM +0200, Martin Schwidefsky wrote:
> On Wed, 2008-10-15 at 13:14 +0100, Russell King wrote:
> > On Wed, Oct 15, 2008 at 02:05:52PM +0200, Martin Schwidefsky wrote:
> > > Greetings,
> > > this is the ibcs2/PER_SVR4 removal patch against today git tree. Nobody
> > > complained so I guess it is ready for prime time.
> > 
> > Not yet.
> 
> But now ?

The ARM bit now look fine to me.  Thanks.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
