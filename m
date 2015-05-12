From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VERIFY_READ/WRITE in uaccess.h?
Date: Mon, 11 May 2015 22:47:19 -0700
Message-ID: <555193E7.30600@zytor.com>
References: <554F288C.3000300@nod.at>	<55511989.2010407@zytor.com> <CA+55aFzF+Wo7EVSoJSaarbsQCNw5St4JH27t6vxNJivJnBQ0Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:43746 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752064AbbELFrh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 May 2015 01:47:37 -0400
In-Reply-To: <CA+55aFzF+Wo7EVSoJSaarbsQCNw5St4JH27t6vxNJivJnBQ0Sg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On 05/11/2015 02:42 PM, Linus Torvalds wrote:
> 
> That one - for the same reasons - also checked the actual accesses,
> not just that the range was in user mode. Exactly because it needed to
> pre-COW the pages (even if that was then obviously racy in threaded
> environments - in practice it worked, and we tried to support the
> fundamentally broken i386 hardware protection model for a long time).
> 

It worked in part because we never supported SMP on i386.

	-hpa
