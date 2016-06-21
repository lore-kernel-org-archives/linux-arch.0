Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34156 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707AbcFURYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 13:24:22 -0400
Received: by mail-lf0-f51.google.com with SMTP id h129so34118906lfh.1
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2016 10:24:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <13212319.WrhLzgRA6Z@wuerfel>
References: <cover.1466466093.git.luto@kernel.org> <13212319.WrhLzgRA6Z@wuerfel>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 21 Jun 2016 10:16:21 -0700
Message-ID: <CAGXu5jJaWxcOKLtXG3r1XWE8NpL=GFSZwmV_UYjjv6q0135ETQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Lutomirski <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Linus Torvalds <torvalds@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jann@thejh.net>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160621171621.6hPWJQdaNGUhsdydQ7wNwM1UnURK3nOpb0z4S3Ssd_o@z>

On Tue, Jun 21, 2016 at 2:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, June 20, 2016 4:43:30 PM CEST Andy Lutomirski wrote:
>>
>> On my laptop, this adds about 1.5µs of overhead to task creation,
>> which seems to be mainly caused by vmalloc inefficiently allocating
>> individual pages even when a higher-order page is available on the
>> freelist.
>
> Would it help to have a fixed virtual address for the stack instead
> and map the current stack to that during a task switch, similar to
> how we handle fixmap pages?
>
> That would of course trade the allocation overhead for a task switch
> overhead, which may be better or worse. It would also give "current"
> a constant address, which may give a small performance advantage
> but may also introduce a new attack vector unless we randomize it
> again.

Right: we don't want a fixed address. That makes attacks WAY easier.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
