From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 02/20] mm: generic show_mem()
Date: Sun, 29 Jun 2008 02:51:33 +0900
Message-ID: <20080628175133.GA6364@linux-sh.org>
References: <20080627115349.743368154@saeurebad.de> <20080627120048.059732179@saeurebad.de> <20080628042240.GB25492@linux-sh.org> <87myl5ama2.fsf@skyscraper.fehenstaub.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mta23.gyao.ne.jp ([125.63.38.249]:36366 "EHLO mx.gate01.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753388AbYF1RyJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Jun 2008 13:54:09 -0400
Content-Disposition: inline
In-Reply-To: <87myl5ama2.fsf@skyscraper.fehenstaub.lan>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Johannes Weiner <hannes@saeurebad.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Jun 28, 2008 at 12:25:57PM +0200, Johannes Weiner wrote:
> Paul Mundt <lethal@linux-sh.org> writes:
> > On Fri, Jun 27, 2008 at 01:53:51PM +0200, Johannes Weiner wrote:
> >> This implements a platform-independent version of show_mem().
> >> 
> >> Signed-off-by: Johannes Weiner <hannes@saeurebad.de>
> >
> > Looking at this again, does having this as a Kconfig option really make
> > sense? We have no tristate in-tree users of this that I can see, wouldn't
> > this be better off in lib/? It would be preferable not to let the
> > HAVE_foo stuff get out of hand if we can avoid it.
> 
> I hate the current Kconfig usage, too.  But I figured, if I won't obey
> on such decisions by people who maintain it, it won't have a chance to
> get in.
> 
> So, what do you suggest?  Moving it to lib/ and have one simple #define
> if the arch wants to use it or not?
> 
There's no need for a define. If you move it to lib/ it will just be the
default implementation unless an architecture overloads it with their own
definition. With your current patch set, you should just be able to shove
it in to lib/, drop the Kconfig option, and be good to go.
