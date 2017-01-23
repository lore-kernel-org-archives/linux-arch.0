Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41716 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751337AbdAWR0f (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 23 Jan 2017 12:26:35 -0500
Date: Mon, 23 Jan 2017 18:26:27 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Message-ID: <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
 <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
 <20170123172103.GB28446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170123172103.GB28446@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com
Message-ID: <20170123172627.a-BD6uwByP-tI1NGFt7Ta0hsKVRi6lAB6J4zwVLzXxQ@z>

On Mon, Jan 23, 2017 at 09:21:03AM -0800, Christoph Hellwig wrote:
> Or keep the exported version as-is and never changed it, and use
> a different copy for the kernel itself.

Yeah, that's a good idea, thanks Christoph.

I guess we'll have to do that if something in userspace has put its
sticky fingers on that file and cannot be fixed. Which I hardly doubt
but we can't break that damn userspace.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
