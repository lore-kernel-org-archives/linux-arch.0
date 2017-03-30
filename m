From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 16:31:59 +0100
Message-ID: <20170330153159.GP29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
 <20170329210322.GJ29622@ZenIV.linux.org.uk>
 <CA+55aFyEQ_naUW6Q+qVoBA24bgBh1=2H+V54k501uV2pKFv+nw@mail.gmail.com>
 <20170329230934.GK29622@ZenIV.linux.org.uk>
 <CA+55aFzvcU7sNa_qp6pkYau20RwL3UVDw5-dmce0EE1MX7JuKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzvcU7sNa_qp6pkYau20RwL3UVDw5-dmce0EE1MX7JuKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 29, 2017 at 04:43:05PM -0700, Linus Torvalds wrote:

> > As for __copy_in_user()... I'm not sure we want to keep it in the long run -
> 
> I agree, it's probably not worth it at all.
> 
> In fact, I suspect none of the "__copy_.*_user()" versions are worth
> it, and we should strive to remove them.
> 
> There aren't even that many users, and they _have_ caused security
> issues when people have had some path that hasn't checked the range.

Actually, looking through those users shows some very odd places: for example,
sctp_setsockopt_bindx() does
        /* Check the user passed a healthy pointer.  */
        if (unlikely(!access_ok(VERIFY_READ, addrs, addrs_size)))
                return -EFAULT;

        /* Alloc space for the address array in kernel memory.  */
        kaddrs = kmalloc(addrs_size, GFP_USER | __GFP_NOWARN);
        if (unlikely(!kaddrs))
                return -ENOMEM;

        if (__copy_from_user(kaddrs, addrs, addrs_size)) {
                kfree(kaddrs);
                return -EFAULT;
        }
The obvious question is "why not memdup_user()?" and rationale looks fishy:
 * We don't use copy_from_user() for optimization: we first do the
 * sanity checks (buffer size -fast- and access check-healthy
 * pointer); if all of those succeed, then we can alloc the memory
 * (expensive operation) needed to copy the data to kernel. Then we do
 * the copying without checking the user space area
 * (__copy_from_user()).
plus that:
    sctp: use GFP_USER for user-controlled kmalloc
    
    Dmitry Vyukov reported that the user could trigger a kernel warning by
    using a large len value for getsockopt SCTP_GET_LOCAL_ADDRS, as that
    value directly affects the value used as a kmalloc() parameter.
    
    This patch thus switches the allocation flags from all user-controllable
    kmalloc size to GFP_USER to put some more restrictions on it and also
    disables the warn, as they are not necessary.

First of all, access_ok() for sanity checks on size is BS - on some
architectures it's constant 1 and on *all* architectures it allows a lot
more than what kmalloc() will.  So it won't stop a malicious program from
getting to kmalloc() and wasting its cycles and it's not much help with
buggy ones.  __GFP_NOWARN part is more interesting, but... the quoted
commit misses memdup_user() calls in other setsockopt cases on the same
sctp.  So if we care about that one, we probably should care about the
rest of them as well, and I doubt that open-coding each is a good solution.
Something like kvmemdup_user(), perhaps?  I.e. quiet fallback to vmalloc
on large sizes/in case when kmalloc barfs, with kvfree on the freeing side?
Or just a flat-out check for some reasonably upper limit on optlen in
the very beginning?
