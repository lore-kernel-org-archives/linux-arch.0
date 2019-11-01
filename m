From: Dave Chinner <david@fromorbit.com>
Subject: Re: [RFC] errno.h: Provide EFSCORRUPTED for everybody
Date: Sat, 2 Nov 2019 08:38:23 +1100
Message-ID: <20191101213823.GW4614@dread.disaster.area>
References: <20191031010736.113783-1-Valdis.Kletnieks@vt.edu>
 <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXzyVBa4TZEc5eRaBzu50thgJ2TrHJLZqwhbQ=JASgWOA@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: driverdevel <devel@driverdev.osuosl.org>, Linux-Arch <linux-arch@vger.kernel.org>, Valdis Kletnieks <valdis.kletnieks@vt.edu>, Arnd Bergmann <arnd@arndb.de>, "Darrick J. Wong" <darrick.wong@oracle.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chao Yu <chao@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>, Jaegeuk Kim <jaegeuk@kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>, Gao Xiang <xiang@kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 01, 2019 at 09:57:31PM +0100, Geert Uytterhoeven wrote:
> Hi Valdis,
> 
> On Thu, Oct 31, 2019 at 2:11 AM Valdis Kletnieks
> <valdis.kletnieks@vt.edu> wrote:
> > Three questions: (a) ACK/NAK on this patch, (b) should it be all in one
> > patch, or one to add to errno.h and 6 patches for 6 filesystems?), and
> > (c) if one patch, who gets to shepherd it through?
> >
> > There's currently 6 filesystems that have the same #define. Move it
> > into errno.h so it's defined in just one place.
> >
> > Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
> 
> Thanks for your patch!
> 
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -98,6 +98,7 @@
> >  #define        EINPROGRESS     115     /* Operation now in progress */
> >  #define        ESTALE          116     /* Stale file handle */
> >  #define        EUCLEAN         117     /* Structure needs cleaning */
> > +#define        EFSCORRUPTED    EUCLEAN
> 
> I have two questions:
> a) Why not use EUCLEAN everywhere instead?
>     Having two different names for the same errno complicates grepping.

Because:
	a) EUCLEAN is horrible for code documentation. EFSCORRUPTED
	describes exactly the error being returned and/or checked for.

	b) we've used EFSCORRUPTED in XFS since 1993. i.e. it was an
	official, published error value on Irix, and we've kept it
	in the linux code for the past ~20 years because of a)

	c) Userspace programs that include filesystem specific
	headers have already been exposed to and use EFSCORRUPTED,
	so we can't remove/change it without breaking userspace.

	d) EUCLEAN has a convenient userspace string description
	that is appropriate for filesystem corruption: "Structure
	needs cleaning" is precisely what needs to happen. Repair of
	the filesystem (i.e. recovery to a clean state) is what is
	required to fix the error....

> b) Perhaps both errors should use different values?

That horse bolted to userspace years ago - this is just formalising
the practice that has spread across multiple linux filesystems from
XFS over the past ~10 years..

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
