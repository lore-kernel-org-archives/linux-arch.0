From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v4 3/7] x86: put msr-index.h in uapi
Date: Mon, 30 Jan 2017 16:30:22 +0100
Message-ID: <20170130153022.baj7ydxz2537bxva@pd.tnic>
References: <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-1-git-send-email-nicolas.dichtel@6wind.com>
 <1485183521-13002-4-git-send-email-nicolas.dichtel@6wind.com>
 <20170123165245.7zy7nf3cx5o4vvh3@pd.tnic>
 <20170130145151.GW27312@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170130145151.GW27312@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, slash.tmp@free.fr, daniel.vetter@ffwll.ch, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 30, 2017 at 02:51:51PM +0000, Russell King - ARM Linux wrote:
> Like it or not, it is _already_ exported to userspace, so it forms

Well, I did try to stop it then too:

  b72e7464e4cf ("x86/uapi: Do not export <asm/msr-index.h> as part of the user API headers")

And yet this wankery trickled out to userspace anyway.

> part of the user ABI.  You can try to remove it from userspace view,
> but if anyone has already started to use it, removing it will already
> cause a userspace regression.

Well, if it were me, I'd still remove the header and see if anything
breaks.

If it does - which I doubt very much - we can do Christoph's idea of
leaving the current version of the header exported but then untangling
it from the whole uapi crap and use our own kernel version which we can
change as much as we can.

In the end of the day, it is a maintainer decision what's going to
happen.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
