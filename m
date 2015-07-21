Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39475 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754152AbbGUOGS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jul 2015 10:06:18 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1437459289-26553-1-git-send-email-ysato@users.sourceforge.jp>
References: <1437459289-26553-1-git-send-email-ysato@users.sourceforge.jp> <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Subject: Re: [PATCH v3] asm-generic: {get,put}_user ptr argument evaluate only 1 time
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21798.1437487573.1@warthog.procyon.org.uk>
Date: Tue, 21 Jul 2015 15:06:13 +0100
Message-ID: <21799.1437487573@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150721140613.WQ7VQcNXho9Cb7FzZkB7aTwHb8lNzkcs1wdQCbAT0rY@z>

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

>  #define get_user(x, ptr)					\
>  ({								\
> +	uintptr_t __uip = (uintptr_t)(ptr);			\

const?

>  	might_fault();						\
> -	access_ok(VERIFY_READ, ptr, sizeof(*ptr)) ?		\
> -		__get_user(x, ptr) :				\
> +	access_ok(VERIFY_READ, __uip, sizeof(*ptr)) ?		\
> +		__get_user((x), (__typeof__(*ptr) *)__uip) :	\
>  		-EFAULT;					\
>  })

Would it be better to use void* instead of uintptr_t?

David
