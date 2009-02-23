From: Stefan Fritsch <sf@sfritsch.de>
Subject: Re: flock, EAGAIN, and EWOULDBLOCK
Date: Mon, 23 Feb 2009 20:31:18 +0100
Message-ID: <200902232031.18702.sf@sfritsch.de>
References: <200902222252.45051.sf@sfritsch.de> <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com> <20090223030315.GC16891@parisc-linux.org>
Reply-To: sf@sfritsch.de,
 debian-hppa@lists.debian.org,
 linux-arch@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <bounce-debian-hppa=debian-hppa=m.gmane.org@lists.debian.org>
In-Reply-To: <20090223030315.GC16891@parisc-linux.org>
Content-Disposition: inline
Resent-Message-ID: <NslwCX8WBiM.A.HwG.k5voJB@liszt>
List-Post: <mailto:debian-hppa@lists.debian.org>
List-Help: <mailto:debian-hppa-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-hppa-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-hppa-request@lists.debian.org?subject=unsubscribe>
To: debian-hppa@lists.debian.org
Cc: linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Monday 23 February 2009, Matthew Wilcox wrote:
> On Sun, Feb 22, 2009 at 09:43:36PM -0500, Carlos O'Donell wrote:
> > flock is not POSIX, it's an interface invented by 4.2BSD, and was
> > previously emulated by glibc. The glibc wrapper implemented flock
> > with fcntl and made sure to return EWOULDBLOCK.

As an additional data point, openbsd's flock man page also says it 
should return EWOULDBLOCK.

> We actually can do better than this ...
>
> #ifdef __KERNEL__
> #define EWOULDBLOCK	EAGAIN
> #else
> #define EWOULDBLOCK	/* whatever the fuck HPUX uses */
> #endif
>
> Now our kernel never returns -EWOULDBLOCK, only -EAGAIN.  Correct
> applications must check for both.  Incorrect applications tend to
> only check for AGAIN, not WOULDBLOCK.  Problem solved.

This seems to be the current behaviour WRT flock(). But this is 
broken. An application (like apr in this case) that checks for the 
documented and well established return code is _not_ incorrect.

For apr in Debian, I will simply add the check for EAGAIN. But this is 
cannot be the general solution.


Cheers,
Stefan
