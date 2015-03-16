Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:48134 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932286AbbCPW5c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Mar 2015 18:57:32 -0400
Date: Tue, 17 Mar 2015 09:56:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: generic test for preadv2 behavior on linux
Message-ID: <20150316225649.GH28557@dastard>
References: <cover.1426528417.git.milosz@adfin.com>
 <1426530862-32276-1-git-send-email-milosz@adfin.com>
 <20150316220253.GF28557@dastard>
 <CANP1eJEj2buvwaU-jum=GROowY6DrysQ0NU+weXstn=83yVspQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANP1eJEj2buvwaU-jum=GROowY6DrysQ0NU+weXstn=83yVspQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, Linux API <linux-api@vger.kernel.org>, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150316225649.WH0cPHtlWH0JwOdLrQ-Na-mMOJTiKV2S3HhC3TD7D-8@z>

On Mon, Mar 16, 2015 at 06:11:19PM -0400, Milosz Tanski wrote:
> On Mon, Mar 16, 2015 at 6:02 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Mon, Mar 16, 2015 at 02:34:22PM -0400, Milosz Tanski wrote:
> >> preadv2 is a new syscall introduced that is like preadv2 but with flag
> >> argument. The first use case of this is to let us add a flag to perform a
> >> non-blocking file using the page cache.
> >> ---
> >>  src/Makefile           |   2 +-
> >>  src/preadv2-pwritev2.h |  52 +++++++++++++++++
> >>  src/preadv2.c          | 150 +++++++++++++++++++++++++++++++++++++++++++++++++
> >
> > You should add this syscall to support to xfs_io (in the xfsprogs
> > package) rather than write a new helper for it. Mainly because:
> >
> >> +void
> >> +usage(char *prog)
> >> +{
> >> +     fprintf(stderr, "Usage: %s [-v] [-ctdw] [-n] -p POS -l LEN <filename>\n\n", prog);
> >> +     fprintf(stderr, "General arguments:\n");
> >> +     fprintf(stderr, "  -v Verify that the syscall is supported and quit:\n");
> >> +     fprintf(stderr, "\n");
> >> +     fprintf(stderr, "Open arguments:\n");
> >> +     fprintf(stderr, "  -c Open file with O_CREAT flag\n");
> >> +     fprintf(stderr, "  -t Open file with O_TRUNC flag\n");
> >> +     fprintf(stderr, "  -d Open file with O_DIRECT flag\n");
> >> +     fprintf(stderr, "  -w Open file with O_RDWR flag vs O_RDONLY (default)\n");
> >> +     fprintf(stderr, "\n");
> >> +     fprintf(stderr, "preadv2 arguments:\n");
> >> +     fprintf(stderr, "  -n use RWF_NONBLOCK when performing read\n");
> >> +     fprintf(stderr, "  -p POS offset file to read at\n");
> >> +     fprintf(stderr, "  -l LEN length of file data to read\n");
> >
> > The xfs_io pread command already supports all of these functions
> > except for the RWF_NONBLOCK flag, and anyone testing bleeding edge
> > functionality is also using a bleeding edge xfs_io binary.
> >
> > Then you test for whether the functionality is available via
> > _require_xfs_io_command "preadv -n"
> >
> > .....
> >> +# test file we'll be using
> >> +file=$SCRATCH_MNT/067.preadv2.$$
> >> +
> >> +# Create a file:
> >> +# two regions of data and a hole in the middle
> >> +# use O_DIRECT so it's not in the page cache
> >> +echo "create file"
> >> +$XFS_IO_PROG -t -f -d \
> >> +     -c "pwrite 0 1024" \
> >> +     -c "pwrite 2048 1024" \
> >> +     $file > /dev/null
> >
> > This does not create holes on most filesystems. You'll need to leave
> > holes of up 64k so that 64k block size filesystem end up with single
> > block holes in them.
> 
> Noted and I shall fix this in the next round.
> 
> >
> >> +# Make sure it returns EAGAIN on uncached data
> >> +echo "uncached"
> >> +$here/src/preadv2 -n -p 0 -l 1024 $file
> >
> > $XFS_IO_PROG -c "pread -n 0 1024" $file | _filter_xfs_io
> >
> >> +
> >> +# Make sure we read in the whole file, after that RWF_NONBLOCK should return us all the data
> >> +echo "cached"
> >> +$XFS_IO_PROG -f $file -c "pread 0 4096" $file > /dev/null
> >> +$here/src/preadv2 -n -p 0 -l 1024 $file
> >
> > $XFS_IO_PROG -c "pread 0 4096" -c "pread -n 0 1024" $file | _filter_xfs_io
> >
> >> +
> >> +# O_DIRECT and RWF_NONBLOCK should return EAGAIN always
> >> +echo "O_DIRECT"
> >> +$here/src/preadv2 -d -n -p 0 -l 1024 $file
> >
> > $XFS_IO_PROG -d -c "pread -n 0 1024" $file | _filter_xfs_io
> >
> > And so on....
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
> 
> Dave,
> 
> My plan is/was to wait till the main patch makes it into the upstream
> linux kernel with the syscall numbers are set in stone. Possibly after
> till glibc adds support for them. After that I was going remove my
> preadv2 application from xfs_tests and add that functionality to
> xfs_io.

I wouldn't worry too much about glibc - once the syscall numbers are
defined we can test for them directly, I think, like we do for
supporting various ioctls.

> With xfs_io living in separate repository I wanted to the case when/if
> syscall numbers change (there's a bunch of new syscalls queued around
> epoll) of having somebody test against xfs_io that has preadv2 but bad
> ids.

If the syscall numbers change, it's simple to patch, and as long as
we have set the syscall numbers in stone before a xfsprogs release
is done then there won't be any problems...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
