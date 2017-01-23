From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 23 Jan 2017 23:51:07 +0100
Message-ID: <20170123225107.f4yqjtgvz7kx7s5k@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
 <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
 <20170123172103.GB28446@infradead.org>
 <20170123172627.32zcbntwo7nmd5rf@pd.tnic>
 <alpine.LSU.2.20.1701232316180.19605@erq.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.20.1701232316180.19605@erq.vanv.qr>
Sender: linux-kbuild-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@inai.de>
Cc: Christoph Hellwig <hch@infradead.org>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 23, 2017 at 11:24:02PM +0100, Jan Engelhardt wrote:
> So if some userspace component depends on that particular msr header
> (which, unlike ipt_SAME, was not intended for export), is it not
> reasonable to expect them to make a copy if and when they need it?

Yeah, either copy the whole header or better yet use own defines.
Especially in this particular case, where we have a bunch of MSRs which
are in the processor manuals. Exporting the defines is pretty pointless
and even disadvantageous for the kernel.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
