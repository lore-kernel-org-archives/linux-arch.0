Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:51670 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3AROaV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Jan 2013 09:30:21 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 07/76] ARC: [optim] uaccess __{get,put}_user() optimised
Date: Fri, 18 Jan 2013 14:30:15 +0000
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-8-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1358511930-7424-8-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201301181430.16142.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20130118143015.CSucnZy_D5Tu_CUyTFCzjf2tQmtjrZHRP1BQ8BjU4XI@z>

On Friday 18 January 2013, Vineet Gupta wrote:
> Override asm-generic implementations. We basically gain on 2 fronts
> 
> * checks for alignment no longer needed as we are only doing "unit"
>   sized copies.
> 
>   (Careful observer could argue that While the kernel buffers are aligned,
>    the user buffer in theory might not be - however in that case the
>    user space is already broken when it tries to deref a hword/word
>    straddling word boundary - so we are not making it any worse).
> 
> * __copy_{to,from}_user( ) returns bytes that couldn't be copied,
>   whereas get_user() returns 0 for success or -EFAULT (not size). Thus
>   the code to do leftover bytes calculation can be avoided as well.

Interesting. I had thought that the compiler would be able to simplify
the calculation of the return value inline, but of course it cannot
because it has to be done inside the asm fixup.

> The savings were significant: ~17k of code.
> 
> bloat-o-meter vmlinux_uaccess_pre vmlinux_uaccess_post
> add/remove: 0/4 grow/shrink: 8/118 up/down: 1262/-18758 (-17496)
>                                                         ^^^^^^^^^
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
