From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] asm-generic: uaccess: allow arch to over-ride __get_user_fn()
Date: Tue, 20 Nov 2012 15:55:37 +0000
Message-ID: <201211201555.37272.arnd@arndb.de>
References: <1353422297-29079-1-git-send-email-vgupta@synopsys.com> <1353422297-29079-2-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58104 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751803Ab2KTPzm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 20 Nov 2012 10:55:42 -0500
In-Reply-To: <1353422297-29079-2-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet.Gupta1@synopsys.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday 20 November 2012, Vineet.Gupta1@synopsys.com wrote:
> +#ifndef __get_user_fn
>  static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
>  {
>         size = __copy_from_user(x, ptr, size);
>         return size ? -EFAULT : size;
>  }
>  
> +#define __get_user_fn(sz, u, k)        __get_user_fn(sz, u, k)
> +
> +#endif

This is ok as well. The idea with the asm-generic __copy_from_user()
implementation is to separate out the cases where you have just
a few bytes and handle them efficiently inline. If you don't want
to do that for some reason, overriding __get_user_fn works
as well. The resulting object code should be the same.

	Arnd
