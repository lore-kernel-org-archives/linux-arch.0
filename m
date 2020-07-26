From: Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH] io: Fix return type of _inb and _inl
Date: Sun, 26 Jul 2020 21:53:25 +0900
Message-ID: <20200726125325.GC80756@lianli.shorne-pla.net>
References: <20200726031154.1012044-1-shorne@gmail.com>
 <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGZMxd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 26 Jul 2020 08:53:33 -0400
Content-Disposition: inline
In-Reply-To: <CAHp75VciC+gqkCZ9voNKHU3hrtiOVzeWBu9_YEagpCGdTME2yg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Wei Xu <xuwei5@hisilicon.com>, John Garry <john.garry@huawei.com>, Linux-Arch <linux-arch@vger.kernel.org>

On Sun, Jul 26, 2020 at 12:00:37PM +0300, Andy Shevchenko wrote:
> On Sun, Jul 26, 2020 at 6:14 AM Stafford Horne <shorne@gmail.com> wrote:
> >
> > The return type of functions _inb, _inw and _inl are all u16 which looks
> > wrong.  This patch makes them u8, u16 and u32 respectively.
> >
> > The original commit text for these does not indicate that these should
> > be all forced to u16.
> 
> Is it in alight with all architectures? that support this interface natively?
> 
> (Return value is arch-dependent AFAIU, so it might actually return
> 16-bit for byte read, but I agree that this is weird for 32-bit value.
> I think you have elaborate more in the commit message)

Well, this is the generic io code,  at least these api's appear to not be different
for each architecture.  The output read by the architecture dependant code i.e.
__raw_readb() below is getting is placed into a u8.  So I think the output of
the function will be u8.

static inline u8 _inb(unsigned long addr)
{
	u8 val;

	__io_pbr();
	val = __raw_readb(PCI_IOBASE + addr);
	__io_par(val);
	return val;
}

I can expand the commit text, but I would like to get some comments from the
original author to confirm if this is an issue.

-Stafford
