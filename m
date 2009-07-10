From: Jon Masters <jonathan-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
Date: Fri, 10 Jul 2009 11:50:01 -0400
Message-ID: <1247241001.5006.11.camel@localhost.localdomain>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
	 <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
	 <200907092044.22108.rusty@rustcorp.com.au>
	 <4A57089B0200007800009C0E@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A57089B0200007800009C0E-Qfbpwmsw6RoS3W1tAdPHOtBPR1lH4CV8@public.gmane.org>
Sender: linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Beulich <JBeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Fri, 2009-07-10 at 08:23 +0100, Jan Beulich wrote:

> Actually I meanwhile think that module-init-tools can easily detect the changed
> layout without any further kernel side adjustments: Since it is known that a
> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
> value has more than 32 significant bits should suffice: If so, the new layout
> is being used (with the symbol name starting at offset 4), else the old one is
> in effect (name at offset 8). This ought to be a pretty trivial change to that
> code.

Agreed. That can be done. I won't get chance to do that until Sunday
though because I'm about to be on a plane back from Tokyo to Boston and
I expect a day of living hell with jetlag/email craziness.

Jon.


--
To unsubscribe from this list: send the line "unsubscribe linux-modules" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
