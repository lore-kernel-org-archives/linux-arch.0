From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Date: Wed, 30 May 2018 22:21:27 +0200
Message-ID: <20180530202127.GV4511@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
 <20180516164403.GI27853@wotan.suse.de>
 <20180523213551.GF4511@wotan.suse.de>
 <20180530195500.GU4511@wotan.suse.de>
 <20180530200608.GA15435@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180530200608.GA15435@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, arnd@arndb.de, willy@infradead.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, May 30, 2018 at 10:06:08PM +0200, Greg KH wrote:
> On Wed, May 30, 2018 at 09:55:00PM +0200, Luis R. Rodriguez wrote:
> > On Wed, May 23, 2018 at 11:35:51PM +0200, Luis R. Rodriguez wrote:
> > > On Wed, May 16, 2018 at 06:44:03PM +0200, Luis R. Rodriguez wrote:
> > > > On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> > > > > This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> > > > > definitions into asm-generic headers. Greg asked for a Changelog
> > > > > for patch iteration changes, its below.
> > > > > 
> > > > > All these patches have been tested by 0-day.
> > > > > 
> > > > > Questions, and specially flames are greatly appreciated.
> > > > 
> > > > *Poke*
> > > 
> > > Greg, since this does touch the firmware loader as well, *poke*.
> > 
> > *Re-re-poke*
> 
> Hah, they are not for me to take, sorry, that's up to the mm maintainer.

I'm not sure it is up to mm actually, since this is all
include/asm-generic/pgtable.h it seems this falls onto Arnd.
Its probably *best* mm folks decide though.

Arnd, are you OK if Andrew picks this up if he finds no issues with
the patches?

I'll bouncing copies to Andrew now.

  Luis
