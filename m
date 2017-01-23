From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 23 Jan 2017 18:17:32 +0100
Message-ID: <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:42441 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750705AbdAWRRl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jan 2017 12:17:41 -0500
Content-Disposition: inline
In-Reply-To: <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com

On Mon, Jan 23, 2017 at 06:06:52PM +0100, Nicolas Dichtel wrote:
> After digging a bit, it seems you have already tried to remove it in commit
> b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API
> headers"), but because this file is still listed in the Kbuild file, it is still
> exported.

Oh great. :-\

> It would be great if we could find a consensus about what to do with
> this file because it blocks patch #4 and the rest of the series.

The reasoning in b72e7464e4cf was valid then and is valid now. This
thing should not have been exported in the first place. And it's not
like I didn't try then. Dammit!

I know, we should not ever break userspace but if it were me, I'd remove
that export and see what breaks. If at all.

But let's see what the others think first.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
