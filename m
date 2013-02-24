From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [git pull] signal.git
Date: Sun, 24 Feb 2013 23:04:50 +0000
Message-ID: <1361747090.16652.3.camel@dabdike.int.hansenpartnership.com>
References: <20130220225214.GJ4503@ZenIV.linux.org.uk>
	 <CA+55aFwx-O4Q=1gKgv=cyG8ObzUyPVh9Ctmuh-DX_DE9rumU5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:47260 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751015Ab3BXXE4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 24 Feb 2013 18:04:56 -0500
In-Reply-To: <CA+55aFwx-O4Q=1gKgv=cyG8ObzUyPVh9Ctmuh-DX_DE9rumU5g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Sat, 2013-02-23 at 18:56 -0800, Linus Torvalds wrote:
> Ok, in the meantime I had merged the parisc and powerpc trees, which
> had their own fixes in this area: powerpc added the transactional
> memory support for power8 (which impacted signal save/restore), and
> parisc had some fixes to the routines you then removed in favor of
> generic ones.

I compiled and booted it on parisc.  Everything seems to be OK, at least
on our pa8800 systems.

James
