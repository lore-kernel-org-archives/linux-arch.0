From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
Date: Thu, 9 Jul 2009 20:44:21 +0930
Message-ID: <200907092044.22108.rusty@rustcorp.com.au>
References: <4A4A18780200007800008345@vpn.id2.novell.com> <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A51C71B0200007800008EE2-Qfbpwmsw6RoS3W1tAdPHOtBPR1lH4CV8@public.gmane.org>
Content-Disposition: inline
Sender: linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Beulich <JBeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>, Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, Jon Masters <jonathan-Zp4isUonpHBD60Wz+7aTrA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 6 Jul 2009 05:12:51 pm Jan Beulich wrote:
> >Jan Beulich napsal(a):
> >> Since these CRCs are really only 32-bit quantities, there's no need to
> >> store them in 64-bit slots. Since, however, gcc doesn't allow
> >> respective initializations, asm() constructs get used to create the CRC
> >> tables (and its for that reason that the patch only makes x86-64 and
> >> ia64 utilize that functionality, as I can't verify this doesn't break
> >> in some subtle way elsewhere).
> >
> >...
> >
> >>  struct modversion_info
> >>  {
> >> -	unsigned long crc;
> >> +	ksym_crc_t crc;
> >>  	char name[MODULE_NAME_LEN];
> >>  };
> >
> >This change breaks module-init-tools:
> >Before:
> >$ /sbin/modprobe --dump-modversions _build/drivers/usb/core/usbcore.ko
> >
> >| head
> >
> >0xb49b735a      module_layout
> >0xdb7e6a70      bus_register
> >...
> >After:
> >$ /sbin/modprobe --dump-modversions
> >_build-crc-int/drivers/usb/core/usbcore.ko  | head
> >0x75646f6d91ea7b5c      le_layout
> >0x5f7375623e215f43      register
> >...
> >It also breaks the newly added depmod -E option (check symbol versions),
> >which also reads the struct modversion_info array (*). Is it possible
> >name the section differently (__versions2?) on those architectures where
> >the size changes, so that it is possible to fix m-i-t in a
> >backwards-compatible manner?
>
> First of all I'd view it as a design bug if user mode code assumptions
> prevent changes to the kernel.

Yes, but unfortunately it happens.  We do it much less than we used to, but 
there are limits.

> But taking this as an uncorrectable fact, I'd think that renaming the
> section would certainly be an option (though I'm unsure whether that would
> have other consequences - Rusty?), however I could also imagine other means
> to communicate to user land the width of a CRC value (e.g. adding an
> absolute symbol during the .ko linking stage).

No, just break it once.  And I still like the idea that we should do something 
more radical if we're going to break this anyway, rather than these nasty asm 
hacks.

Thanks,
Rusty.

--
To unsubscribe from this list: send the line "unsubscribe linux-modules" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
