Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from symlink.to.noone.org ([85.10.207.172]:57570 "EHLO sym.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753750Ab1H2QSg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Aug 2011 12:18:36 -0400
Date: Mon, 29 Aug 2011 18:18:31 +0200
From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: __ARCH_WANT_SYSCALL_DEPRECATED
Message-ID: <20110829161831.GA11405@distanz.ch>
References: <20110822193602.GA23301@codeaurora.org> <2047151.mWElcT8jZQ@wuerfel> <20110829104324.GM24840@distanz.ch> <Pine.LNX.4.64.1108291518300.17624@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108291518300.17624@digraph.polyomino.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Joseph S. Myers" <joseph@codesourcery.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Linas Vepstas (Code Aurora)" <linas@codeaurora.org>, Chris Metcalf <cmetcalf@tilera.com>, Jonas Bonn <jonas.bonn@gmail.com>, libc-ports@sourceware.org, linux-hexagon@vger.kernel.org, linux-arch@vger.kernel.org, Mark Salter <msalter@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20110829161831.7uiRuC_sH8qKqI9kC9Q9d9JDRWvfCzFFJ7Jy1GnP0J4@z>

On 2011-08-29 at 17:21:52 +0200, Joseph S. Myers <joseph@codesourcery.com> wrote:
> On Mon, 29 Aug 2011, Tobias Klauser wrote:
> 
> > On nios2 we're using an outdated eglibc version (based on glibc 2.5)
> > right now and thus we still rely on our own non-asm-generic version of
> > asm/unistd.h
> 
> As I noted before 
> <http://sourceware.org/ml/libc-ports/2010-09/msg00014.html> Nios II has 
> the problem for upstream submission of the unassigned nature of the 
> binutils and GCC ports - unless you know of any progress on that issue at 
> Altera.

Thanks, I wasn't aware of the discussion in this thread. Unfortunately
I do not know of any progress wrt this matter at Altera.

My primary interest at the moment is getting the kernel port ready for
mainline submission. One of the requirements for this to happen seems
to be the convertion to the asm-generic syscall ABI which I'm currently
working on. For this an updated glibc port will be needed.

Joseph: Are the sources of the improved CodeSourcery port availbale
somewhere publicly or are they only available if one buys/evaluates
CodeBench?

I'd like to base my glibc work to come on the most recent and mature
version of glibc, so it would be nice to start off CodeSourcey's
version.

Thanks
Tobias
