Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36231 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752479AbdAZRRl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2017 12:17:41 -0500
Received: by mail-wm0-f48.google.com with SMTP id c85so81199943wmi.1
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2017 09:17:40 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
 <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
 <20170123172103.GB28446@infradead.org>
 <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Message-ID: <1f363058-86ed-7b37-7497-8c370f33d508@6wind.com>
Date: Thu, 26 Jan 2017 17:02:01 +0100
MIME-Version: 1.0
In-Reply-To: <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>, Christoph Hellwig <hch@infradead.org>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com
Message-ID: <20170126160201.MJ3A5mlOYhCNH_MA2UUV7L9qTcr3ZZ_8zZaLPUQOuBo@z>

Le 23/01/2017 à 18:26, Borislav Petkov a écrit :
> On Mon, Jan 23, 2017 at 09:21:03AM -0800, Christoph Hellwig wrote:
>> Or keep the exported version as-is and never changed it, and use
>> a different copy for the kernel itself.
> 
> Yeah, that's a good idea, thanks Christoph.
> 
> I guess we'll have to do that if something in userspace has put its
> sticky fingers on that file and cannot be fixed. Which I hardly doubt
> but we can't break that damn userspace.
> 
So do you agree with the current patch (a build-fix is also needed :/)?
