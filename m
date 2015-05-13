Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47496 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEMQyI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2015 12:54:08 -0400
Date: Wed, 13 May 2015 09:53:59 -0700
From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [RFC PATCH v6] Documentation/arch: Add
 Documentation/arch-features.txt
Message-ID: <20150513165358.GA22979@x>
References: <20150512213843.GV21418@twins.programming.kicks-ass.net>
 <20150512144910.0b49c9a7a13336773449db33@linux-foundation.org>
 <20150513083441.GA17336@gmail.com>
 <20150513085636.GA11030@gmail.com>
 <20150513092421.GB11030@gmail.com>
 <20150513094622.GC11030@gmail.com>
 <20150513094756.GD11030@gmail.com>
 <20150513131835.GJ1517@pd.tnic>
 <20150513134842.GA1657@gmail.com>
 <20150513162757.GA21894@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150513162757.GA21894@x>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150513165359.yx3Wv-qcMxPO2bff9ApNVjf_YJmrOBOzh0kToGm5uI0@z>

On Wed, May 13, 2015 at 09:27:57AM -0700, Josh Triplett wrote:
> How likely is this to get out of date?  Are people going to remember to
> patch this when they add a feature to their architecture?  If
> they found out they had work to do by reading this file, which is the
> goal, then they'll likely remember to edit the file; however, if they
> find the feature and fix it without knowing about the file, will someone
> notice?
> 
> Is there any way we can *generate* this file from Kconfig?  Can we
> extract the necessary "this is possible to enable" or "this arch selects
> this symbol" information from Kconfig, and together with the list of
> symbols for features needing architecture support, generate the table?

Just tried this.  Looks like it's pretty trivial for most of these
features: just make ARCH=thearch allyesconfig, then look for the config
symbol in the result.

For instance, after doing "make ARCH=alpha allyesconfig":

~/src/linux$ grep -x 'CONFIG_ARCH_HAS_ELF_RANDOMIZE=y' .config || echo TODO
TODO

~/src/linux$ grep -x 'CONFIG_GENERIC_CLOCKEVENTS=y' .config || echo TODO
CONFIG_GENERIC_CLOCKEVENTS=y

This seems easy to turn into a shell script or Python script, given a list of
feature descriptions and corresponding config symbols, as well as a list of
architectures.

- Josh Triplett
