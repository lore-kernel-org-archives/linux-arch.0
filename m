From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: VERIFY_READ/WRITE in uaccess.h?
Date: Mon, 11 May 2015 14:42:27 -0700
Message-ID: <CA+55aFzF+Wo7EVSoJSaarbsQCNw5St4JH27t6vxNJivJnBQ0Sg@mail.gmail.com>
References: <554F288C.3000300@nod.at>
	<55511989.2010407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:33356 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbEKVm2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2015 17:42:28 -0400
In-Reply-To: <55511989.2010407@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Richard Weinberger <richard@nod.at>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On Mon, May 11, 2015 at 2:05 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 05/10/2015 02:44 AM, Richard Weinberger wrote:
>> Hi!
>>
>> While cleaning up UML's uaccess code I've noticed that not a single architecture
>> is using VERIFY_READ/WRITE in access_ok().
>> One exception is UML, it uses the access type in one check which is in vain anyways.
>> Also asm-generic/uaccess.h drops the type parameter silently.
>>
>> Why do we still carry it around?
>>
>> Is it because we want it for some future architecture which can benefit
>> from it or just because nobody cared enough to do a tree-wide cleanup?
>> I fear it is the latter... ;)
>>
>
> Or, perhaps, nobody noticed?

Not a future architecture. A historical one.

I think the only architecture that needed the VERIFY_READ/WRITE
distinction was the now-dropped i386, where it was used to decide if
we needed to do the manual COW because the 80386 couldn't do COW
correctly in kernel mode.

That one - for the same reasons - also checked the actual accesses,
not just that the range was in user mode. Exactly because it needed to
pre-COW the pages (even if that was then obviously racy in threaded
environments - in practice it worked, and we tried to support the
fundamentally broken i386 hardware protection model for a long time).

                         Linus
