Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269360AbUIIG2E@vger.kernel.org>
Received: from canuck.infradead.org ([205.233.218.70]:6663 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S269358AbUIIG2E (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 02:28:04 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
Content-Type: text/plain
Date: Thu, 09 Sep 2004 07:23:23 +0100
Message-Id: <1094711003.15909.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Wed, 2004-09-08 at 15:57 -0700, Linus Torvalds wrote:
>  And while I've tried out a compile on my normal x86 setup and could
> fix all of the gcc-visible things, this may be disruptive enough that
> people object to doing something like this.
> 
> Comments? 

Just do it. It's currently a complete mess -- and it's already in need
of fixing on those non-i386 platforms where write[bwl] had to be
functions anyway. Bringing i386 into line would be great.

-- 
dwmw2
