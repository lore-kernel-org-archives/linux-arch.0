From: Joerg Roedel <joerg.roedel@amd.com>
Subject: Re: Generic DMA - BUG_ON
Date: Wed, 20 Jan 2010 12:00:31 +0100
Message-ID: <20100120110031.GD8665@amd.com>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
 <20100120105350.GA23394@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753521Ab0ATLAw@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100120105350.GA23394@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@monstr.eu, linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 20, 2010 at 10:53:50AM +0000, Russell King wrote:
> and ops is NULL, then this code will oops; you will get a full register
> dump and backtrace.  You can use this information along with markup_oops.pl
> to find out where the problem is.

You can't rely on the oops if the code runs in process context. The
process may have address 0 mapped which would result in a security hole.
We had two of these bugs last year.

But I don't see any point in checking for dma_ops != NULL too. Any
developer would mention such a bug long before init is started.

	Joerg
