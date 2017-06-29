From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 1/9] RISC-V: Init and Halt Code
Date: Thu, 29 Jun 2017 15:52:45 -0700 (PDT)
Message-ID: <mhng-c8510de2-0109-4a21-93b0-174fa67b94bf@palmer-si-x1c4>
References: <CAMuHMdXOOyRT5Vogi3F-x9O2R4GXazxSXQ1Q3F2VbfBEFFLEiw@mail.gmail.com>
Mime-Version: 1.0 (MHng)
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33751 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751687AbdF2Wwr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2017 18:52:47 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so13366232pgb.0
        for <linux-arch@vger.kernel.org>; Thu, 29 Jun 2017 15:52:46 -0700 (PDT)
In-Reply-To: <CAMuHMdXOOyRT5Vogi3F-x9O2R4GXazxSXQ1Q3F2VbfBEFFLEiw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: geert@linux-m68k.org
Cc: peterz@infradead.org, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com

On Thu, 29 Jun 2017 02:44:32 PDT (-0700), geert@linux-m68k.org wrote:
> Hi Palmer,
>
> On Wed, Jun 28, 2017 at 8:55 PM, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> This contains the various __init C functions, the initial assembly
>> kernel entry point, and the code to reset the system.  When a file was
>> init-related, it contains
>
> ...?

Whoops.  I'm not even sure how to make a sentence out of that -- I guess I've
been mangling too many patch sets...

I'll try and be coherent next time :).

>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>
> Gr{oetje,eeting}s,
>
>                         Geert
