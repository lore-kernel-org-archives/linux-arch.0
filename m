From: Michal Marek <mmarek-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit archs
Date: Fri, 03 Jul 2009 22:16:28 +0200
Message-ID: <4A4E671C.2090201@suse.cz>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4A4A18780200007800008345-Qfbpwmsw6RoS3W1tAdPHOtBPR1lH4CV8@public.gmane.org>
Sender: linux-modules-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Beulich <JBeulich-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Ingo Molnar <mingo-X9Un+BFzKDI@public.gmane.org>, tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-modules-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Jan Beulich napsal(a):
> Since these CRCs are really only 32-bit quantities, there's no need to
> store them in 64-bit slots. Since, however, gcc doesn't allow
> respective initializations, asm() constructs get used to create the CRC
> tables (and its for that reason that the patch only makes x86-64 and
> ia64 utilize that functionality, as I can't verify this doesn't break
> in some subtle way elsewhere).
> 
...
>  struct modversion_info
>  {
> -	unsigned long crc;
> +	ksym_crc_t crc;
>  	char name[MODULE_NAME_LEN];
>  };

This change breaks module-init-tools:
Before:
$ /sbin/modprobe --dump-modversions _build/drivers/usb/core/usbcore.ko
| head
0xb49b735a      module_layout
0xdb7e6a70      bus_register
0xe3a25bcc      device_remove_file
0x1fedf0f4      __request_region
0x37429b3b      device_remove_bin_file
0x27ac237c      cdev_del
0xf3be63b3      per_cpu__current_task
0x26b76a45      kmalloc_caches
0x5a34a45c      __kmalloc
0x1c820358      cdev_init

After:
$ /sbin/modprobe --dump-modversions
_build-crc-int/drivers/usb/core/usbcore.ko  | head
0x75646f6d91ea7b5c      le_layout
0x5f7375623e215f43      register
0x69766564848c67e2      ce_remove_file
0x65725f5f1fedf0f4      quest_region
0x69766564a0c29c25      ce_remove_bin_file
0x766564633ce98bc2      _del
0x5f72657012c9615b      cpu__current_task
0x6c616d6b6ea6c464      loc_caches
0x6d6b5f5f5a34a45c      alloc
0x766564631e5d885b      _init

It also breaks the newly added depmod -E option (check symbol versions),
which also reads the struct modversion_info array (*). Is it possible
name the section differently (__versions2?) on those architectures where
the size changes, so that it is possible to fix m-i-t in a
backwards-compatible manner?

Michal


(*) dump_modvers() and load_symbols() in
http://git.kernel.org/?p=utils/kernel/module-init-tools/module-init-tools.git;a=blob;f=elfops_core.c;hb=HEAD
--
To unsubscribe from this list: send the line "unsubscribe linux-modules" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
