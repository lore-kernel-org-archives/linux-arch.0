From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 23 Jan 2017 17:52:45 +0100
Message-ID: <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 23, 2017 at 03:58:37PM +0100, Nicolas Dichtel wrote:
> This header file is exported, thus move it to uapi.

Why? Why is this damn thing exported in the first place?

The moment we decide to change an MSR name or even remove it from that
file, we break userspace. And what for, because userspace is using some
arbitrary header file which was meant to be for the kernel solely.

NAKed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
