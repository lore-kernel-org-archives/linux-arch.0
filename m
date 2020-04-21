From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] uaccess: Rename user_access_begin/end() to user_full_access_begin/end()
Date: Tue, 21 Apr 2020 11:34:04 -0700
Message-ID: <CAHk-=wiuHxXwuPynLFh-fYjuUE3_HNPh79e_P6MFMbq4Ki+QCw@mail.gmail.com>
References: <36e43241c7f043a24b5069e78c6a7edd11043be5.1585898438.git.christophe.leroy@c-s.fr>
 <42da416106d5c1cf92bda1e058434fe240b35f44.1585898438.git.christophe.leroy@c-s.fr>
 <CAHk-=wh_DY_dysMX0NuvJmMFr3+QDKOZPZqWKwLkkjgZTuyQ+A@mail.gmail.com>
 <20200403205205.GK23230@ZenIV.linux.org.uk> <20200421024919.GA23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200421024919.GA23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Peter Anvin <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux-MM <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, intel-gfx@lists.freedesktop.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-arch.vger.kernel.org

On Mon, Apr 20, 2020 at 7:49 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         The only source I'd been able to find speaks of >= 60 cycles
> (and possibly much more) for non-pipelined coprocessor instructions;
> the list of such does contain loads and stores to a bunch of registers.
> However, the register in question (p15/c3) has only store mentioned there,
> so loads might be cheap; no obvious reasons for those to be slow.
> That's a question to arm folks, I'm afraid...  rmk?

_If_ it turns out to be expensive, is there any reason we couldn't
just cache the value in general?

That's what x86 tends to do with expensive system registers. One
example would be "msr_misc_features_shadow".

But maybe that's something to worry about when/if it turns out to
actually be a problem?

                 Linus
