Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S264919AbUIIORS@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:34218 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264915AbUIIOQe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Sep 2004 10:16:34 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <1094711003.15909.8.camel@localhost.localdomain>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <1094711003.15909.8.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094735643.14640.20.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 09 Sep 2004 14:14:04 +0100
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, "David S. Miller" <davem@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Iau, 2004-09-09 at 07:23, David Woodhouse wrote:
> Just do it. It's currently a complete mess -- and it's already in need
> of fixing on those non-i386 platforms where write[bwl] had to be
> functions anyway. Bringing i386 into line would be great.

I'd say "Just do it - but not in a -rc" 8)
