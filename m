Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:59110 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbaKXUpg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 15:45:36 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Mon, 24 Nov 2014 20:45:34 -0000
Message-ID: <547398E8.9070905@de.ibm.com>
Date: Mon, 24 Nov 2014 21:45:28 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
References: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
In-Reply-To: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20141124204528.FeS097XqMw6edafVS-bRYOaNVX-JjRP5l2gVleUlI0k@z>

Am 24.11.2014 um 21:29 schrieb Alexei Starovoitov:
> On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>> Anyone with a new propopal? ;-)                                        ^
> 
> one more proposal :)
> #define __ACCESS_ONCE(x) ({ typeof(x) __var = 0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))

This seems to work. I only had to add an __always_unused to __var.


> 
> works as lvalue...
> the basic idea is the same:
> constant zero can be used to initialize any scalar
> (including pointers), but unions and structs will fail to compile as:
> "error: invalid initializer"
> 
> If I'm reading pr58145 gcc bug report correctly, it
> miscompiles only structs, so we can let ACCESS_ONCE
> to work on unions. Then the following will rejects structs only:
> #define __ACCESS_ONCE(x) ({ (typeof(x))0; (volatile typeof(x) *)&(x); })
> #define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
> --
> To unsubscribe from this list: send the line "unsubscribe linux-s390" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

