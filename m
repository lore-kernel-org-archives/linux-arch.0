From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] remove bogus CLOCK_TICK_RATE definitions
Date: Thu, 14 May 2009 01:12:59 +0200
Message-ID: <200905140113.00018.arnd@arndb.de>
References: <200905131548.14883.arnd@arndb.de> <18955.20578.972820.752249@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:62870 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761842AbZEMXNG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 May 2009 19:13:06 -0400
In-Reply-To: <18955.20578.972820.752249@cargo.ozlabs.ibm.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Thursday 14 May 2009, Paul Mackerras wrote:
> Arnd Bergmann writes:
> 
> > PowerPC actually has a number of different time base values
> > per architecture, but maybe 1024000 is a common divisor for
> > all of them.
> 
> It was more that 1024000 is a multiple of all the common HZ values.

I guess in that case powerpc falls into the same category
as ia64, i.e. it makes up a value to keep ACT_HZ from being
harmful, rather than using ACT_HZ for something helpful.

We should consequently drop the powerpc definition along
with the other bogus ones. This will also help the theoretical
CONFIG_HZ=300 case.

	Arnd <><
