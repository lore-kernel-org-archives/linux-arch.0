Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:37591 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752845AbbCPWDJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Mar 2015 18:03:09 -0400
Date: Tue, 17 Mar 2015 09:02:53 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] fstests: generic test for preadv2 behavior on linux
Message-ID: <20150316220253.GF28557@dastard>
References: <cover.1426528417.git.milosz@adfin.com>
 <1426530862-32276-1-git-send-email-milosz@adfin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426530862-32276-1-git-send-email-milosz@adfin.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, Mel Gorman <mgorman@suse.de>, Volker Lendecke <Volker.Lendecke@sernet.de>, Tejun Heo <tj@kernel.org>, Jeff Moyer <jmoyer@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org, Michael Kerrisk <mtk.manpages@gmail.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20150316220253.1S1g7o6vFnREYZzF3zpknGBcpF2oSyUOOonsiROsCjw@z>

On Mon, Mar 16, 2015 at 02:34:22PM -0400, Milosz Tanski wrote:
> preadv2 is a new syscall introduced that is like preadv2 but with flag
> argument. The first use case of this is to let us add a flag to perform a
> non-blocking file using the page cache.
> ---
>  src/Makefile           |   2 +-
>  src/preadv2-pwritev2.h |  52 +++++++++++++++++
>  src/preadv2.c          | 150 +++++++++++++++++++++++++++++++++++++++++++++++++

You should add this syscall to support to xfs_io (in the xfsprogs
package) rather than write a new helper for it. Mainly because:

> +void
> +usage(char *prog)
> +{
> +	fprintf(stderr, "Usage: %s [-v] [-ctdw] [-n] -p POS -l LEN <filename>\n\n", prog);
> +	fprintf(stderr, "General arguments:\n");
> +	fprintf(stderr, "  -v Verify that the syscall is supported and quit:\n");
> +	fprintf(stderr, "\n");
> +	fprintf(stderr, "Open arguments:\n");
> +	fprintf(stderr, "  -c Open file with O_CREAT flag\n");
> +	fprintf(stderr, "  -t Open file with O_TRUNC flag\n");
> +	fprintf(stderr, "  -d Open file with O_DIRECT flag\n");
> +	fprintf(stderr, "  -w Open file with O_RDWR flag vs O_RDONLY (default)\n");
> +	fprintf(stderr, "\n");
> +	fprintf(stderr, "preadv2 arguments:\n");
> +	fprintf(stderr, "  -n use RWF_NONBLOCK when performing read\n");
> +	fprintf(stderr, "  -p POS offset file to read at\n");
> +	fprintf(stderr, "  -l LEN length of file data to read\n");

The xfs_io pread command already supports all of these functions
except for the RWF_NONBLOCK flag, and anyone testing bleeding edge
functionality is also using a bleeding edge xfs_io binary.

Then you test for whether the functionality is available via
_require_xfs_io_command "preadv -n"

.....
> +# test file we'll be using
> +file=$SCRATCH_MNT/067.preadv2.$$
> +
> +# Create a file:
> +# two regions of data and a hole in the middle
> +# use O_DIRECT so it's not in the page cache
> +echo "create file"
> +$XFS_IO_PROG -t -f -d \
> +	-c "pwrite 0 1024" \
> +	-c "pwrite 2048 1024" \
> +	$file > /dev/null

This does not create holes on most filesystems. You'll need to leave
holes of up 64k so that 64k block size filesystem end up with single
block holes in them.

> +# Make sure it returns EAGAIN on uncached data
> +echo "uncached"
> +$here/src/preadv2 -n -p 0 -l 1024 $file

$XFS_IO_PROG -c "pread -n 0 1024" $file | _filter_xfs_io

> +
> +# Make sure we read in the whole file, after that RWF_NONBLOCK should return us all the data
> +echo "cached"
> +$XFS_IO_PROG -f $file -c "pread 0 4096" $file > /dev/null
> +$here/src/preadv2 -n -p 0 -l 1024 $file

$XFS_IO_PROG -c "pread 0 4096" -c "pread -n 0 1024" $file | _filter_xfs_io

> +
> +# O_DIRECT and RWF_NONBLOCK should return EAGAIN always
> +echo "O_DIRECT"
> +$here/src/preadv2 -d -n -p 0 -l 1024 $file

$XFS_IO_PROG -d -c "pread -n 0 1024" $file | _filter_xfs_io

And so on....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
