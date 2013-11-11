From: Joe Perches <joe@perches.com>
Subject: Re: [tip:x86/asm] x86, bitops:  Change bitops to be native operand
 size
Date: Sun, 10 Nov 2013 18:22:50 -0800
Message-ID: <1384136570.4771.5.camel@joe-AO722>
References: <tip-z61ofiwe90xeyb461o72h8ya@git.kernel.org>
	 <1384117768.3081.10.camel@joe-AO722>
	 <5ac67859-a0b2-47f5-bdc2-c2a52b8d6885@email.android.com>
	 <1384123457.3081.33.camel@joe-AO722> <52803BA2.2080908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0141.hostedemail.com ([216.40.44.141]:52166 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751061Ab3KKCWv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 10 Nov 2013 21:22:51 -0500
In-Reply-To: <52803BA2.2080908@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, james.t.kukunas@intel.com, hpa@linux.intel.com, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>

On Sun, 2013-11-10 at 18:06 -0800, H. Peter Anvin wrote:
> On 11/10/2013 02:44 PM, Joe Perches wrote:
> > On Sun, 2013-11-10 at 14:10 -0800, H. Peter Anvin wrote:
> >> Yes, on the generic it is int.
> >> The problem is in part that some architectures have bitop
> >> instructions with specific behavior.
> > I think that all bitop indices should be changed
> > to unsigned (int or long, probably long) for all
> > arches.
> > Is there any impediment to that?
> It is at the very best misleading.  On x86 bit indicies will be signed
> no matter what the data type says,

?

> and having an unsigned data type
> being interpreted as signed seems like really dangerous.
> On the other hand, for the generic implementation unsigned long makes sense.
> We might need a bitindex_t or something like that for it to be clean.

Is there really any reason to introduce bitindex_t?

Perhaps the current x86 bitops asm code is being conflated
with the ideal implementation?
