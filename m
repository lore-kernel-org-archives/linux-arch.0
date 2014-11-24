Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:35031 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaKXSfk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 13:35:40 -0500
MIME-Version: 1.0
In-Reply-To: <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
	<1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
	<15567.1416835858@warthog.procyon.org.uk>
	<CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
Date: Mon, 24 Nov 2014 10:35:39 -0800
Message-ID: <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20141124183539.q8rpwq6NRuftDJ4kPjPQighkGwXasno7IZXz1G6NE7Y@z>

On Mon, Nov 24, 2014 at 10:02 AM, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> If the goal is to catch non-scalar users, the following is shorter:
> #define ACCESS_ONCE(x) (((typeof(x))0) + *(volatile typeof(x) *)&(x))

Me likey. It probably works well in practice, although I think

 - the "(typeof(x))0)" seems unnecessary and wrong. Why not just "0"?
The typeof is not just longer, but it is incorrect for pointer types
(you can add 0 to a pointer, but you cannot add two pointers together)

 - it does mean that the resulting type ends up being upgraded to
"int", for the usual C type reasons.

Note that the "upgraded to 'int'" is true with or without the
"(typeof(x))0". If you add two 'char' values, the addition is still
done in 'int'.

Maybe you *meant* that typeof to fix the second problem, like so:

  (typeof(x)) (0 + *(volatile typeof(x) *)&(x))

Hmm? That casts the result of the addition, not the zero.

             Linus
