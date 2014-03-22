From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] LLVMLinux: Remove warning about returning an uninitialized variable
Date: Sat, 22 Mar 2014 11:01:16 +0100
Message-ID: <201403221101.16961.arnd@arndb.de>
References: <1395470329-15065-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:55503 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaCVKBV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Mar 2014 06:01:21 -0400
In-Reply-To: <1395470329-15065-1-git-send-email-behanw@converseincode.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: behanw@converseincode.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On Saturday 22 March 2014, behanw@converseincode.com wrote:
> diff --git a/include/asm-generic/cmpxchg-local.h b/include/asm-generic/cmpxchg-local.h
> index d8d4c89..4c41bb8 100644
> --- a/include/asm-generic/cmpxchg-local.h
> +++ b/include/asm-generic/cmpxchg-local.h
> @@ -41,6 +41,7 @@ static inline unsigned long __cmpxchg_local_generic(volatile void *ptr,
>                 break;
>         default:
>                 wrong_size_cmpxchg(ptr);
> +               prev = 0;
>         }
>         raw_local_irq_restore(flags);
>         return prev;


How about using __unreachable() instead to annotate the fact that you won't
get here?

	Arnd
