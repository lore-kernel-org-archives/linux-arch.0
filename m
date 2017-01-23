From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 23 Jan 2017 18:06:52 +0100
Message-ID: <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
Reply-To: nicolas.dichtel@6wind.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38107 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdAWRG5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2017 12:06:57 -0500
Received: by mail-wm0-f50.google.com with SMTP id r144so165792242wme.1
        for <linux-arch@vger.kernel.org>; Mon, 23 Jan 2017 09:06:56 -0800 (PST)
In-Reply-To: <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com

+ Peter Anvin and Ingo Molnar

Le 23/01/2017 à 17:52, Borislav Petkov a écrit :
> On Mon, Jan 23, 2017 at 03:58:37PM +0100, Nicolas Dichtel wrote:
>> This header file is exported, thus move it to uapi.
> 
> Why? Why is this damn thing exported in the first place?
It is exported because it is listed in arch/x86/include/uapi/asm/Kbuild:
header-y += msr-index.h (see also patch #4).

> 
> The moment we decide to change an MSR name or even remove it from that
> file, we break userspace. And what for, because userspace is using some
> arbitrary header file which was meant to be for the kernel solely.
I understand your concerns but my patch does not change anything. And I think
David's comment is right: if I remove it, I break the uapi.

After digging a bit, it seems you have already tried to remove it in commit
b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API
headers"), but because this file is still listed in the Kbuild file, it is still
exported.

It would be great if we could find a consensus about what to do with this file
because it blocks patch #4 and the rest of the series.


Thank you,
Nicolas
