From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: VERIFY_READ/WRITE in uaccess.h?
Date: Mon, 11 May 2015 14:05:13 -0700
Message-ID: <55511989.2010407@zytor.com>
References: <554F288C.3000300@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39698 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408AbbEKVF2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 May 2015 17:05:28 -0400
In-Reply-To: <554F288C.3000300@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>

On 05/10/2015 02:44 AM, Richard Weinberger wrote:
> Hi!
> 
> While cleaning up UML's uaccess code I've noticed that not a single architecture
> is using VERIFY_READ/WRITE in access_ok().
> One exception is UML, it uses the access type in one check which is in vain anyways.
> Also asm-generic/uaccess.h drops the type parameter silently.
> 
> Why do we still carry it around?
> 
> Is it because we want it for some future architecture which can benefit
> from it or just because nobody cared enough to do a tree-wide cleanup?
> I fear it is the latter... ;)
> 

Or, perhaps, nobody noticed?

	-hpa
