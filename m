Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S269340AbUIIBV7@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:37327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269297AbUIIBTZ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 8 Sep 2004 21:19:25 -0400
Date: Wed, 8 Sep 2004 18:19:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: RFC: being more anal about iospace accesses..
In-Reply-To: <20040908160737.7c1dfb5a.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0409081611550.5912@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
 <20040908160737.7c1dfb5a.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "David S. Miller" <davem@redhat.com>
Cc: viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org, linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-ID: <linux-arch.vger.kernel.org>



On Wed, 8 Sep 2004, David S. Miller wrote:
> 
> I wish we could make it fail with the compiler too somehow, that
> way people other than us sparse geeks would see and fix this stuff
> up.

I don't want to break a stable release too much. As-is, the _code_ 
generated should be 100% the same, even if gcc complains. So afaik, my 
patch is very safe indeed, which I like.

So it can cause gcc to complain for non-converted code ("xxx makes pointer
from integer without a cast"), but since any such code ended up converting
it to a pointer _with_ a cast anyway, I really believe code-generation is 
safe.

In contrast, to actually make gcc complain about the types of these things 
would not only be disruptive, it would require some _major_ change to how 
we do things. Right now we assume that "ioremap()" generates an 
offsettable "thing", and that really means that it must be of one of three 
types:
 - "unsigned long" (obviously type-unsafe, and would be totally pointless)
 - "void *" or "char *" (this is basically what we used to have).

Neither is in any way type-safe, nor can we make gcc complain without
breaking the "offsettable" requirement. The only way to make gcc complain
loudly would be to use something that can't be converted to anything else
(eg a "struct iomem_opaque { unsigned long cookie; }") but that would
break every single user out there, and require us to do the off-setting at
a much lower level (passing along both cookie and offset separately all
the way down the callchain - horribly bad in many ways).

In contrast, using sparse means that we can still generate exactly the
same code, have all old code still work (albeit with the occasional
potential warning from gcc) _and_ have a fairly easy way to check.

In fact, even modern external modules that work with 2.6.x kernels are 
quite checkable. I just verified that using "make C=1" works perfectly 
fine on an external module tree). So yes, it's just for "us sparse geeks", 
but sparse is to easy to set up and use that I don't think that's a huge 
downside:

	make ; make install ; "use 'C=1' when compiling the kernel"

it can't get much simpler than that.

(I think the biggest problem is _finding_ sparse, but just googling for 
"linux sparse tar-ball" shows at least two half-way relevant hits in the 
top five, so..)

		Linus
