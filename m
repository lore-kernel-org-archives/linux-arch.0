From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Generic DMA - BUG_ON
Date: Thu, 21 Jan 2010 17:53:17 +0000
Message-ID: <20100121175317.GA14752@flint.arm.linux.org.uk>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu> <20100120105350.GA23394@flint.arm.linux.org.uk> <20100120110031.GD8665@amd.com> <1264089097.18869.0.camel@iscandar.digidescorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754768Ab0AURyI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1264089097.18869.0.camel@iscandar.digidescorp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Steven J. Magnani" <steve@digidescorp.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, monstr@monstr.eu, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 21, 2010 at 09:51:37AM -0600, Steven J. Magnani wrote:
> On Wed, 2010-01-20 at 12:00 +0100, Joerg Roedel wrote:
> > On Wed, Jan 20, 2010 at 10:53:50AM +0000, Russell King wrote:
> > > and ops is NULL, then this code will oops; you will get a full register
> > > dump and backtrace.  You can use this information along with markup_oops.pl
> > > to find out where the problem is.
> > 
> > You can't rely on the oops if the code runs in process context. The
> > process may have address 0 mapped which would result in a security hole.
> > We had two of these bugs last year.
> 
> You also can't rely on an oops in a NOMMU environment.

I don't see why implementations where NULL pointer derefs should be
penalized by having additional NULL checks.

Maybe this needs to be a conditional check which can be optimized away
on architectures where NULL dereference always produces an oops.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
