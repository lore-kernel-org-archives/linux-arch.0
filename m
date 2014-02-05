Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:38807 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbaBEO2i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2014 09:28:38 -0500
Date: Wed, 5 Feb 2014 09:28:25 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205142824.GA23780@windriver.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
 <20140205064150.GA31568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20140205064150.GA31568@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus Torvalds <torvalds@linux-foundation.org>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-ia64@vger.kernel.org, linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, akpm@linux-foundation.org, gregkh@linuxfoundation.org, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Message-ID: <20140205142825.s0dA0Z_sWwcxoMT_xsxG13qEnVDS520C7vBdA8_F2sM@z>

[Re: [GIT PULL] tree-wide: clean up no longer required #include <linux/init.h>] On 05/02/2014 (Wed 07:41) Ingo Molnar wrote:

> 
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Ingo,
> > 
> > On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > > 
> > > So, if you meant Linus to pull it, you probably want to cite a real 
> > > Git URI along the lines of:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> > 
> > Paul provided the proper git url further down in the mail along with the
> > usual pull request message (I guess he should have put that bit at the
> > top).
> 
> Yeah, indeed, and it even comes with a signed tag, which is an extra 
> nice touch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup
> 
> (I guess the https was mentioned first to lower expectations.)

Just to clarify, the init.git was the repo of raw commits+series file
that was used for testing on linux next; now useless, except for showing
the last several weeks of history (hence the visual http link).  The
signed tag [separate repo] is the application of those commits against
the 3.14-rc1 tag, which was the end goal from the beginning.

Does history matter?  In the case of a cleanup like this, it does only
in the immediate context of this pull request; to help distinguish this
work from some short lived half baked idea that also had its testing
invalidated by arbitrarily rebasing onto the latest shiny tag.

I wouldn't have even mentioned the patch repo, except for the fact that
I know how Linus loves arbitrary rebases [and malformed pull requests]  :)

Thanks,
Paul.
--

> 
> Thanks,
> 
> 	Ingo
