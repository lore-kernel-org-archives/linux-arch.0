From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: PROC macro to annotate functions in assembly files
Date: Thu, 18 Dec 2008 15:53:29 +0000
Message-ID: <20081218155329.GA30546@flint.arm.linux.org.uk>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1636.1229511233@redhat.com> <20081217111213.GA8342@mailshack.com> <20081218114427.GD10593@flint.arm.linux.org.uk> <1229603702.27623.1290725827@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57014 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYLRPyR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Dec 2008 10:54:17 -0500
Content-Disposition: inline
In-Reply-To: <1229603702.27623.1290725827@webmail.messagingengine.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: Alexander van Heukelum <heukelum@mailshack.com>, David Howells <dhowells@redhat.com>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>

On Thu, Dec 18, 2008 at 01:35:02PM +0100, Alexander van Heukelum wrote:
> Note that enforcing the pairing will be enabled by ARCH code. Is the
> construct you show here (two symbols covering identical code) the only
> problem you forsee? I don't want to introduce too many macro's to
> handle special cases, but this one should be solved.

Well, there are some cases where we don't have ENTRY but do have ENDPROC:

__pabt_usr:
        usr_entry
...
ENTRY(ret_from_exception)
...
ENDPROC(__pabt_usr)
ENDPROC(ret_from_exception)

        .macro  vector_stub, name, mode, correction=0
        .align  5

vector_\name:
...
ENDPROC(vector_\name)
        .endm

Not sure if we have any other oddities.
-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
