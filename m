From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all
 architectures
Date: Tue, 30 May 2017 09:49:05 +1000
Message-ID: <20170530094905.03ecc254@roar.ozlabs.ibm.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
        <20170529185251.GA3359@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35968 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdE2XtV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 19:49:21 -0400
In-Reply-To: <20170529185251.GA3359@ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alan Modra <amodra@gmail.com>, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, 29 May 2017 20:52:51 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> Hi Nicholas.
> 
> > Supporting two different intermediate-artifact packaging schemes
> > was only ever intended as a temporary transition.
> > 
> > This has so far caused no problems for powerpc, after a small fix
> > for how the arch invoked ar. So now allow any arch to select the
> > option, continue defaulting to N.  
> 
> Alan Modra recommended this approach several years ago, and I think
> Stephen was the first to implement this for the kernel.
> It would be good to have the rational whay ar is better than ld -r
> included in the commit message for later reference.

We *are* using Stephen's thin archives build infrastructure in the
kernel already. Only powerpc is using it so far: a5967db9af

The big one for powerpc build is that  the linker keeps relative
location of input sections the same, so as you link into larger
built-in.o files, there is less opportunity to place code optimally.
x86 may not care so much, but some other archs will.

The build output size improvement is nice for everyone though.

> I also recall that using ar gave some small kernel size reductions
> from last time we played with this.
> This info could also be nice to give a rough idea of the impact.

There is some explanation in sfr's patch. It's not thin archives
as such, but rather we have to link with --whole-archive, but it
was a very small impact.

IIRC today's final link is technically buggy without that option,
it's just that in practice the top-level built-in.o files pull in
so much that the linker will never discard one.

Thanks,
Nick
