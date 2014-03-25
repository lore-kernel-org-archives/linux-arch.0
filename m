From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] LLVMLinux: Remove warning about returning an uninitialized variable
Date: Tue, 25 Mar 2014 18:16:10 +0100
Message-ID: <201403251816.10589.arnd@arndb.de>
References: <1395506558.2143.18.camel@dabdike.int.hansenpartnership.com> <1395640404-27958-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.130]:60979 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754010AbaCYRQr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Mar 2014 13:16:47 -0400
In-Reply-To: <1395640404-27958-1-git-send-email-behanw@converseincode.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: behanw@converseincode.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On Monday 24 March 2014, behanw@converseincode.com wrote:
> 
> From: Behan Webster <behanw@converseincode.com>
> 
> Fix uninitialized return code in default case in cmpxchg-local.h
> 
> This patch fixes the code to prevent an uninitialized return value that is detected
> when compiling with clang. The bug produces numerous warnings when compiling the
> Linux kernel with clang.
> 
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Signed-off-by: Mark Charlebois <charlebm@gmail.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
