From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Subject: Re: [PATCH] kasan: account for new sections when instrumenting globals
Date: Thu, 23 Jun 2016 14:50:40 +0300
Message-ID: <CAPAsAGx9gf-3K35TCGNjE=suW9_aDY0+a+0L9xtjtBHOYoiysg@mail.gmail.com>
References: <1466615238-57411-1-git-send-email-dvyukov@google.com> <CAPAsAGwxXqyxAjj4o6q=1Ddz4h1PQrv5VcP=DrUg2NvK1or-=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35841 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbcFWLun (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 07:50:43 -0400
Received: by mail-lf0-f43.google.com with SMTP id q132so93858922lfe.3
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2016 04:50:42 -0700 (PDT)
In-Reply-To: <CAPAsAGwxXqyxAjj4o6q=1Ddz4h1PQrv5VcP=DrUg2NvK1or-=g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>

2016-06-23 14:49 GMT+03:00 Andrey Ryabinin <ryabinin.a.a@gmail.com>:

> Frankly, I don't understand why .text.[exit,startup] sections has any relation
> to the bug you described, but maybe I just don't now linker

... scripting well enough to understand what's going on here.
