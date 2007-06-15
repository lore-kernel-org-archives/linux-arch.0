Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:43736 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353AbXFONcl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Jun 2007 09:32:41 -0400
Subject: Re: [PATCH] Introduce compat_u64 and compat_s64 types
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <200706151527.45143.ak@suse.de>
References: <200706151355.57464.ak@suse.de> <200706151454.28854.ak@suse.de>
	 <20070615141544.5a8e234e@the-village.bc.nu> <200706151527.45143.ak@suse.de>
Content-Type: text/plain
Date: Fri, 15 Jun 2007 14:32:31 +0100
Message-Id: <1181914351.25228.520.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Fri, 2007-06-15 at 15:27 +0200, Andi Kleen wrote:
> Hopefully everybody who deploys these systems knows this. It seems
> like a open death trap to me, especially since the consequences
> are so severe: remote packet of death, could be a recall for 
> a network conntected embedded device that doesn't easily allow
> firmware update. And they would rightfully blame Linux.
> 
> It would be much safer if the parts of the stack that weren't
> audited/tested were marked this way and check for BROKEN_UNALIGNED or
> similar.

If we did the get_probably_unaligned() thing, then on architectures
where we _do_ trap and fix up, we could actually spit out a warning
whenever we hit a trap and it _wasn't_ marked with
get_probably_unaligned().

> Also frankly I'm surprised that whoever designed these systems
> didn't learn from the old M68000 who made this mistake the first time.

Mostly, the machines which can't handle traps are the machines which
don't even have an MMU. Why add hardware when you don't really need it?
Fundamentally, it isn't a hardware design flaw. You could perhaps ask
interesting questions about whether Linux is _really_ the right software
to be using on them, but the fact remains that Linux _is_ the software
people are using on them.

-- 
dwmw2

