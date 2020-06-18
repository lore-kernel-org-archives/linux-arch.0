From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: Move p?d_alloc_track to separate header file
Date: Thu, 18 Jun 2020 12:17:59 +0300
Message-ID: <20200618091759.GH6493@linux.ibm.com>
References: <20200609120533.25867-1-joro@8bytes.org>
 <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200617181226.ab213ea1531b5dd6eca1b0b6@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joerg Roedel <joro@8bytes.org>, peterz@infradead.org, jroedel@suse.de, Andy Lutomirski <luto@kernel.org>, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, Stephen Rothwell <sfr@canb.auug.org.au>, manvanth@linux.vnet.ibm.com, linux-next@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, hch@lst.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 17, 2020 at 06:12:26PM -0700, Andrew Morton wrote:
> On Tue,  9 Jun 2020 14:05:33 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> 
> > From: Joerg Roedel <jroedel@suse.de>
> > 
> > The functions are only used in two source files, so there is no need
> > for them to be in the global <linux/mm.h> header. Move them to the new
> > <linux/pgalloc-track.h> header and include it only where needed.
> > 
> > ...
> >
> > new file mode 100644
> > index 000000000000..1dcc865029a2
> > --- /dev/null
> > +++ b/include/linux/pgalloc-track.h
> > @@ -0,0 +1,51 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_PGALLLC_TRACK_H
> > +#define _LINUX_PGALLLC_TRACK_H
> 
> hm, no #includes.  I guess this is OK, given the limited use.
> 
> But it does make one wonder whether ioremap.c should be moved from lib/
> to mm/ and this file should be moved from include/linux/ to mm/.

It makes sense, but I am anyway planning consolidation of pgalloc.h, so
most probably pgalloc-track will not survive until 5.9-rc1 :)

If you think that it worth moving ioremap.c to mm/ regardless of chrun,
I can send a patch for that.

> Oh well.

-- 
Sincerely yours,
Mike.
