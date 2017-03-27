Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35488 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbdC0Js7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2017 05:48:59 -0400
Received: by mail-wr0-f174.google.com with SMTP id u1so47870621wra.2
        for <linux-arch@vger.kernel.org>; Mon, 27 Mar 2017 02:48:53 -0700 (PDT)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v10 11/11] uapi: export all arch specifics directories
References: <CAK7LNARpx7f0eV5_AiPmNYT7MsRbGFOygJwjfAzX_7aCpuHwuw@mail.gmail.com>
 <1489496093-15315-1-git-send-email-nicolas.dichtel@6wind.com>
 <1489496093-15315-12-git-send-email-nicolas.dichtel@6wind.com>
 <CAK7LNASihZAunuAR2TwfWUFnk+SNiVgzZjfDKBHzOEtwVnxVHw@mail.gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <d3a9ad53-2be9-5446-5932-27820842ffc6@6wind.com>
Date: Mon, 27 Mar 2017 11:42:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAK7LNASihZAunuAR2TwfWUFnk+SNiVgzZjfDKBHzOEtwVnxVHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Michal Marek <mmarek@suse.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, David Airlie <airlied@linux.ie>, "David S. Miller" <davem@davemloft.net>, Russell King <linux@armlinux.org.uk>, bp@alien8.de, slash.tmp@free.fr, Daniel Vetter <daniel.vetter@ffwll.ch>, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, Tobias Klauser <tklauser@distanz.ch>, mpe@ellerman.id.au, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Dmitry V. Levin" <ldv@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, linux-rdma@vger.kernel.org
Message-ID: <20170327094236.DKM8gP8RKuOvjcmVk7jbo8HZOV6pQf1RE-bnuXpnlw0@z>

Hi Masahiro,

Le 27/03/2017 à 07:27, Masahiro Yamada a écrit :
> Hi Nicolas,
> 
> 
> 2017-03-14 21:54 GMT+09:00 Nicolas Dichtel <nicolas.dichtel@6wind.com>:
>> diff --git a/arch/cris/include/uapi/asm/Kbuild b/arch/cris/include/uapi/asm/Kbuild
>> index d0c5471856e0..b15bf6bc0e94 100644
>> --- a/arch/cris/include/uapi/asm/Kbuild
>> +++ b/arch/cris/include/uapi/asm/Kbuild
>> @@ -1,5 +1,2 @@
>>  # UAPI Header export list
>>  include include/uapi/asm-generic/Kbuild.asm
>> -
>> -subdir-y += ../arch-v10/arch/
>> -subdir-y += ../arch-v32/arch/
> 
> 
> Can you remove
> arch/cris/include/arch-v32/arch/Kbuild
> arch/cris/include/arch-v10/arch/Kbuild
> as well?
Ok.

> 
> Or, not sure if they are still needed?
I don't think so. Have a look to 77c8006d8df4 ("UAPI: Fix up empty files in
arch/cris/") for more details.

> 
> 
> 
>> diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
>> index e0a50111e07f..0c74c3c5ebfa 100644
>> --- a/arch/tile/include/uapi/asm/Kbuild
>> +++ b/arch/tile/include/uapi/asm/Kbuild
>> @@ -2,5 +2,3 @@
>>  include include/uapi/asm-generic/Kbuild.asm
>>
>>  generic-y += ucontext.h
>> -
>> -subdir-y += ../arch
> 
> Can you remove  arch/tile/include/arch/Kbuild as well?
Ok.

Because this removal is not directly related to this patch, I will add another
patch in the series.

Regards,
Nicolas
