From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Generic DMA - BUG_ON
Date: Wed, 20 Jan 2010 10:53:50 +0000
Message-ID: <20100120105350.GA23394@flint.arm.linux.org.uk>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753120Ab0ATKyN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 20, 2010 at 11:08:30AM +0100, monstr@monstr.eu wrote:
> Hi All,
> 
> I have this patch in my repo. I just added BUG_ON for dma ops.
> The reason for that is if driver not setup ops correctly than
> the system do bad access to any memory space without any visible reason.
> BUG_ON points to it and helps to solve where the problem is.

I have a question of principle to raise here.

If you have code which does:

	if (ops->foo)
		ops->foo();

and ops is NULL, then this code will oops; you will get a full register
dump and backtrace.  You can use this information along with markup_oops.pl
to find out where the problem is.

If you add a BUG_ON() to this, the only additional information you end
up with is (possibly) a nice friendly message which tells you the file
and line number - but you add additional run-time tests to the code.

The question is: is this worth it?  Is there some problem with the
original oops that makes the problem hard to find?  Should we be using
BUG_ON() to augment normal oopses in this way?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
