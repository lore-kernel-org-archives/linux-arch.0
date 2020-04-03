From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Date: Fri, 3 Apr 2020 11:02:57 +0100
Message-ID: <20200403100257.GB25745@shell.armlinux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59130 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 06:03:18 -0400
Content-Disposition: inline
In-Reply-To: <202004021132.813F8E88@keescook>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christophe Leroy <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie, daniel@ffwll.ch, torvalds@linux-foundation.org, akpm@linux-foundation.org, hpa@zytor.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu, Apr 02, 2020 at 11:35:57AM -0700, Kees Cook wrote:
> On Thu, Apr 02, 2020 at 06:50:32PM +0100, Al Viro wrote:
> > On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> > 
> > > user_access_begin() grants both read and write.
> > > 
> > > This patch adds user_read_access_begin() and user_write_access_begin() but
> > > it doesn't remove user_access_begin()
> > 
> > Ouch...  So the most generic name is for the rarest case?
> >  
> > > > What should we do about that?  Do we prohibit such blocks outside
> > > > of arch?
> > > > 
> > > > What should we do about arm and s390?  There we want a cookie passed
> > > > from beginning of block to its end; should that be a return value?
> > > 
> > > That was the way I implemented it in January, see
> > > https://patchwork.ozlabs.org/patch/1227926/
> > > 
> > > There was some discussion around that and most noticeable was:
> > > 
> > > H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> > > a "key" variable: it's a direct attack vector for a crowbar attack,
> > > especially since it is by definition live inside a user access region."
> > 
> > > This patch minimises the change by just adding user_read_access_begin() and
> > > user_write_access_begin() keeping the same parameters as the existing
> > > user_access_begin().
> > 
> > Umm...  What about the arm situation?  The same concerns would apply there,
> > wouldn't they?  Currently we have
> > static __always_inline unsigned int uaccess_save_and_enable(void)
> > {
> > #ifdef CONFIG_CPU_SW_DOMAIN_PAN
> >         unsigned int old_domain = get_domain();
> > 
> >         /* Set the current domain access to permit user accesses */
> >         set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
> >                    domain_val(DOMAIN_USER, DOMAIN_CLIENT));
> > 
> >         return old_domain;
> > #else
> >         return 0;
> > #endif
> > }
> > and
> > static __always_inline void uaccess_restore(unsigned int flags)
> > {
> > #ifdef CONFIG_CPU_SW_DOMAIN_PAN
> >         /* Restore the user access mask */
> >         set_domain(flags);
> > #endif
> > }
> > 
> > How much do we need nesting on those, anyway?  rmk?

It's that way because it's easy, logical, and actually *more* efficient
to do it that way, rather than read-modify-write the domain register
each time we want to change it.

> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.

There is one known nesting, which is __clear_user() when used with
the (IMHO horrid and I don't care about) UACCESS_WITH_MEMCPY feature.
That's not intentional however.

When I introduced this on ARM, the placement I adopted was to locate
it _as close as sanely possible_ to the userspace access so we
minimised the kernel accesses, so we minimise the number of accesses
that could go stray because of the domain issue - we ideally only
want the access done by the accessor itself to be affected, which
we achieve for most accesses.

Thinking laterally, maybe we should get rid of the whole KERNEL_DS
stuff entirely, and come up with an alternative way of handling the
kernel-wants-to-access-kernelspace-via-user-accessors problem.
Such as, copying some data back to userspace memory?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
