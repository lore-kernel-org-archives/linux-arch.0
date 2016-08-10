From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/5] kbuild: allow archs to select build for link dead
 code/data elimination
Date: Tue, 9 Aug 2016 17:37:42 -0700
Message-ID: <20160810003742.GI3078@tassilo.jf.intel.com>
References: <1470399123-8455-1-git-send-email-npiggin@gmail.com>
 <1882847.dG563Vieov@wuerfel>
 <20160809031605.GF3078@tassilo.jf.intel.com>
 <3076474.M72Ro1h3RL@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3076474.M72Ro1h3RL@wuerfel>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Modra <amodra@gmail.com>, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Aug 10, 2016 at 12:29:29AM +0200, Arnd Bergmann wrote:
> On Monday, August 8, 2016 8:16:05 PM CEST Andi Kleen wrote:
> > > I don't understand what led Andi Kleen to also move .text.hot and
> > > .text.unlikely together with .text [2], but this may have
> > > been a related issue.
> > >
> > > [2] https://lkml.org/lkml/2015/7/19/377
> >
> > The goal was just to move .hot and .unlikely all together, so that
> > they are clustered and use the minimum amount of cache. On x86 doesn't
> > matter where they are exactly, as long as each is together.
> > If they are not explicitely listed then the linker interleaves
> > them with the normal text, which defeats the purpose.
> 
> I still don't see it, my reading of your patch is that you did
> the opposite, by changing the description that puts all .text.hot
> in front of .text, and all .text.unlikely after exit.text into
> one that mixes them with .text. What am I missing here?

No it doesn't mix .unlikely with .text, .unlikely is all in one place.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
