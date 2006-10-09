Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41094 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751781AbWJIK1G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Oct 2006 06:27:06 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Date: Mon, 9 Oct 2006 12:26:59 +0200
References: <Pine.LNX.4.61.0610062250090.30417@yvahk01.tjqt.qr> <Pine.LNX.4.61.0610091032470.24127@yvahk01.tjqt.qr> <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
In-Reply-To: <EE65413A-0E34-40DA-9037-72423C18CD0C@mac.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610091227.02310.arnd.bergmann@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, David Howells <dhowells@redhat.com>, Matthew Wilcox <matthew@wil.cx>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 09 October 2006 11:51, Kyle Moffett wrote:
>    #if defined(CONFIG_ARCH_HAS_64BIT_WORD)
>    typedef unsigned long  __u64;
>    typedef   signed long  __s64;
>    #elif defined(__GNUC__)
>    __extension__ typedef unsigned long long __u64;
>    __extension__ typedef   signed long long __s64;
>    #endif
> 

Well, some architectures currently expext __u64/__s64 to be
long long even with 64 bits. Changing that will likely cause
a number of new compiler warnings about conversion between
these. Of course it would be nice to clean these up, since
it's already a pain to printk() a variable of type u64.

More importantly, your code has the problem that it relies
on a CONFIG_* symbol, which will break when user space includes
the file, because that does not have config.h.

	Arnd <><
