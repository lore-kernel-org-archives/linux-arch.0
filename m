Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S268175AbUIKPqw@vger.kernel.org>
Received: from the-village.bc.nu ([81.2.110.252]:30899 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268179AbUIKPpB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 11 Sep 2004 11:45:01 -0400
Subject: Re: RFC: being more anal about iospace accesses..
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	 <Pine.LNX.4.58.0409102253520.2303@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094913724.21088.70.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Sat, 11 Sep 2004 15:42:05 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Andrew Morton <akpm@osdl.org>, Linux Arch list <linux-arch@vger.kernel.org>, "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Sad, 2004-09-11 at 07:09, Linus Torvalds wrote:
> Anyway, last I remember, AMD machines could do strange things if you did 
> prefecthing on IO space. So this is not relegated to "weird 
> architectures".

Correct: 
Early Athlon cache corrupts for prefetch() of non prefetchable
