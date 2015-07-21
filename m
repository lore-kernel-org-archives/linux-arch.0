From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Tue, 21 Jul 2015 15:06:13 +0100
Message-ID: <21799.1437487573@warthog.procyon.org.uk>
References: <1437459289-26553-1-git-send-email-ysato@users.sourceforge.jp> <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437459289-26553-1-git-send-email-ysato@users.sourceforge.jp>
Content-ID: <21798.1437487573.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
