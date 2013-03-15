From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Fwd: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Fri, 15 Mar 2013 19:43:45 +0000
Message-ID: <201303151943.45980.arnd@arndb.de>
References: <201303151455.38917.arnd@arndb.de> <20130315181246.GW4977@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20130315181246.GW4977@n2100.arm.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, inux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Friday 15 March 2013, Russell King - ARM Linux wrote:
> On Fri, Mar 15, 2013 at 02:55:38PM +0000, Arnd Bergmann wrote:

> > I'd like to merge this for 3.9 and also for the stable kernels,
> > if people agree this is a good idea.
> 
> I think I replied to your previous version recently asking whether
> this affects real uninitialized variables too.

If gcc can prove that there is a code path in which the variable is
used uninitialized, it will still warn with this patch, since we are
leaving -Wuninitialized enabled but only disable -Wmaybe-uninitilized.
There are obviously some cases where gcc correctly warns today but
cannot prove whether or not this is actually possible. I don't have
any data about how often we'd see one or the other, but I would expect
the first one to be more common.

We'd also still see all valid warnings with the Kconfig default of
building with -O2 rather than -Os, and as gcc gets smarter over time,
it should show more of the real bugs with -Wuninitialized.

I think the real trade-off is that not applying this patch will cause
more patches to get merged that add bogus initializations, which
definitely prevent gcc from warning about a real uninitialized
variable bug in that function again. I have done some of those
patches myself in the past, but it always feels really wrong to
do those.

	Arnd
