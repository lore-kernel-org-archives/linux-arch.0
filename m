From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 5/6] block: permit I/O to vmalloc/vmap kernel pages
Date: Wed, 18 Nov 2009 09:21:06 -0500
Message-ID: <1258554066.2540.7.camel@mulgrave.site>
References: <1258477432-2513-6-git-send-email-James.Bottomley@suse.de>
	 <20091118191031Q.fujita.tomonori@lab.ntt.co.jp>
	 <1258552240.2540.0.camel@mulgrave.site>
	 <20091118231538D.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20091118231538D.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-parisc-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-11-18 at 23:15 +0900, FUJITA Tomonori wrote:
> On Wed, 18 Nov 2009 08:50:40 -0500
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > On Wed, 2009-11-18 at 19:10 +0900, FUJITA Tomonori wrote:
> > > On Tue, 17 Nov 2009 11:03:51 -0600
> > > James Bottomley <James.Bottomley@suse.de> wrote:
> > > 
> > > > This updates bio_map_kern() to check for pages in the vmalloc address
> > > > range and call the new kernel flushing APIs if the are.  This should
> > > > allow any kernel user to pass a vmalloc/vmap area to block.
> > > >
> > > > Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> > > > ---
> > > >  fs/bio.c |   20 ++++++++++++++++++--
> > > >  1 files changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > Do we need this?
> > > 
> > > Buffers that xfs_buf.c passes to block doesn't go to bio_map_kern()?
> > 
> > For completeness, yes ... because xfs *should* be passing its buffers to
> > bio_map_kern() ... it just happens to roll its own.
> 
> Ok, you mean that we will convert XFS to use bio_map_kern().
> 
> But adding another trick to bio_map_kern() to handle a vmalloc/vmap
> area is a good move? Only XFS do such, right?

Well, it's more a question of how we want the Linux APIs to look.
Should passing vmalloc/vmap areas into the I/O routines be wrong?  Right
at the moment it doesn't work but xfs is the only consumer.

There are definite reasons to say yes: greater flexibility for handling
large buffers which logging filesystems seem to need.

My position is either xfs is right and we should handle them correctly
(and hence all the APIs should handle them correctly including
bio_map_kern) or xfs is wrong and we should try and make it work with
current APIs (which would necessitate a large contiguous physical
allocation ... with all the associated problems).  I chose the former
with this patch.

James


