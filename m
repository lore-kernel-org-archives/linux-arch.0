Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from eru.sfritsch.de ([88.198.11.6]:33470 "EHLO eru.sfritsch.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757784AbZBWUDX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 23 Feb 2009 15:03:23 -0500
From: Stefan Fritsch <sf@sfritsch.de>
Reply-To: sf@sfritsch.de, debian-hppa@lists.debian.org,
	  linux-arch@vger.kernel.org
Subject: Re: flock, EAGAIN, and EWOULDBLOCK
Date: Mon, 23 Feb 2009 20:31:18 +0100
References: <200902222252.45051.sf@sfritsch.de> <119aab440902221843y7e664581w99a9d44257672ae2@mail.gmail.com> <20090223030315.GC16891@parisc-linux.org>
In-Reply-To: <20090223030315.GC16891@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200902232031.18702.sf@sfritsch.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: debian-hppa@lists.debian.org
Cc: linux-arch@vger.kernel.org
Message-ID: <20090223193118.hOET74pkH04hAR_R7ucQwFmPAVbde4Zcp9U8OaRomd8@z>

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
