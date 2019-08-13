Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbfHMMpk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Aug 2019 08:45:40 -0400
Date: Tue, 13 Aug 2019 14:45:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/10] RFC: usb-storage: export symbols in USB_STORAGE
 namespace
Message-ID: <20190813124537.GB12475@kroah.com>
References: <20180716122125.175792-1-maco@android.com>
 <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-11-maennich@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813121733.52480-11-maennich@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, maco@android.com, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org, sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
Message-ID: <20190813124537.coDaTxriiZOir0b1EmHpuIi1OAoFSy23dMWOLpoK-P4@z>

On Tue, Aug 13, 2019 at 01:17:07PM +0100, Matthias Maennich wrote:
> Modules using these symbols are required to explicitly import the
> namespace. This patch was generated with the following steps and serves
> as a reference to use the symbol namespace feature:
> 
>  1) Define DDEFAULT_SYMBOL_NAMESPACE in the corresponding Makefile
>  2) make  (see warnings during modpost about missing imports)
>  3) make nsdeps
> 
> Instead of a DEFAULT_SYMBOL_NAMESPACE definition, the EXPORT_SYMBOL_NS
> variants can be used to explicitly specify the namespace. The advantage
> of the method used here is that newly added symbols are automatically
> exported and existing ones are exported without touching their
> respective EXPORT_SYMBOL macro expansion.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  drivers/usb/storage/Makefile        | 2 ++
>  drivers/usb/storage/alauda.c        | 1 +
>  drivers/usb/storage/cypress_atacb.c | 1 +
>  drivers/usb/storage/datafab.c       | 1 +
>  drivers/usb/storage/ene_ub6250.c    | 1 +
>  drivers/usb/storage/freecom.c       | 1 +
>  drivers/usb/storage/isd200.c        | 1 +
>  drivers/usb/storage/jumpshot.c      | 1 +
>  drivers/usb/storage/karma.c         | 1 +
>  drivers/usb/storage/onetouch.c      | 1 +
>  drivers/usb/storage/realtek_cr.c    | 1 +
>  drivers/usb/storage/sddr09.c        | 1 +
>  drivers/usb/storage/sddr55.c        | 1 +
>  drivers/usb/storage/shuttle_usbat.c | 1 +
>  drivers/usb/storage/uas.c           | 1 +
>  15 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/storage/Makefile b/drivers/usb/storage/Makefile
> index a67ddcbb4e24..46635fa4a340 100644
> --- a/drivers/usb/storage/Makefile
> +++ b/drivers/usb/storage/Makefile
> @@ -8,6 +8,8 @@
>  
>  ccflags-y := -I $(srctree)/drivers/scsi
>  
> +ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=USB_STORAGE

Wait, we have to do this for every subsystem?  I thought there was a
macro we could use in the code itself for this.  What changed from
earlier versions, or was this always here?

thanks,

greg k-h
