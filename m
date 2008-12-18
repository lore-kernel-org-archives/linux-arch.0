From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/many] PROC macro to annotate functions in assembly files
Date: Thu, 18 Dec 2008 10:07:47 +0000
Message-ID: <20081218100747.GA10593@flint.arm.linux.org.uk>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1229505475-10219-2-git-send-email-heukelum@fastmail.fm> <20081217172640.GB5436@uranus.ravnborg.org> <20081217173824.GF8078@localhost> <20081217180023.GA5783@uranus.ravnborg.org> <1229593918.31758.1290707307@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54886 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbYLRKIL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Dec 2008 05:08:11 -0500
Content-Disposition: inline
In-Reply-To: <1229593918.31758.1290707307@webmail.messagingengine.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>, Jan Beulich <jbeulich@novell.com>, linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Dec 18, 2008 at 10:51:58AM +0100, Alexander van Heukelum wrote:
> Agreed. I vote to complement the existing ENDPROC annotation with
> the proposed PROC annotation. Let's call that an extension, not
> something new ;). As it stands it is not impossible to go with
> ENTRY/ENDPROC for code and ENTRY/END for data. However, ENTRY
> implies alignment and the prefered alignment for code and data
> might differ.

Have you looked at the number of ENTRY uses for code vs for data?
If all you're after is separating the two uses, then it might be a
smaller patch to change the ENTRY use for data rather than changing
all the ENTRY uses for code.

There are 589 uses of ENTRY in arch/arm/*/*.S.  Of those about 50
aren't called code.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
