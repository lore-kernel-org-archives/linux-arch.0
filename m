Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from b.ns.miles-group.at ([95.130.255.144]:1660 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751455AbaEOItA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 May 2014 04:49:00 -0400
Message-ID: <53747F65.4090203@nod.at>
Date: Thu, 15 May 2014 10:48:37 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Subject: Re: Consolidate tlb.h
References: <1400093999-18703-1-git-send-email-richard@nod.at> <20140515083258.GD30445@twins.programming.kicks-ass.net>
In-Reply-To: <20140515083258.GD30445@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Message-ID: <20140515084837.YkU3M1_IM-SYsE3BDR4uomemAqDyxk7D_6wNVFY2CAE@z>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 15.05.2014 10:32, schrieb Peter Zijlstra:
> On Wed, May 14, 2014 at 08:59:32PM +0200, Richard Weinberger wrote:
>> While staring at an UML TLB bug I've noticed that most archs copy and pasted stuff from each others tlb.h. This patch series combines common stuff into the generic tlb.h.
>> 
> 
> Were you aware of this series:
> 
> http://www.spinics.net/lists/linux-mm/msg37369.html

Nope.

> I've been meaning to refresh and continue with it, but somehow I never get time to actually do it :/
> 
> At the time only s390 still have a relatively trivial problem but all archs were using generic code.
> 

If it helps I can pickup your series and finalize it.
Actually I was abound to consolidate TLB gather implementations too.

Thanks,
//richard
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTdH9lAAoJEPmeIjfg4UaaqowP/0I8COjZRvk1X39E1KibWxIK
epRiDWYgQenfc186ncwZA2wAU4rr1y+e5d7hoF0p6/WvN1svSgbX6A95tDa3/rLY
zu9/zX8TRT5QXU6xsUDzI3zD2t7N44jxX0ysDOHV6ZLOpMnoe8fR8j8Mn54qPd8T
LLmhgxhkp7NvYjv7VFEMP0DXtlPDskRFzzY7NwGks0uu36FPVMHyJIhz+koW7+hL
rzjZs57yO/t3EaGF4UGVRPwt8FyBzgxib3JfFHpr3D35La5lbhVRTu5FHfXeDhgu
Mv9iacyrMMOC0IlMVreC/O9Og2GmMKcC+ICFlvW4sCGKPcN/95rvUapvFKsAAAnw
EQicc86XnPJ8TJATKE9kg0YXB9GDu4hK0kzK09PsQBBO+L0SZstbwCXMfwHyGuoO
LRmsO+mRMtzeZYXEjO7oRvxPBeSm31i3f4wyoN49maLqlcJfrIeh4Bkdi3b3Zgz5
TB0+jaYR0FJVL9KawoB3T/c5XEB3Wu2U5bJ8dtANnfBWMKRo8WfEniIXmOUziYiU
lmP7cewmpc2AiJPG2Cm7g+huenP+j9Y+CzlwOYFIMBy+xrlT31SRp2/cVIclDHmL
A1CU3JFvcbwwLz59okMPdZQbbXsB3sMh4qsmbE/jXFCBUJr4iQUcOaB56weC9x84
lTYhoeqQDIM2h2q/2SnO
=Hk5i
-----END PGP SIGNATURE-----
