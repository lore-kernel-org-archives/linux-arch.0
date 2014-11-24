Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:53350 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbaKXTHL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 14:07:11 -0500
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Mon, 24 Nov 2014 19:07:09 -0000
Message-ID: <547381D7.2070404@de.ibm.com>
Date: Mon, 24 Nov 2014 20:07:03 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
In-Reply-To: <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20141124190703.QLuUFxFMDwSBXva-JDa5YjvovBQ8RRK9L28Ja3dyc8k@z>

Am 24.11.2014 um 19:35 schrieb Linus Torvalds:
> On Mon, Nov 24, 2014 at 10:02 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> If the goal is to catch non-scalar users, the following is shorter:
>> #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))
> 
> Me likey. It probably works well in practice, although I think
> 
>  - the "(typeof(x))0)" seems unnecessary and wrong. Why not just "0"?
> The typeof is not just longer, but it is incorrect for pointer types
> (you can add 0 to a pointer, but you cannot add two pointers together)
> 
>  - it does mean that the resulting type ends up being upgraded to
> "int", for the usual C type reasons.
> 
> Note that the "upgraded to 'int'" is true with or without the
> "(typeof(x))0". If you add two 'char' values, the addition is still
> done in 'int'.
> 
> Maybe you *meant* that typeof to fix the second problem, like so:
> 
>   (typeof(x)) (0 + *(volatile typeof(x) *)&(x))
> 
> Hmm? That casts the result of the addition, not the zero.

Looks really nice, but does not work with ACCESS_ONCE is on the left-hand side:


include/linux/rculist.h: In function 'hlist_add_before_rcu':
./arch/x86/include/asm/barrier.h:127:18: error: lvalue required as left operand of assignment
  ACCESS_ONCE(*p) = (v);      \

Alexei's variant is also broken:

include/linux/cgroup.h: In function 'task_css':
include/linux/compiler.h:381:40: error: invalid operands to binary + (have 'struct css_set *' and 'struct css_set * volatile')
 #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

Anyone with a new propopal? ;-)                                        ^

Christian

