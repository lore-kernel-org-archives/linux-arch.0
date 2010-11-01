From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH 1/6] avr32: missed _TIF_NOTIFY_RESUME on one of
 do_notify_resume callers
Date: Mon, 01 Nov 2010 08:55:57 +0100
Message-ID: <1288598157.2843.9.camel@hcegtvedt>
References: <E1P0QNe-0008Rr-Vf@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:38321 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753032Ab0KAITR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Nov 2010 04:19:17 -0400
In-Reply-To: <E1P0QNe-0008Rr-Vf@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 2010-09-28 at 03:57 +0100, Al Viro wrote: 
> we need that not just on syscall returns but on irq ones as well...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

-- 
Hans-Christian Egtvedt
