From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [patches] avr32 signal fixes
Date: Fri, 08 Oct 2010 14:40:39 +0200
Message-ID: <1286541639.2874.19.camel@hcegtvedt>
References: <E1P0QNV-0008RZ-1H@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:2223 "EHLO sjogate2.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751419Ab0JHN3y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 8 Oct 2010 09:29:54 -0400
In-Reply-To: <E1P0QNV-0008RZ-1H@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2010-09-28 at 03:57 +0100, Al Viro wrote:

Hi Al,

> 	Most of that stuff is quite obvious; the interesting
> part is #6; there I'd taken a large chunk out of the asm glue
> and hopefully sanitized it into something that just might
> work correctly wrt syscall restarts.

Thanks for this patch series. I'm currently a bit busy on something
related, but hope to give your patches a go next week. I could not spot
anything immediate by browsing the patches.

-- 
Hans-Christian Egtvedt
