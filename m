From: Richard Weinberger <richard@nod.at>
Subject: Re: VERIFY_READ/WRITE in uaccess.h?
Date: Mon, 11 May 2015 23:26:49 +0200
Message-ID: <55511E99.5070806@nod.at>
References: <554F288C.3000300@nod.at> <55511989.2010407@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65276 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbbEKV0y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 May 2015 17:26:54 -0400
In-Reply-To: <55511989.2010407@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Linux-Arch <linux-arch@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>

Am 11.05.2015 um 23:05 schrieb H. Peter Anvin:
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

Also possible.

While we are at it, access_ok() is IMHO a horrible name. Historic?
Today it is used to find out whether an address is in an
architecture defined range and therefore valid.
Maybe valid_address() would be a better name...

Thanks,
//richard
