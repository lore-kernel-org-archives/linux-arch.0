From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: Fwd: FW: [PATCH 18/31] nds32: Library functions
Date: Sat, 18 Nov 2017 02:44:36 +0000
Message-ID: <20171118024436.GR21978@ZenIV.linux.org.uk>
References: <cover.1510118606.git.green.hu@gmail.com>
 <ea57a25c0aceab45d36951fed44cfbecfe1540b8.1510118606.git.green.hu@gmail.com>
 <20171109004020.GX21978@ZenIV.linux.org.uk>
 <E26F4CF8B7DDDB4383A6C2D78D5C3CD56B497559@ATCPCS16.andestech.com>
 <CAJsyPhx+tRHWrvJg4Dr4QEEHtOy8jXAU2aP2=hHhmTmG3FsO9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:42868 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937367AbdKRCor (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Nov 2017 21:44:47 -0500
Content-Disposition: inline
In-Reply-To: <CAJsyPhx+tRHWrvJg4Dr4QEEHtOy8jXAU2aP2=hHhmTmG3FsO9A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vincent Chen <deanbo422@gmail.com>
Cc: viro@ftp.linux.org.uk, greentime@andestech.com, Green Hu <green.hu@gmail.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, vincentc@andestech.com

On Tue, Nov 14, 2017 at 12:47:04PM +0800, Vincent Chen wrote:

> Thanks
> So, I should keep the area that we've copied into instead of zeroing
> the area even if unpredicted exception is happened. Right?

Yes.  Here's what's required: if raw_copy_{from,to}_user(from, to, size)
returns n, we want
	* 0 <= n <= size
	* no bytes outside of to[0 .. size - n - 1] modified
	* all bytes in that range replaced with corresponding bytes of range
from[0 .. size - n - 1]
	* non-zero return values should happen only when some loads (in case
of raw_copy_from_user()) or stores (in case of raw_copy_to_user()) had failed.
If everything could have been read and written, we must copy everything.
	* return value should be equal to size only if no load or no store
had been possible.  In all other cases you need to copy at least something.
You don't have to squeeze all bytes that can be copied (you can, of course,
but it's not required).
	* you should not assume that failing load guarantees that subsequent
loads further into the same page will keep failing; normally they will, but
relying upon that is asking for trouble.  Several architectures had bugs
of that sort, with varying amounts of nastiness happening when e.g. write(2)
raced with mprotect(2) from another thread...

For almost any architecture these should be more or less parallel to memcpy();
the only exception I know of is the situation when cross-address-space copy
has timing very different from that for normal load+store.  s390 is that
way - there's considerable overhead of setting such copying, and you really
want it done in bigger chunks than would be optimal for memcpy().  uml is
similar.  However, generally it's memcpy tweaked to deal with exceptions.
