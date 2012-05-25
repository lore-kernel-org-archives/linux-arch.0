From: David Miller <davem@davemloft.net>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 19:41:25 -0400 (EDT)
Message-ID: <20120525.194125.1593753424815090718.davem@davemloft.net>
References: <CA+55aFwNN0vBukJkEbsHNUGz7daJZ4gksCNV=Qw6j-XfcZ2HTA@mail.gmail.com>
	<20120525.191407.1171512018515372695.davem@davemloft.net>
	<CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:53903 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab2EYXla convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:41:30 -0400
In-Reply-To: <CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

=46rom: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 May 2012 16:37:40 -0700

> On Fri, May 25, 2012 at 4:14 PM, David Miller <davem@davemloft.net> w=
rote:
>>
>> I suppose then I'd need to make BE's has_zero() a macro instead of a
>> function. =A0Either that or we pass a pointer to this opaque typedef
>> thing.
>=20
> Gcc is *usually* pretty good about optimizing small structures on the
> stack, even if you pass a pointer (if the pointer then always gets
> dereferenced within that function). So I think you could try the
> "pointer to opaque thing" approach and see.
>=20
> But yeah, the macro approach obviously puts much less reliance on the
> optimizer getting things right, so it might be the way to go if it
> turns out that gcc screws up code generation.

I'm playing around with this now, I should have something for you
to look at in the next few hours.
