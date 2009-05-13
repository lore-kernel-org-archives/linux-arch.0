From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC] remove bogus CLOCK_TICK_RATE definitions
Date: Thu, 14 May 2009 08:57:38 +1000
Message-ID: <18955.20578.972820.752249@cargo.ozlabs.ibm.com>
References: <200905131548.14883.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.10.76.25]:39358 "EHLO bilbo.ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761909AbZEMW5p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 May 2009 18:57:45 -0400
In-Reply-To: <200905131548.14883.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, akpm@linux-foundation.org, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>

Arnd Bergmann writes:

> PowerPC actually has a number of different time base values
> per architecture, but maybe 1024000 is a common divisor for
> all of them.

It was more that 1024000 is a multiple of all the common HZ values.

Paul.
