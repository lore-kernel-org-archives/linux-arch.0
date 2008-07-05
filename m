Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:8169 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133AbYGEStv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jul 2008 14:49:51 -0400
Date: Sat, 5 Jul 2008 19:53:46 +0200
From: Alexander van Heukelum <heukelum@mailshack.com>
Subject: [PATCH] x86: fix description of __fls(): __fls(0) is undefined
Message-ID: <20080705175345.GA7698@mailshack.com>
References: <20080315172913.GA21648@mailshack.com> <20080315173236.GC21659@mailshack.com> <1215276997.7167.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1215276997.7167.12.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Ricardo M. Correia" <Ricardo.M.Correia@Sun.COM>, Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, LKML <linux-kernel@vger.kernel.org>, heukelum@fastmail.fm
Message-ID: <20080705175346.ZPXS1SsPOegcWeKefie_5hrECSUdb-OHYNAamSNCGjo@z>

Ricardo M. Correia spotted that the use of __fls() in fls64() did
not seem to make sense. In fact fls64()'s implementation is fine,
but the description of __fls() was wrong. Fix that.

Reported-by: "Ricardo M. Correia" <Ricardo.M.Correia@Sun.COM>
Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>

---

On Sat, Jul 05, 2008 at 05:56:37PM +0100, Ricardo M. Correia wrote:
> Hi,
> 
> I have a question about fls64() which I hope you or someone else could
> clarify, please see below.
> 
> ﻿On Sáb, 2008-03-15 at 18:32 +0100, Alexander van Heukelum wrote: 
> > +#elif BITS_PER_LONG == 64
> > +static inline int fls64(__u64 x)
> > +{
> > +	if (x == 0)
> > +		return 0;
> > +	return __fls(x) + 1;
> > +}
> 
> It seems fls64() is implemented on top of __fls(), however the __fls()
> implementation on the x86-64 architecture states that the result is
> undefined if the argument does not have any zero bits.

You have found a bug. It's not in fls64, though, but a copy/paste
one in the comment preceding __fls(). __fls() gives an undefined
result if there are no _set_ bits: only __fls(0) gives an undefined
result.

The inconsistency is well-spotted, though, thanks.

Patch is against current -tip.

Greetings,
    Alexander

> So if I understand correctly, the statement "fls64(~0ULL)" would return
> an undefined result on x64-64 instead of 64 as one would expect.
> 
> Wouldn't it make sense to check for ~0ULL in fls64()?
> 
> Thanks,
> Ricardo

---

diff --git a/include/asm-x86/bitops.h b/include/asm-x86/bitops.h
index 96b1829..cfb2b64 100644
--- a/include/asm-x86/bitops.h
+++ b/include/asm-x86/bitops.h
@@ -356,7 +356,7 @@ static inline unsigned long ffz(unsigned long word)
  * __fls: find last set bit in word
  * @word: The word to search
  *
- * Undefined if no zero exists, so code should check against ~0UL first.
+ * Undefined if no set bit exists, so code should check against 0 first.
  */
 static inline unsigned long __fls(unsigned long word)
 {
