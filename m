From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Thu, 2 Apr 2020 13:27:46 -0700
Message-ID: <202004021322.5F80467@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
 <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33989 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389112AbgDBU1u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 16:27:50 -0400
Received: by mail-pg1-f194.google.com with SMTP id l14so2390572pgb.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 13:27:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, Peter Anvin <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, Apr 02, 2020 at 12:26:52PM -0700, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Yup, I think it's a weakness of the ARM implementation and I'd like to
> > not extend it further. AFAIK we should never nest, but I would not be
> > surprised at all if we did.
> 
> Wel, at least the user_access_begin/end() sections can't nest. objtool
> verifies and warns about that on x86.

Right, yes, I mentioned that earlier in the thread. I meant I wasn't
100% sure about ARM's corner cases. I would _hope_ it doesn't.

> > If we were looking at a design goal for all architectures, I'd like
> > to be doing what the public PaX patchset
> 
> We already do better than PaX ever did. Seriously. Mainline has long
> since passed their hacky garbage.

I was just speaking to design principles in this area: if the "enable"
is called when already enabled, Something Is Wrong. :) (And one thing
still missing in this general subject is that x86 still lacks SMAP
emulation. And yes, I understand it's just not been a priority for anyone
that can work on it, but it is still a gap.)

-- 
Kees Cook
