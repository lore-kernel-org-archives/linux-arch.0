From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC 11/32] xfs: convert to struct inode_time
Date: Fri, 30 May 2014 17:41:14 -0700
Message-ID: <5389252A.5050503@zytor.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	<1401480116-1973111-12-git-send-email-arnd@arndb.de>
	<20140531003712.GH14410@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xfs-bounces@oss.sgi.com>
In-Reply-To: <20140531003712.GH14410@dastard>
List-Unsubscribe: <http://oss.sgi.com/mailman/options/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=unsubscribe>
List-Archive: <http://oss.sgi.com/pipermail/xfs>
List-Post: <mailto:xfs@oss.sgi.com>
List-Help: <mailto:xfs-request@oss.sgi.com?subject=help>
List-Subscribe: <http://oss.sgi.com/mailman/listinfo/xfs>,
	<mailto:xfs-request@oss.sgi.com?subject=subscribe>
Errors-To: xfs-bounces@oss.sgi.com
Sender: xfs-bounces@oss.sgi.com
To: Dave Chinner <david@fromorbit.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, xfs@oss.sgi.com, hch@infradead.org, john.stultz@linaro.org, lftan@altera.com, linux-fsdevel@vger.kernel.org, geert@linux-m68k.org, tglx@linutronix.de, joseph@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On 05/30/2014 05:37 PM, Dave Chinner wrote:
> 
> IOWs, the filesystem has to be able to reject any attempt to set a
> timestamp that is can't represent on disk otherwise Bad Stuff will
> happen,

Actually it is questionable if it is worse to reject a timestamp or just
let it wrap.  Rejecting a valid timestamp is a bit like "You don't
exist, go away."

> and filesystems have to be able to specify in their on
> disk format what timestamp encoding is being used. The solution will
> be different for every filesystem that needs to support time beyond
> 2038.

Actually the cutoff can be really different for each filesystem, not
necessarily 2038.  However, I maintain the above still holds.

Consider a filesystem that kept timestamps in YYMMDDHHMMSS format.  What
would you have expected such a filesystem to do on Jan 1, 2000?

	-hpa


_______________________________________________
xfs mailing list
xfs@oss.sgi.com
http://oss.sgi.com/mailman/listinfo/xfs
