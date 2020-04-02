From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Thu, 2 Apr 2020 11:35:57 -0700
Message-ID: <202004021132.813F8E88@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402175032.GH23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 02, 2020 at 06:50:32PM +0100, Al Viro wrote:
> On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> 
> > user_access_begin() grants both read and write.
> > 
> > This patch adds user_read_access_begin() and user_write_access_begin() but
> > it doesn't remove user_access_begin()
> 
> Ouch...  So the most generic name is for the rarest case?
>  
> > > What should we do about that?  Do we prohibit such blocks outside
> > > of arch?
> > > 
> > > What should we do about arm and s390?  There we want a cookie passed
> > > from beginning of block to its end; should that be a return value?
> > 
> > That was the way I implemented it in January, see
> > https://patchwork.ozlabs.org/patch/1227926/
> > 
> > There was some discussion around that and most noticeable was:
> > 
> > H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> > a "key" variable: it's a direct attack vector for a crowbar attack,
> > especially since it is by definition live inside a user access region."
> 
> > This patch minimises the change by just adding user_read_access_begin() and
> > user_write_access_begin() keeping the same parameters as the existing
> > user_access_begin().
> 
> Umm...  What about the arm situation?  The same concerns would apply there,
> wouldn't they?  Currently we have
> static __always_inline unsigned int uaccess_save_and_enable(void)
> {
> #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         unsigned int old_domain = get_domain();
> 
>         /* Set the current domain access to permit user accesses */
>         set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
>                    domain_val(DOMAIN_USER, DOMAIN_CLIENT));
> 
>         return old_domain;
> #else
>         return 0;
> #endif
> }
> and
> static __always_inline void uaccess_restore(unsigned int flags)
> {
> #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         /* Restore the user access mask */
>         set_domain(flags);
> #endif
> }
> 
> How much do we need nesting on those, anyway?  rmk?

Yup, I think it's a weakness of the ARM implementation and I'd like to
not extend it further. AFAIK we should never nest, but I would not be
surprised at all if we did.

If we were looking at a design goal for all architectures, I'd like
to be doing what the public PaX patchset did for their memory access
switching, which is to alarm if calling into "enable" found the access
already enabled, etc. Such a condition would show an unexpected nesting
(like we've seen with similar constructs with set_fs() not getting reset
during an exception handler, etc etc).

-- 
Kees Cook
