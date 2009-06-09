From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/14] score - New architecure port to SunplusCT S+CORE
Date: Tue, 9 Jun 2009 18:37:28 +0200
Message-ID: <200906091837.28897.arnd@arndb.de>
References: <OF47CBE0C5.C2291ED8-ON482575CF.00287989-482575CF.0028F312@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54002 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756149AbZFIQjJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 9 Jun 2009 12:39:09 -0400
In-Reply-To: <OF47CBE0C5.C2291ED8-ON482575CF.00287989-482575CF.0028F312@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org, linux-arch-owner@vger.kernel.org, linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, torvalds@linux-foundation.org

On Monday 08 June 2009, liqin.chen@sunplusct.com wrote:
> Thanks Arnd, our MIS help me solve the download problem.
> 
> > Feel free to base you code on top of asm-generic.git#next, but tell me
> > when you intend to do that so I can warn you of possibly rebases.
> 
> Last week, I had updated score code base on asm-generic.git#next.
> 
> and I will apply a account on kernel.org, But before I get the account,
> can you let score code merge in asm-generic.git?

I can take your patches and apply them to a new branch in my tree
if that helps. I hope that Linus can pull my tree early in the
merge window so your architecture port and the microblaze changes
based on it can also get in soon.

I guess for the new architecture, it makes sense to combine all
your patches into a single changeset in git, since they don't
make sense until you have the complete set, and your changeset
comments are rather boring so far anyway.

Can you write a few paragraphs of text about your architecture
for the initial changeset comment? I think it would be good
to permanently store some facts in there, e.g. in which ways
the architecture is different from others, where to get a
toolchain and what kinds of hardware exist for it.

I'll go through the patches once more and see if I find anything
that should still be changed before the code goes in, but
from a brief look, the code looks pretty good now.

	Arnd <><
