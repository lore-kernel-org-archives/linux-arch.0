From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 15:48:48 +0100
Message-ID: <20170330144847.GN29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <20170330143212.31353830@mschwideX1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:45782 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933768AbdC3OtP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 10:49:15 -0400
Content-Disposition: inline
In-Reply-To: <20170330143212.31353830@mschwideX1>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Helge Deller <del>

On Thu, Mar 30, 2017 at 02:32:12PM +0200, Martin Schwidefsky wrote:
> On Wed, 29 Mar 2017 06:57:06 +0100
> Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > 	The patchset currently in vfs.git#work.uaccess is the result;
> > there's more work to do, but it takes care of a large part of the
> > problems.  About 2.8KLoc removed, a lot of cruft is gone and semantics
> > is hopefully in sync now.  All but two architectures (ia64 and metag)
> > had been switched to new mechanism; for these two I'm afraid that I'll
> > need serious help from maintainers.
> 
> I have tested the code in vfs.git#work.uaccess and in principle it works
> for s390. I found one bug which would return an incorrect result
> for copy_from_user if the access faults on the last page of the copy.
> In that case the new code would return 0 instead of the remaining bytes.
> 
> This patch snippet should fix it, please just merge it into commit
> "s390: get rid of zeroing, switch to RAW_COPY_USER"

Done.
