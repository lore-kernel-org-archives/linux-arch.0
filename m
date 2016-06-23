From: Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] kasan: account for new sections when instrumenting globals
Date: Thu, 23 Jun 2016 14:40:22 +0200
Message-ID: <CACT4Y+Zd25zQFXWL7tGFxt_-s-kM99K7SCgwyFxZuh2HPiW7Cw@mail.gmail.com>
References: <1466615238-57411-1-git-send-email-dvyukov@google.com>
 <CAPAsAGwxXqyxAjj4o6q=1Ddz4h1PQrv5VcP=DrUg2NvK1or-=g@mail.gmail.com> <CAPAsAGx9gf-3K35TCGNjE=suW9_aDY0+a+0L9xtjtBHOYoiysg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34986 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcFWMkn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 23 Jun 2016 08:40:43 -0400
Received: by mail-lf0-f41.google.com with SMTP id l188so93842277lfe.2
        for <linux-arch@vger.kernel.org>; Thu, 23 Jun 2016 05:40:42 -0700 (PDT)
In-Reply-To: <CAPAsAGx9gf-3K35TCGNjE=suW9_aDY0+a+0L9xtjtBHOYoiysg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, kasan-dev <kasan-dev@googlegroups.com>, Alexander Potapenko <glider@google.com>

On Thu, Jun 23, 2016 at 1:50 PM, Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> 2016-06-23 14:49 GMT+03:00 Andrey Ryabinin <ryabinin.a.a@gmail.com>:
>
>> Frankly, I don't understand why .text.[exit,startup] sections has any relation
>> to the bug you described, but maybe I just don't now linker
>
> ... scripting well enough to understand what's going on here.


I noticed that these 3 new sections are what's different between
kernel that works and kernel that does not work. So I decided to
account all of them
Checked now, it works only with .dtors.
Is it preferable to add only .dtors or all sections?
