From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and user_write_access_begin/end
Date: Thu, 2 Apr 2020 13:47:24 -0700
Message-ID: <CAHk-=wjUfAsepavvy2vsnyOv06yeYBMumSeb+dzDSnJXkX7qPQ@mail.gmail.com>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk> <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
 <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com> <202004021322.5F80467@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <202004021322.5F80467@keescook>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, Peter Anvin <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 2, 2020 at 1:27 PM Kees Cook <keescook@chromium.org> wrote:
>
> I was just speaking to design principles in this area: if the "enable"
> is called when already enabled, Something Is Wrong. :)

Well, the "something is wrong" could easily be "the hardware does not
support this".

I'm not at all interested in the crazy code to do this in software.
Nobody sane should ever do that.

Yes, I realize that PaX did software emulation of things like that,
and it was one of the reasons why it was never useful to any normal
use.

Security is not an end goal in itself, it's always secondary to "can I
use this".

Security that means "normal people can't use this, it's only for the
special l33t users" is not security, it's garbage. That "do page
tables in software" was a prime example of garbage.

               Linus
