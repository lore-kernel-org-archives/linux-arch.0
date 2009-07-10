Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dallas.jonmasters.org ([72.29.103.172]:50849 "EHLO
	dallas.jonmasters.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752007AbZGJPum (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 11:50:42 -0400
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
From: Jon Masters <jonathan@jonmasters.org>
In-Reply-To: <4A57089B0200007800009C0E@vpn.id2.novell.com>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
	 <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
	 <200907092044.22108.rusty@rustcorp.com.au>
	 <4A57089B0200007800009C0E@vpn.id2.novell.com>
Content-Type: text/plain
Date: Fri, 10 Jul 2009 11:50:01 -0400
Message-ID: <1247241001.5006.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Michal Marek <mmarek@suse.cz>, Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, hpa@zytor.com
Message-ID: <20090710155001.32nLhMrdjQiUZsbJG445_-HXFgn3SD--nThq02v_4jE@z>

On Fri, 2009-07-10 at 08:23 +0100, Jan Beulich wrote:

> Actually I meanwhile think that module-init-tools can easily detect the changed
> layout without any further kernel side adjustments: Since it is known that a
> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
> value has more than 32 significant bits should suffice: If so, the new layout
> is being used (with the symbol name starting at offset 4), else the old one is
> in effect (name at offset 8). This ought to be a pretty trivial change to that
> code.

Agreed. That can be done. I won't get chance to do that until Sunday
though because I'm about to be on a plane back from Tokyo to Boston and
I expect a day of living hell with jetlag/email craziness.

Jon.


