Return-Path: <linux-arch-owner@vger.kernel.org>
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [patch 4/8] irq code: Add coherence test for PREEMPT_ACTIVE
Date: Sat, 28 May 2005 13:21:02 +0200
References: <20050527003843.433BA1AEE88@zion.home.lan> <200505270306.09425.blaisorblade@yahoo.it> <20050527033126.GH1329@linux-sh.org>
In-Reply-To: <20050527033126.GH1329@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281321.03246.blaisorblade@yahoo.it>
To: Paul Mundt <lethal@linux-sh.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, linux-sh@m17n.org, dhowells@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Friday 27 May 2005 05:31, Paul Mundt wrote:
> On Fri, May 27, 2005 at 03:06:09AM +0200, Blaisorblade wrote:
> > On Friday 27 May 2005 02:38, blaisorblade@yahoo.it wrote:

> > Ok, a grep shows that possible culprits (i.e. giving success to
> > grep GENERIC_HARDIRQS arch/*/Kconfig, and using 0x4000000 as
> > PREEMPT_ACTIVE, as given by grep PREEMPT_ACTIVE
> > include/asm-*/thread_info.h) are (at a first glance): frv, sh, sh64.

> Yeah, that's bogus for sh and sh64 anyways, this should do it.

> It would be nice to move PRREMPT_ACTIVE so it isn't per-arch anymore,
> there's not many users that use a different value (at least for the ones
> using generic hardirqs, ia64 seems to be the only one?).

Then in the generic headers
#ifndef PREEMPT_ACTIVE
#define PREEMPT_ACTIVE <the right value>
#else
<do the above coherence test>
#endif
Would be ok, right?
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
