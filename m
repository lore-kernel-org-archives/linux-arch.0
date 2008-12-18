From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: PROC macro to annotate functions in assembly files
Date: Thu, 18 Dec 2008 11:44:27 +0000
Message-ID: <20081218114427.GD10593@flint.arm.linux.org.uk>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1636.1229511233@redhat.com> <20081217111213.GA8342@mailshack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33379 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbYLRLqJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Dec 2008 06:46:09 -0500
Content-Disposition: inline
In-Reply-To: <20081217111213.GA8342@mailshack.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@mailshack.com>
Cc: David Howells <dhowells@redhat.com>, Alexander van Heukelum <heukelum@fastmail.fm>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>

On Wed, Dec 17, 2008 at 12:12:14PM +0100, Alexander van Heukelum wrote:
> Yeah, assembly files contain some interesting nesting. In this
> particular case I think the solution is simple... Just use PROC
> and ENDPROC around the complete functions, and leave the explicit
> .global's for the additional entry points.

I'm sorry, that doesn't work in all cases.

On ARM with later toolchains, there's additional metadata associated with
every symbol, and it's beginning to matter getting this right.  That
metadata includes whether it's a function, and more importantly whether
the code pointed to by the symbol is Thumb or ARM.

This leads to:

ENTRY(__ashldi3)
ENTRY(__aeabi_llsl)

...

ENDPROC(__ashldi3)
ENDPROC(__aeabi_llsl)

and we want both of those symbols to have exactly the same attributes.

Merely adding a .globl for the second name doesn't do that.  It needs
.globl, .size, and .type.

So what you're actually talking about using your approach is enforcing
the pairing of the existing ENTRY/ENDPROC and open coding everything
else.

Forgive me if I think this is a backward step.  It certainly seems to
add some insane restrictions.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
