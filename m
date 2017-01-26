From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Thu, 26 Jan 2017 20:29:50 +0100
Message-ID: <20170126192950.eeinndcreybf5jpb@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170126190452.GA6326@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170126190452.GA6326@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 26, 2017 at 08:04:52PM +0100, Ingo Molnar wrote:
> Please remove this patch from linux-next as well, until you get an
> Acked-by from an x86 maintainer.

... and the header export from arch/x86/include/uapi/asm/Kbuild too pls.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
