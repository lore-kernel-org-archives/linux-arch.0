Return-Path: <rmk+linux-arch=vger.kernel.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1293 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265628AbUFDHop (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Jun 2004 03:44:45 -0400
Date: Fri, 4 Jun 2004 08:44:40 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: FUTEX_CMP_REQUEUE and 6-argument syscall
Message-ID: <20040604084440.B22925@flint.arm.linux.org.uk>
References: <20040603110221.1fe58b53.zaitcev@redhat.com> <16575.50024.908291.283284@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16575.50024.908291.283284@cargo.ozlabs.ibm.com>; from paulus@samba.org on Fri, Jun 04, 2004 at 10:33:44AM +1000
Sender: Russell King <rmk@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, schwidefsky@de.ibm.com, linux-arch@vger.kernel.org, akpm@osdl.org, jakub@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jun 04, 2004 at 10:33:44AM +1000, Paul Mackerras wrote:
> Pete Zaitcev writes:
> 
> > I'm curious if any other architecture was caught out by this.
> 
> Six is currently the limit on ppc and ppc64.  It would be possible to
> increase it to 7 fairly easily or 8 with a bit more trouble.  Beyond
> that we would start getting arguments on the stack.

Six is also the current limit on ARM, and we have the possibility
to go to 7 with some more stack mangling.  However, 8 is more
problematical - I suspect at that point we'll be in the arguments
on user stack territory.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
