Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:53262 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932731AbbENKbM (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 May 2015 06:31:12 -0400
Date: Thu, 14 May 2015 03:31:01 -0700
From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH v6] Documentation/arch: Add
 Documentation/arch-features.txt
Message-ID: <20150514103101.GA30945@x>
References: <20150513083441.GA17336@gmail.com>
 <20150513085636.GA11030@gmail.com>
 <20150513092421.GB11030@gmail.com>
 <20150513094622.GC11030@gmail.com>
 <20150513094756.GD11030@gmail.com>
 <20150513131835.GJ1517@pd.tnic>
 <20150513134842.GA1657@gmail.com>
 <20150513162757.GA21894@x>
 <20150513165358.GA22979@x>
 <20150514101615.GB27550@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150514101615.GB27550@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150514103101.lBTEFFZyvGWp5ayIT5usjqmHmaAE4OVF32zVZULMB5s@z>

On Thu, May 14, 2015 at 12:16:15PM +0200, Ingo Molnar wrote:
> 
> * Josh Triplett <josh@joshtriplett.org> wrote:
> 
> > On Wed, May 13, 2015 at 09:27:57AM -0700, Josh Triplett wrote:
> >
> > > How likely is this to get out of date?  Are people going to 
> > > remember to patch this when they add a feature to their 
> > > architecture?  If they found out they had work to do by reading 
> > > this file, which is the goal, then they'll likely remember to edit 
> > > the file; however, if they find the feature and fix it without 
> > > knowing about the file, will someone notice?
> > > 
> > > Is there any way we can *generate* this file from Kconfig?  Can we 
> > > extract the necessary "this is possible to enable" or "this arch 
> > > selects this symbol" information from Kconfig, and together with 
> > > the list of symbols for features needing architecture support, 
> > > generate the table?
> > 
> > Just tried this.  Looks like it's pretty trivial for most of these 
> > features: just make ARCH=thearch allyesconfig, then look for the 
> > config symbol in the result.
> 
> No, that's not nearly enough to do a correct support matrix, for 
> example due to subarchitectures that aren't included in an 
> allyesconfig.

Still feasible to automate with a bit more scripting.

> There are also many #define driven features.

It'd be nice to move those over to Kconfig.

- Josh Triplett
