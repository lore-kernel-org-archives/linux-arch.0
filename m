From: Jon Masters <jonathan-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit	 archs
Date: Tue, 14 Jul 2009 06:29:32 -0400
Message-ID: <1247567372.31188.229.camel@perihelion.bos.jonmasters.org>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
	 <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
	 <200907092044.22108.rusty@rustcorp.com.au>
	 <4A57089B0200007800009C0E@vpn.id2.novell.com> <4A5AEC3C.2060608@suse.cz>
	 <4A5B101E020000780000A284@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A5B101E020000780000A284-Qfbpwmsw6RoS3W1tAdPHOtBPR1lH4CV8@public.gmane.org>
Sender: linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Beulich <JBeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2009-07-13 at 09:44 +0100, Jan Beulich wrote:
> >>> Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org> 13.07.09 10:11 >>>
> >Jan Beulich napsal(a):
> >> Actually I meanwhile think that module-init-tools can easily detect the changed
> >> layout without any further kernel side adjustments: Since it is known that a
> >> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
> >> value has more than 32 significant bits should suffice: If so, the new layout
> >> is being used (with the symbol name starting at offset 4), else the old one is
> >> in effect (name at offset 8). This ought to be a pretty trivial change to that
> >> code.
> >
> >But old module-init-tools will continue reading garbage in this case.

Most of the distros can fix that with a dependency on the kernel package
in the absolute worst case, not that I love that idea, but it happens. I
assume for now we are going with detecting the two possibilities because
it doesn't really hurt in any case to have this support.

Jon.


--
To unsubscribe from this list: send the line "unsubscribe linux-modules" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
