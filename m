From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Thu, 26 Jan 2017 20:04:52 +0100
Message-ID: <20170126190452.GA6326@gmail.com>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36582 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdAZT2c (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2017 14:28:32 -0500
Content-Disposition: inline
In-Reply-To: <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au


* Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:

> This header file is exported, thus move it to uapi.
> 
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  arch/x86/include/asm/msr-index.h      | 698 ----------------------------------
>  arch/x86/include/uapi/asm/msr-index.h | 698 ++++++++++++++++++++++++++++++++++

For the reasons Boris outlined:

  NAKed-by: Ingo Molnar <mingo@kernel.org>

Please remove this patch from linux-next as well, until you get an Acked-by from 
an x86 maintainer.

Thanks,

	Ingo
