From: "Alexander van Heukelum" <heukelum@fastmail.fm>
Subject: Re: PROC macro to annotate functions in assembly files
Date: Thu, 18 Dec 2008 13:35:02 +0100
Message-ID: <1229603702.27623.1290725827@webmail.messagingengine.com>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
 <1636.1229511233@redhat.com> <20081217111213.GA8342@mailshack.com>
 <20081218114427.GD10593@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753413AbYLRMf2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081218114427.GD10593@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <rmk+lkml@arm.linux.org.uk>, Alexander van Heukelum <heukelum@mailshack.com>
Cc: David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, 18 Dec 2008 11:44:27 +0000, "Russell King"
<rmk+lkml@arm.linux.org.uk> said:
> On Wed, Dec 17, 2008 at 12:12:14PM +0100, Alexander van Heukelum wrote:
> > Yeah, assembly files contain some interesting nesting. In this
> > particular case I think the solution is simple... Just use PROC
> > and ENDPROC around the complete functions, and leave the explicit
> > .global's for the additional entry points.
> 
> I'm sorry, that doesn't work in all cases.
> 
> On ARM with later toolchains, there's additional metadata associated with
> every symbol, and it's beginning to matter getting this right.  That
> metadata includes whether it's a function, and more importantly whether
> the code pointed to by the symbol is Thumb or ARM.
> 
> This leads to:
> 
> ENTRY(__ashldi3)
> ENTRY(__aeabi_llsl)
> 
> ...
> 
> ENDPROC(__ashldi3)
> ENDPROC(__aeabi_llsl)
> 
> and we want both of those symbols to have exactly the same attributes.
> 
> Merely adding a .globl for the second name doesn't do that.  It needs
> .globl, .size, and .type.
> 
> So what you're actually talking about using your approach is enforcing
> the pairing of the existing ENTRY/ENDPROC and open coding everything
> else.

Note that enforcing the pairing will be enabled by ARCH code. Is the
construct you show here (two symbols covering identical code) the only
problem you forsee? I don't want to introduce too many macro's to
handle special cases, but this one should be solved.

> Forgive me if I think this is a backward step.  It certainly seems to
> add some insane restrictions.

Some restrictions are introduced, indeed. And I agree that evading the
checking framework by doing things manually should be avoided.

Greetings,
    Alexander

> -- 
> Russell King
>  Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
>  maintainer of:
-- 
  Alexander van Heukelum
  heukelum@fastmail.fm

-- 
http://www.fastmail.fm - The way an email service should be
