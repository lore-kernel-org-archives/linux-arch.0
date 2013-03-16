From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: Fwd: [PATCH] Turn off -Wmaybe-uninitialized when building with
 -Os
Date: Sat, 16 Mar 2013 08:56:14 +0000
Message-ID: <1363424174.2459.15.camel@dabdike>
References: <201303151455.38917.arnd@arndb.de>
	 <20130315181246.GW4977@n2100.arm.linux.org.uk>
	 <201303151943.45980.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <201303151943.45980.arnd@arndb.de>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kbuild@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, inux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Fri, 2013-03-15 at 19:43 +0000, Arnd Bergmann wrote:
> On Friday 15 March 2013, Russell King - ARM Linux wrote:
> > On Fri, Mar 15, 2013 at 02:55:38PM +0000, Arnd Bergmann wrote:
> 
> > > I'd like to merge this for 3.9 and also for the stable kernels,
> > > if people agree this is a good idea.
> > 
> > I think I replied to your previous version recently asking whether
> > this affects real uninitialized variables too.
> 
> If gcc can prove that there is a code path in which the variable is
> used uninitialized, it will still warn with this patch, since we are
> leaving -Wuninitialized enabled but only disable -Wmaybe-uninitilized.
> There are obviously some cases where gcc correctly warns today but
> cannot prove whether or not this is actually possible. I don't have
> any data about how often we'd see one or the other, but I would expect
> the first one to be more common.
> 
> We'd also still see all valid warnings with the Kconfig default of
> building with -O2 rather than -Os, and as gcc gets smarter over time,
> it should show more of the real bugs with -Wuninitialized.
> 
> I think the real trade-off is that not applying this patch will cause
> more patches to get merged that add bogus initializations, which
> definitely prevent gcc from warning about a real uninitialized
> variable bug in that function again. I have done some of those
> patches myself in the past, but it always feels really wrong to
> do those.

I always reject any set variable to zero (or mark it uninitialised) just
because gcc warns patches precisely because they would hide future
errors; all the checkers we care about have a false positive matching
system now.  The thing this would cut down on is the number of newbie "I
compiled the kernel myself and this fixes the warning I found" type
patches, which I do see as a net benefit.

James



