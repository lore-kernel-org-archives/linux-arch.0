From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] [-next] Makefile: Do not call cc-option before
 including the arch's Makefile
Date: Wed, 6 Jun 2012 11:49:12 +0200
Message-ID: <20120606094912.GG9495@gmail.com>
References: <1336855148-18817-1-git-send-email-geert@linux-m68k.org>
 <20120520092744.GA21341@merkur.ravnborg.org>
 <4FBF7B34.2080506@suse.cz>
 <20120525202937.GA22903@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45884 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833Ab2FFJtS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jun 2012 05:49:18 -0400
Content-Disposition: inline
In-Reply-To: <20120525202937.GA22903@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <mmarek@suse.cz>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, linux-kbuild@vger.kernel.org


* Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, May 25, 2012 at 02:29:40PM +0200, Michal Marek wrote:
> > Dne 20.5.2012 11:27, Sam Ravnborg napsal(a):
> > > On Sat, May 12, 2012 at 10:39:05PM +0200, Geert Uytterhoeven wrote:
> > >> On architectures that setup CROSS_COMPILE in their arch/*/Makefile
> > >> (blackfin, h8300, m68k, mips, parisc, score, sh, tile, unicore32, xtensa),
> > >> cc-option may check against the wrong compiler, causing errors like
> > >>
> > >> cc1: error: unrecognized command line option "-fno-ipa-cp-clone"
> > >>
> > >> if the host gcc supports -fno-ipa-cp-clone, while the cross compiler
> > >> doesn't support that option.
> > >>
> > >> Move the CONFIG_READABLE_ASM section below the inclusion of the arch's
> > >> Makefile to fix this.
> > >>
> > >> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >> Cc: Andi Kleen <ak@linux.intel.com>
> > >> Cc: H. Peter Anvin <hpa@zytor.com>
> > >> Cc: Michal Marek <mmarek@suse.cz>
> > >> Cc: linux-kbuild@vger.kernel.org
> > > 
> > > Michal - was this serie ever applied to kbuild?
> > 
> > The first patch has to go to the tip tree, where the CONFIG_READABLE_ASM
> > option is introduced.
> OK - I had not seen this.
> 
> So tip-folks - please apply this.

it's now all upstream so you can route it via the kbuild tree I 
guess?

Thanks,

	Ingo
