Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S267591AbUIOFet@vger.kernel.org>
Received: from mail5.speakeasy.net ([216.254.0.205]:54750 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S265697AbUIOFet
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 01:34:49 -0400
Date: Tue, 14 Sep 2004 22:34:40 -0700
Message-Id: <200409150534.i8F5YeCF011453@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: waitid fallout
In-Reply-To: Stephen Rothwell's message of  Wednesday, 15 September 2004 14:37:30 +1000 <20040915143730.6b230fbc.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Richard Henderson <rth@twiddle.net>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> On Tue, 14 Sep 2004 20:39:03 -0700 Richard Henderson <rth@twiddle.net> wrote:
> >
> > Is an *entire* struct rusage required in siginfo_t for sigchld?
> > 
> > It's much bigger than the 24 (!) words of padding we had reserved
> > for expansion in siginfo_t.

Ah, I only ever looked at the sizes on i386, where there was plenty of
room.  As you can see in my posts of the waitid patches, the si_rusage
addition is not required by POSIX.  I chose to add it so that the waitid
call would subsume all functionality of wait4 et al and suffice as the sole
call in the wait family that a new architecture should be obliged to
provide in its system call table.  If we were to take it back out, then it
would make more sense to have the system call be like SGI's waitsys that
takes the waitid args plus a struct rusage *.  
