From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: new execve/kernel_thread design
Date: Wed, 17 Oct 2012 06:43:37 +0100
Message-ID: <20121017054337.GX2616@ZenIV.linux.org.uk>
References: <20121016223508.GR2616@ZenIV.linux.org.uk>
 <CAMo8BfLdm1OvJTU2y-YQtoPffYsP=UzRco_q2GHWTo-bYQO4ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfLdm1OvJTU2y-YQtoPffYsP=UzRco_q2GHWTo-bYQO4ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 17, 2012 at 09:32:34AM +0400, Max Filippov wrote:
> On Wed, Oct 17, 2012 at 2:35 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > [apologies for enormous Cc; I've talked to some of you in private mail
> > and after being politely asked to explain WTF was all that thing for
> > and how was it supposed to work, well...]
> 
> [...]
> 
> > Not even a tentative patchset: hexagon, openrisc, tile, xtensa.
> 
> I'm doing xtensa part.

Thanks; I hope this variant is going to be less painful than messing with
ret_from_kernel_execve()...

> BTW, what linus-arch ML might be for?

A typo, noticed only when I got a bounce ;-)
My apologies...
