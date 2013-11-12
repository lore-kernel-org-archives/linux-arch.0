From: Joe Perches <joe@perches.com>
Subject: Re: [tip:x86/asm] x86, bitops: Change bitops to be native operand
 size
Date: Mon, 11 Nov 2013 20:08:28 -0800
Message-ID: <1384229308.4771.35.camel@joe-AO722>
References: <tip-z61ofiwe90xeyb461o72h8ya@git.kernel.org>
	 <1384117768.3081.10.camel@joe-AO722>
	 <5ac67859-a0b2-47f5-bdc2-c2a52b8d6885@email.android.com>
	 <1384123457.3081.33.camel@joe-AO722> <52803BA2.2080908@zytor.com>
	 <1384136570.4771.5.camel@joe-AO722> <5281698F.9080808@linux.intel.com>
	 <1384224883.4771.28.camel@joe-AO722>
	 <CA+55aFxsNB0BVg-fdzsu_jkPLpiba1rgTcrUOe7W2tN-mHTnBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0074.hostedemail.com ([216.40.44.74]:54379 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750991Ab3KLEIZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Nov 2013 23:08:25 -0500
In-Reply-To: <CA+55aFxsNB0BVg-fdzsu_jkPLpiba1rgTcrUOe7W2tN-mHTnBg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, james.t.kukunas@intel.com, David Miller <davem@davemloft.net>

On Tue, 2013-11-12 at 12:15 +0900, Linus Torvalds wrote:
> Talking about "ideal implementation" is also singularly stupid.

I just want the various arch implementations to match
the docs.  I know that's stupid.

Maybe if you really don't want to discuss things, you
should fix the documentation.

Documentation/atomic_ops.txt
