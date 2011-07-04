From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 2/2] asm-generic: move archictures to common delay.h
Date: Mon, 04 Jul 2011 16:18:08 +0200
Message-ID: <1309789088.4373.26.camel@hcegtvedt.norway.atmel.com>
References: <1309600754-21217-1-git-send-email-jonas@southpole.se>
	 <1309600754-21217-2-git-send-email-jonas@southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:30930 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981Ab1GDOSi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jul 2011 10:18:38 -0400
In-Reply-To: <1309600754-21217-2-git-send-email-jonas@southpole.se>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, lethal@linux-sh.org

On Sat, 2011-07-02 at 11:59 +0200, Jonas Bonn wrote:

Hello Jonas,

Please use the latest email address from MAINTAINERS, I will only have
access to my Atmel account for one more week.

> This patch moves the in-tree architectures that were using the 'generic'
> delay.h over to using the header file in asm-generic.
> 
> This is not done using the generic-y mechanism as none of these arch's
> have started using that mechanism yet.  This is a trivial change to make
> later when the arch begins using generic-y.
> 
> Note the subtle change to the avr32 and SH architectures where the argument
> to __const_udelay was previously using the rounded down constant value
> instead of the rounded up value.

My guess is that the AVR32 implementation is copied from x86, hence the
Copyright to Linus. Thanks for cleaning up.

> Signed-off-by: Jonas Bonn <jonas@southpole.se>
>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp>

-- 
Hans-Christian Egtvedt
