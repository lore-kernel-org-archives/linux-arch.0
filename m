From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 0/8] Two-phase seccomp and x86 tracing changes
Date: Mon, 28 Jul 2014 16:29:31 -0700
Message-ID: <CAGXu5jKJOrtjY9JsCBUvUbj_y4Hv+AeMEmGwWZZ18FmiZmAbbQ@mail.gmail.com>
References: <cover.1405992946.git.luto@amacapital.net>
	<CAGXu5jJ93-vto9voMENc4jX5itcd_Rm5AZjeChF57fpMYnWocA@mail.gmail.com>
	<CALCETrVwqDeRbFOw=k_OhQZ4V6Pn5v3t8ODw75UuE7HKPFz=Sw@mail.gmail.com>
	<53D68F91.4000106@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:32946 "EHLO
	mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbaG1X3c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 28 Jul 2014 19:29:32 -0400
Received: by mail-oi0-f51.google.com with SMTP id g201so6786232oib.10
        for <linux-arch@vger.kernel.org>; Mon, 28 Jul 2014 16:29:32 -0700 (PDT)
In-Reply-To: <53D68F91.4000106@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-arch <linux-arch@vger.kernel.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, Will Drewry <wad@chromium.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, linux-security-module <linux-security-module@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Alexei Starovoitov <ast@plumgrid.com>

On Mon, Jul 28, 2014 at 10:59 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 07/23/2014 12:20 PM, Andy Lutomirski wrote:
>>
>> It looks like patches 1-4 have landed here:
>>
>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=seccomp/fastpath
>>
>> hpa, what's the route forward for the x86 part?
>>
>
> I guess I should discuss this with Kees to figure out what makes most
> sense.  In the meantime, could you address Oleg's question?

Since the x86 parts depend on the seccomp parts, I'm happy if you
carry them instead of having them land from my tree. Otherwise I'm
open to how to coordinate timing.

-Kees

>
>         -hpa
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Kees Cook
Chrome OS Security
