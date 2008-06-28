From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 19/60] microblaze_v4: checksum support
Date: Sun, 29 Jun 2008 00:28:14 +0200
Message-ID: <6e8c2b4453be89dba35e0595c9cfcf0a@kernel.crashing.org>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-2-git-send-email-monstr@seznam.cz> <1214483429-32360-3-git-send-email-monstr@seznam.cz> <1214483429-32360-4-git-send-email-monstr@seznam.cz> <1214483429-32360-5-git-send-email-monstr@seznam.cz> <1214483429-32360-6-git-send-email-monstr@seznam.cz> <1214483429-32360-7-git-send-email-monstr@seznam.cz> <1214483429-32360-8-git-send-email-monstr@seznam.cz> <1214483429-32360-9-git-send-email-monstr@seznam.cz> <1214483429-32360-10-git-send-email-monstr@seznam.cz> <1214483429-32360-11-git-send-email-monstr@seznam.cz> <1214483429-32360-12-git-send-email-monstr@seznam.cz> <1214483429-32360-13-git-send-email-monstr@seznam.cz> <1214483429-32360-14-git-send-email-monstr@seznam.cz> <1214483429-32360-15-git-send-email-monst
 r@seznam.cz> <1214483429-32360-16-git-send-email-monstr@seznam.cz> <1214483429-32360-17-git-send-email-monstr@seznam.cz> <1214483429-32360-18-git-send-email-monstr@seznam.cz> <1214483429-32!
 360-19-git-send-email-monstr@seznam.cz> <1214483429-32360-20-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:55880 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752649AbYF1Wbu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 28 Jun 2008 18:31:50 -0400
In-Reply-To: <1214483429-32360-20-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: hpa@zytor.com, John.Linn@xilinx.com, arnd@arndb.de, drepper@redhat.com, matthew@wil.cx, john.williams@petalogix.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, linuxppc-dev@ozlabs.org, Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com, microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org, will.newton@gmail.com

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
