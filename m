Return-Path: <carlos@baldric.uwo.ca>
Received: from baldric.uwo.ca ([129.100.10.225]:773 "EHLO baldric")
	by vger.kernel.org with ESMTP id S261912AbUB1U3q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Feb 2004 15:29:46 -0500
Date: Sat, 28 Feb 2004 15:28:33 -0500
From: "Carlos O'Donell" <carlos@baldric.uwo.ca>
Subject: Re: compat-signal-noarch-2004-01-29.patch
Message-ID: <20040228202833.GB19963@baldric.uwo.ca>
References: <20040226155930.GB24779@baldric.uwo.ca> <20040226173115.7bd1aa86.ak@suse.de> <20040226163812.GP25779@parcelfarce.linux.theplanet.co.uk> <20040226174753.4319802c.ak@suse.de> <20040226194747.GA28037@baldric.uwo.ca> <20040226205058.5a0d1e34.ak@suse.de> <20040227234037.GB10923@baldric.uwo.ca> <20040302213932.55852152.ak@suse.de> <20040228191536.GA19963@baldric.uwo.ca> <20040228203658.5a11df00.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040228203658.5a11df00.ak@suse.de>
To: Andi Kleen <ak@suse.de>
Cc: willy@debian.org, akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> Is it really that hard to do the switch in architecture specific code?

Yes, because I loathe the code duplication I'm seeing in all the arch
directories. Please don't tell me that it's more maintainable that way.
IMO, and I am not granted a crystal ball, the situation could be made
cleaner through:

a. Creation of arch/generic, assigning a maintainer to that arch.
b. Move kernel/signal.c(copy_siginfo_to_user) to arch/generic/signal.c
c. Have all interested arches build with arch/generic/signal.o
d. Add compat code into arch/generic for people with simple ABI's 
   to include.

The fundamental issue is that kernel signal code wants to write to the
stack, and that's a no-no. A generic copy_siginfo_to_user function was
written, and it was good enough for almost all the arches. Now we need
compat for that generic function. Who's responsible? Me?

Please comment. 

Andi, I appreciate your input, I'm trying to wrap my head around your
worries, but my inexperience limits my understanding. Perhaps your
glasses are more jaded than mine?

c.
