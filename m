Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266892AbUIOGTn@vger.kernel.org>
Received: from are.twiddle.net ([64.81.246.98]:11138 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S266582AbUIOGTm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Sep 2004 02:19:42 -0400
Date: Tue, 14 Sep 2004 23:19:27 -0700
From: Richard Henderson <rth@twiddle.net>
Subject: Re: waitid fallout
Message-ID: <20040915061927.GA1683@twiddle.net>
References: <20040915143730.6b230fbc.sfr@canb.auug.org.au> <200409150534.i8F5YeCF011453@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409150534.i8F5YeCF011453@magilla.sf.frob.com>
To: Roland McGrath <roland@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, Sep 14, 2004 at 10:34:40PM -0700, Roland McGrath wrote:
> Ah, I only ever looked at the sizes on i386, where there was plenty of
> room.  As you can see in my posts of the waitid patches, the si_rusage
> addition is not required by POSIX.

I eventually found them (I heart google).  This idea makes a lot of
sense, particularly if rusage had fit everywhere.

> If we were to take it back out, then it would make more sense to have
> the system call be like SGI's waitsys that takes the waitid args plus
> a struct rusage *.  

This solution would make me happy.


r~
