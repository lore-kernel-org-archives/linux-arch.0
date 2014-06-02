From: "Joseph S. Myers" <joseph@codesourcery.com>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Mon, 2 Jun 2014 14:00:11 +0000
Message-ID: <Pine.LNX.4.64.1406021355230.19591@digraph.polyomino.org.uk>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	<1401480116-1973111-12-git-send-email-arnd@arndb.de>
	<20140531003712.GH14410@dastard>
	<5389252A.5050503@zytor.com> <20140531011450.GJ14410@dastard>
	<c7770275-61de-4e94-9586-5ee118f77ba5@email.android.com>
	<20140531055457.GK14410@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <20140531055457.GK14410@dastard>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Dave Chinner <david@fromorbit.com>
Cc: linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, lftan@altera.com, hch@infradead.org, john.stultz@linaro.org, "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org, geert@linux-m68k.org, tglx@linutronix.de, xfs@oss.sgi.com
List-Id: linux-arch.vger.kernel.org

On Sat, 31 May 2014, Dave Chinner wrote:

> If we are changing the in-kernel timestamp to have a greater dynamic
> range that anything we current support on disk, then we need support
> for all filesystems for similar translation and constraint. The
> filesystems need to be able to tell the kernel what they timestamp
> range they support, and then the kernel needs to follow those
> guidelines. And if the filesystem is mounted on a kernel that
> doesn't support the current filesystem's timestamp format, then at
> minimum that filesystem cannot do anything that writes a
> timestamp....
> 
> Put simply: the filesystem defines the timestamp range that can be
> used safely, not the userspace API. If the filesystem can't support
> the date it is handed then that is an out-of-range error. Since
> when have we accepted that it's OK to handle out-of-range data with
> silent overflows or corruption of the data that we are attempting to
> store? We're defining a new API to support a wider date range -
> there is nothing that prevents us from saying ERANGE can be returned
> to a timestamp that the file cannot store correctly....

I don't see anything new about this issue.  All problems that could arise 
from the kernel being able to represent a timestamp some filesystems can't 
are problems that already apply with 64-bit kernels using 64-bit time_t 
internally.  So while as part of Y2038-preparedness we do need a clear 
understanding of which filesystems have what timestamp limits and what 
happens with timestamps beyond those limits, I think this is a separate 
strand of the problem - one that applies to both 32-bit and 64-bit systems 
- from the more general issue for 32-bit systems.

-- 
Joseph S. Myers
joseph@codesourcery.com

_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
