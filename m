From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 5/6] block: permit I/O to vmalloc/vmap kernel pages
Date: Wed, 18 Nov 2009 08:50:40 -0500
Message-ID: <1258552240.2540.0.camel@mulgrave.site>
References: <1258477432-2513-4-git-send-email-James.Bottomley@suse.de>
	 <1258477432-2513-5-git-send-email-James.Bottomley@suse.de>
	 <1258477432-2513-6-git-send-email-James.Bottomley@suse.de>
	 <20091118191031Q.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <20091118191031Q.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-parisc-owner@vger.kernel.org
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-11-18 at 19:10 +0900, FUJITA Tomonori wrote:
> On Tue, 17 Nov 2009 11:03:51 -0600
> James Bottomley <James.Bottomley@suse.de> wrote:
> 
> > This updates bio_map_kern() to check for pages in the vmalloc address
> > range and call the new kernel flushing APIs if the are.  This should
> > allow any kernel user to pass a vmalloc/vmap area to block.
> >
> > Signed-off-by: James Bottomley <James.Bottomley@suse.de>
> > ---
> >  fs/bio.c |   20 ++++++++++++++++++--
> >  1 files changed, 18 insertions(+), 2 deletions(-)
> 
> Do we need this?
> 
> Buffers that xfs_buf.c passes to block doesn't go to bio_map_kern()?

For completeness, yes ... because xfs *should* be passing its buffers to
bio_map_kern() ... it just happens to roll its own.

James



