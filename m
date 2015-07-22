Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42151 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbbGVWYc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jul 2015 18:24:32 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1437576756-28388-1-git-send-email-ysato@users.sourceforge.jp>
References: <1437576756-28388-1-git-send-email-ysato@users.sourceforge.jp> <1437023722-7432-1-git-send-email-ysato@users.sourceforge.jp>
Subject: Re: [PATCH v4] asm-generic: {get,put}_user ptr argument evaluate only 1 time
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15847.1437603868.1@warthog.procyon.org.uk>
Date: Wed, 22 Jul 2015 23:24:28 +0100
Message-ID: <15848.1437603868@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: dhowells@redhat.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20150722222428.7J7hBTy6OUtmxSS0Z-8iVEqGUCIVPn0VjvQ60RTpN5o@z>

Yoshinori Sato <ysato@users.sourceforge.jp> wrote:

>  #define put_user(x, ptr)					\
>  ({								\
> +	const void *__p = (ptr);				\

Not const here, though...

David
