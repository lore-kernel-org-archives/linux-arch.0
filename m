From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v4] asm-generic: {get,put}_user ptr argument evaluate only 1 time
Date: Wed, 22 Jul 2015 23:24:28 +0100
Message-ID: <15848.1437603868@warthog.procyon.org.uk>
References: <1437576756-28388-1-git-send-email-ysato@users.sourceforge.jp> <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437576756-28388-1-git-send-email-ysato@users.sourceforge.jp>
Content-ID: <15847.1437603868.1@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

>  #define put_user(x, ptr)					\
>  ({								\
> +	const void *__p = (ptr);				\

Not const here, though...

David
