From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 00:09:35 +0100
Message-ID: <20170329230934.GK29622@ZenIV.linux.org.uk>
References: <20170329055706.GH29622@ZenIV.linux.org.uk>
 <3399faa9-795e-39db-42f5-7d1e10bbff9c@synopsys.com>
 <20170329202939.GI29622@ZenIV.linux.org.uk>
 <CA+55aFxJ6HnkLzRTwoXRoWMmH4npUmT5S1gSbMges9msXKzuow@mail.gmail.com>
 <20170329210322.GJ29622@ZenIV.linux.org.uk>
 <CA+55aFyEQ_naUW6Q+qVoBA24bgBh1=2H+V54k501uV2pKFv+nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52090 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbdC2XKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Mar 2017 19:10:01 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFyEQ_naUW6Q+qVoBA24bgBh1=2H+V54k501uV2pKFv+nw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Wed, Mar 29, 2017 at 02:24:37PM -0700, Linus Torvalds wrote:

> I think one of the biggest problems with our current uaccess.h mess is
> just how illegible the header files are, and the
> INLINE_COPY_{TO,FROM}_USER thing is not helping.
> 
> I think it would be much better if the header file just had
> 
>  extern unsigned long _copy_from_user(void *, const void __user *,
> unsigned long);
> 
> and nothing else. No unnecessary noise.
> 
> The same goes for things like [__]copy_in_user() - why is that thing
> still inlined? If it was a *macro*, it might be useful due to the
> might_fault() thing giving the caller information, but that's not even
> the case here, so we'd actually be much better off without any of that
> inlining stuff. Do it all in lib/usercopy.c, and move the
> might_fault() in there too.

IMO that's a separate series.  For now I would be bloody happy if we got
	* arch-dependent asm fixes out of the way
	* everything consolidated outside of arch/*
	* arch/*/include/uaccess*.h simplified.

As for __copy_in_user()... I'm not sure we want to keep it in the long run -
drivers/gpu/drm/drm_ioc32.c:390:        if (__copy_in_user(buf, argp, offsetof(drm_buf_desc32_t, agp_start))
drivers/gpu/drm/drm_ioc32.c:399:        if (__copy_in_user(argp, buf, offsetof(drm_buf_desc32_t, agp_start))
drivers/gpu/drm/drm_ioc32.c:475:                        if (__copy_in_user(&to[i], &list[i],
drivers/gpu/drm/drm_ioc32.c:536:                        if (__copy_in_user(&list32[i], &list[i],
fs/compat_ioctl.c:753:  if (__copy_in_user(&tdata->read_write, &udata->read_write, 2 * sizeof(u8)))
fs/compat_ioctl.c:755:  if (__copy_in_user(&tdata->size, &udata->size, 2 * sizeof(u32)))

are all callers out there.  And looking at those callers...  fs/compat_ioctl.c
ones are ridiculous - they translate
struct i2c_smbus_ioctl_data {
        __u8 read_write;
        __u8 command;
        __u32 size;
        union i2c_smbus_data __user *data;
};
into
struct i2c_smbus_ioctl_data32 {
        u8 read_write;
        u8 command;
        u32 size;
        compat_caddr_t data; /* union i2c_smbus_data *data */
};
by doing
	* 2 byte copy (read_write + command -> read_write + command)
	* 8 byte copy (size + data -> size + half of data; WTF 8 and not 4?)
	* 4 byte load (data)
	* 8 byte store (data)
That gem went into the tree in 2003, apparently as a quick hack from
benh, and never had been touched since then.  IMO inlining is very far
down the list of, er, deficiencies there.  If anything, it would be
better off with a single copy_from_user() into a local union, followed by
something like foo.native.data = compat_ptr(foo.compat.data) and
copy_to_user() into tdata.  And that's assuming we won't be better off
with proper ->compat_ioctl() for that sucker - AFAICS, there's a bunch
of I2C_... stuff understood by fs/compat_ioctl.c, all for the sake of
one driver.  I'll look into that tonight...

As for the drm ones, I don't see any reasons for them not to be copy_in_user().
If any of that is the hot path (the last two are in loops), we have worse
problems with STAC/CLAC anyway.

So I'm not sure if __copy_in_user() shouldn't just die.  copy_in_user()
might be a good candidate for move to lib/usercopy.c; I'm somewhat worried
about sparc64, though.  access_ok() is a no-op there, so on the builds
without lockdep where might_fault() is a no-op we get pointless extra
jump for no good reason.  I would like to see comments from davem on that
one...
