From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: CONFIG_GENERIC_SIGALTSTACK with asm-generic/syscalls.h (was Re:
 [git pull] signal.git pile 2)
Date: Fri, 21 Dec 2012 16:07:14 +0000
Message-ID: <20121221160713.GT4939@ZenIV.linux.org.uk>
References: <20121221002100.GM4939@ZenIV.linux.org.uk>
 <50D40088.3030304@synopsys.com>
 <50D44D61.6090006@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45102 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab2LUQHS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 Dec 2012 11:07:18 -0500
Content-Disposition: inline
In-Reply-To: <50D44D61.6090006@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Arnd Bergmann <arnd@arndb.de>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Fri, Dec 21, 2012 at 11:52:01AM +0000, James Hogan wrote:

> Reviewed-by: James Hogan <james.hogan@imgtec.com>
> 
> I also see this issue with metag when I try and select
> CONFIG_GENERIC_SIGALTSTACK. Until asm-generic/syscalls.h goes away it
> seems a shame to have to keep a misleading #define sys_sigaltstack
> sys_sigaltstack bodge in architecture's asm/syscalls.h.

OK, I'm convinced; Vineet, could you reply with Signed-off-by: to use?
It's trivial, of course, but...
