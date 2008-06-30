From: =?us-ascii?Q?Michal=20Simek?= <Monstr@seznam.cz>
Subject: =?us-ascii?Q?Re=3A=20=5BPATCH=2019=2F60=5D=20microblaze=5Fv4=3A=20checksum=20support?=
Date: Mon, 30 Jun 2008 09:18:10 +0200 (CEST)
Message-ID: <4117.6640-711-1819091302-1214810290@seznam.cz>
References: <6e8c2b4453be89dba35e0595c9cfcf0a@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii";
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mxl.seznam.cz ([77.75.72.44]:53194 "EHLO mxl.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884AbYF3Hgl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Jun 2008 03:36:41 -0400
In-Reply-To: <6e8c2b4453be89dba35e0595c9cfcf0a@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?us-ascii?Q?Segher=20Boessenkool?= <segher@kernel.crashing.org>
Cc: hpa@zytor.com, John.Linn@xilinx.com, arnd@arndb.de, drepper@redhat.com, matthew@wil.cx, john.williams@petalogix.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linuxppc-dev@ozlabs.org, =?us-ascii?Q?Michal=20Simek?= <monstr@monstr.eu>, vapier.adi@gmail.com, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, will.newton@gmail.com

Hi Segher,

you find bug because there is microblaze asm code in generic folder. 
Big thanks. I'll fix it and I'll look at parameters too.

Michal

> +static inline unsigned int
> +csum_tcpudp_nofold(unsigned long saddr, unsigned long daddr, unsigned 
> short len,
> +		unsigned short proto, unsigned int sum)
> +{
> +	__asm__("add %0, %4, %1\n\t"
> +		"addc %0, %4, %2\n\t"
> +		"addc %0, %4, %3\n\t"
> +		"addc %0, %4, r0\n\t"
> +		: "=d" (sum)
> +		: "d" (saddr), "d" (daddr), "d" (len + proto),
> +		"0"(sum));

"sum" should use an earlyclobber, i.e.  "=&d"(sum)  , since some
inputs are used after %0 is first written to.

Also, you can use "+" instead of "=" to say the argument is both
input and output, and get rid of %4, if you like.


Segher
