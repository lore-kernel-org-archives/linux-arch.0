Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 13 Dec 2005 09:21:16 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051213092116.GA28751@infradead.org>
References: <dhowells1134431145@warthog.cambridge.redhat.com> <20051212161944.3185a3f9.akpm@osdl.org> <20051213075441.GB6765@elte.hu> <20051213075835.GZ15804@wotan.suse.de> <20051213004257.0f87d814.akpm@osdl.org> <20051213090331.GB27857@infradead.org> <20051213011413.1288f4cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213011413.1288f4cf.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, ak@suse.de, mingo@elte.hu, dhowells@redhat.com, torvalds@osdl.org, arjan@infradead.org, matthew@wil.cx, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Dec 13, 2005 at 01:14:13AM -0800, Andrew Morton wrote:
> Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Tue, Dec 13, 2005 at 12:42:57AM -0800, Andrew Morton wrote:
> > > scsi/sd.c is currently getting an ICE.  None of the new SAS code compiles,
> > > due to extensive use of anonymous unions.
> > 
> > This is just the headers in the luben code which need redoing completely
> > because they're doing other stupid things like using bitfields for on the
> > wire structures.
> 
> Don't think so (you're referring to Jeff's git-sas-jg.patch?).  It dies
> with current -linus tree.

I didn't mean sd.c but the anonymous union usage.  Everything that's stuffed
into include/scsi/sas/ in -mm is far from mergeable.  It's really badly done
headers that need to be redone.
