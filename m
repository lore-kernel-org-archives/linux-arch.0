From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 01/25] asm-generic: Change time_t and clock_t to 64 bit
Date: Tue, 13 May 2014 20:47:56 -0700
Message-ID: <5372E76C.8050908@zytor.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>	<1399971749-4004-1-git-send-email-lftan@altera.com>	<CAAG0J9-ieBNfyRa6kf22TNd_3mg57GYuGHagQ-pPLY41iM3Zyg@mail.gmail.com>	<CAFiDJ5-ez-Brqr8q3=XbODzLtFFU=e4qS12bCPo=5FE1JTNr+A@mail.gmail.com>	<5371EAEB.5030100@imgtec.com> <CAFiDJ58w31gm_z3Y1Q6ZREQPW4F6uVB+vy3X1r_3kLgaEE3O1w@mail.gmail.com> <5371F25E.6020805@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49718 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487AbaENDsf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 23:48:35 -0400
In-Reply-To: <5371F25E.6020805@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>, Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>

On 05/13/2014 03:22 AM, James Hogan wrote:
>> When we export this posix_types.h file for user software, they need to
>> define this config, eg: CONFIG_32BIT_TIME to use 32 bit time. Is this
>> what we want to do?
> 
> Yeh, good point, that won't work.

How about:

#include <asm-generic/types/time32.h>

The asm-generic/types/ directory can be used for all kinds of type
templates, like int-ll64.h and the (now removed) former int-l64.h.

	-hpa
