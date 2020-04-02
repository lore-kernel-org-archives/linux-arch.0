From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Thu, 2 Apr 2020 12:26:52 -0700
Message-ID: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk> <202004021132.813F8E88@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <202004021132.813F8E88@keescook>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Kees Cook <keescook@chromium.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Dave Airlie <airlied@linux.ie>, Peter Anvin <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Linux-MM <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>, Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 2, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.

Wel, at least the user_access_begin/end() sections can't nest. objtool
verifies and warns about that on x86.

> If we were looking at a design goal for all architectures, I'd like
> to be doing what the public PaX patchset

We already do better than PaX ever did. Seriously. Mainline has long
since passed their hacky garbage.

Plus PaX  and grsecurity should be actively shunned. Don't look at it,
don't use it, and tell everybody you know to not use that shit.

                Linus
