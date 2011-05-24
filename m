From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: (Short?) merge window reminder
Date: Tue, 24 May 2011 15:48:39 +0100
Message-ID: <20110524144839.GC30117__32500.0185207047$1306248573$gmane$org@linux-mips.org>
References: <BANLkTi=PLuZhx1=rCfOtg=aOTuC1UbuPYg@mail.gmail.com>
 <20110523192056.GC23629@elte.hu>
 <BANLkTikdgM+kSvaEYuQkgCYJZELnvwfetg@mail.gmail.com>
 <20110523231721.GM10009@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50471 "EHLO duck.linux-mips.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752662Ab1EXOtX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 May 2011 10:49:23 -0400
Content-Disposition: inline
In-Reply-To: <20110523231721.GM10009@thunk.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ted Ts'o <tytso@mit.edu>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.ker

On Mon, May 23, 2011 at 07:17:21PM -0400, Ted Ts'o wrote:

> > So I'm toying with 3.0 (and in that case, it really would be "3.0",
> > not "3.0.0" - the stable team would get the third digit rather than
> > the fourth one.
> 
> If we change from 2.6.X to 3.X, then if we don't change anything else,
> then successive stable release will cause the LINUX_VERSION_CODE to be
> incremented.  This isn't necessary bad, but it would be a different
> from what we have now.

It will require another bunch of changes to scripts that try to make sense
out of kernel Linux version numbers.  It's a minor issue and we might be
better off doing something else than version number magic.  Not last a
new major version number raises expectations - whatever those might be.

  Ralf
