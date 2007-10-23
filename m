Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:60688 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752439AbXJWR0M (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Oct 2007 13:26:12 -0400
Date: Tue, 23 Oct 2007 19:27:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] Discardable strings for init and exit sections
Message-ID: <20071023172747.GB26345@uranus.ravnborg.org>
References: <Pine.LNX.4.64N.0710121711120.21684@blysk.ds.pg.gda.pl> <20071012174507.GA21193@uranus.ravnborg.org> <Pine.LNX.4.64N.0710231758070.8693@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0710231758070.8693@blysk.ds.pg.gda.pl>
Sender: linux-arch-owner@vger.kernel.org
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Franck Bui-Huu <vagabon.xyz@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-arch@vger.kernel.org, linux-mips@linux-mips.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> 
>  Arguably all the existing linker scripts should be made more consistent I 
> suppose.  Currently all the {init,exit} annotations are handled separately 
> by each architecture, so this would be no exception.  If you have a 
> proposal as to how to do it cleanly, people will certainly appreciate it.

Patches appreciated. I have made many of the linekr scripts use same
format now - so it is easier to see what is equal and can be consolidated.

	Sam
