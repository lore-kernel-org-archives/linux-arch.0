Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f51.google.com ([209.85.219.51]:42366 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbaDWMli (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 Apr 2014 08:41:38 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so927619oah.38
        for <linux-arch@vger.kernel.org>; Wed, 23 Apr 2014 05:41:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201404231418.05174.arnd@arndb.de>
References: <1398247687-13453-1-git-send-email-james.hogan@imgtec.com>
	<1398247687-13453-4-git-send-email-james.hogan@imgtec.com>
	<201404231418.05174.arnd@arndb.de>
Date: Wed, 23 Apr 2014 13:41:37 +0100
Message-ID: <CAAG0J9-2=rP3RP08eEjd17R3wEaeiUtGfWD-LeqXV=y9sBamfA@mail.gmail.com>
Subject: Re: [RFC 3/3] asm-generic: Drop renameat syscall from default list
From: James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Miklos Szeredi <mszeredi@suse.cz>
Cc: linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, metag <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, linux@lists.openrisc.net, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Chris Metcalf <cmetcalf@tilera.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>
Message-ID: <20140423124137.DzPOsmSHq9vVnAq7Z-luGZpQTq3asW1Ew8t6sw1vaCI@z>

On 23 April 2014 13:18, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 23 April 2014, James Hogan wrote:
>> The new renameat2 syscall provides all the functionality provided by the
>> renameat syscall and adds flags, so future architectures won't need to
>> include renameat.
>>
>> Therefore drop the renameat syscall from the generic syscall list unless
>> __ARCH_WANT_RENAMEAT is defined by the architecture's unistd.h prior to
>> including asm-generic/unistd.h, and adjust all architectures using the
>> generic syscall list to define it so that no in-tree architectures are
>> affected.
>
> I should have read this one before replying to patch 2 ;-)
>
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: linux-arch@vger.kernel.org
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Mark Salter <msalter@redhat.com>
>> Cc: Aurelien Jacquiot <a-jacquiot@ti.com>
>> Cc: linux-c6x-dev@linux-c6x.org
>> Cc: Richard Kuo <rkuo@codeaurora.org>
>> Cc: linux-hexagon@vger.kernel.org
>> Cc: linux-metag@vger.kernel.org
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: linux@lists.openrisc.net
>> Cc: Chen Liqin <liqin.linux@gmail.com>
>> Cc: Lennox Wu <lennox.wu@gmail.com>
>> Cc: Chris Metcalf <cmetcalf@tilera.com>
>> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
>> ---
>> Is this the approach we want to take to keep the default syscall list
>> minimal? We could for example have made renameat2 use the renameat
>> syscall number for new arches, but it seemed best to leave a gap for new
>> arches to improve consistency of numbering.
>
> I think leaving the hole is best.
>
>> This patch is a no-op for arches in tree, so there's no harm for this to
>> wait for the v3.16 merge window.
>
> Sounds good. I guess I'll have to put this into my asm-generic tree
> then, unless I can get the nios2 maintainers to pick it up.

Okay, thanks.

> If you don't mind, can you submit the first two patches to Linus
> directly?

It appears Miklos Szeredi beat me to it with patch 1 (adding renameat2
syscall to asm-generic unistd.h), and will be submitting it to Linus
at some point as part of his renameat2 series.
Miklos: Do you think it makes sense for you to include my second patch
in your series too since it's renameat2 related?
http://marc.info/?l=linux-kernel&m=139824773305016&w=2

Otherwise I'm happy to take it or both patches for v3.15.

Cheers
James
