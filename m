Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:54348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdAWRVM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Jan 2017 12:21:12 -0500
Date: Mon, 23 Jan 2017 09:21:03 -0800
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Message-ID: <20170123172103.GB28446@infradead.org>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <d105332c-d8dd-938a-aaa5-ceb42fca4507@6wind.com>
 <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170123171732.i3qfbcsqzznppe5m@pd.tnic>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, hpa@zytor.com
Message-ID: <20170123172103.Ch_91-7X7XPfUzGt0_6Ikxnot2hv-_fiV3_O8n3dZXA@z>

On Mon, Jan 23, 2017 at 06:17:32PM +0100, Borislav Petkov wrote:
> I know, we should not ever break userspace but if it were me, I'd remove
> that export and see what breaks. If at all.

Or keep the exported version as-is and never changed it, and use
a different copy for the kernel itself.
