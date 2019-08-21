From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 09/11] usb-storage: remove single-use define for
 debugging
Date: Wed, 21 Aug 2019 15:21:22 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1908211520360.2223@nanos.tec.linutronix.de>
References: <20190813121733.52480-1-maennich@google.com> <20190821114955.12788-1-maennich@google.com> <20190821114955.12788-10-maennich@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190821114955.12788-10-maennich@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Maennich <maennich@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com, jeyu@kernel.org, joel@joelfernandes.org, kstewart@linuxfoundation.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org, linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, lucas.de.marchi@gmail.com, maco@android.com, maco@google.com, michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com, pombredanne@nexb.com, sam@ravnborg.org, sspatil@google.com, stern@rowland.harvard.edu, usb-storage@lists.one-eyed-alien.net, x86@kernel.org, yamada.masahiro@socionext.com
List-Id: linux-arch.vger.kernel.org

On Wed, 21 Aug 2019, Matthias Maennich wrote:

> USB_STORAGE was defined as "usb-storage: " and used in a single location
> as argument to printk. In order to be able to use the name
> 'USB_STORAGE', drop the definition and use the string directly for the
> printk call.
> 
> Signed-off-by: Matthias Maennich <maennich@google.com>
> ---
>  drivers/usb/storage/debug.h    | 2 --
>  drivers/usb/storage/scsiglue.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/storage/debug.h b/drivers/usb/storage/debug.h
> index 6d64f342f587..16ce06039a4d 100644
> --- a/drivers/usb/storage/debug.h
> +++ b/drivers/usb/storage/debug.h
> @@ -29,8 +29,6 @@
>  
>  #include <linux/kernel.h>
>  
> -#define USB_STORAGE "usb-storage: "
> -
>  #ifdef CONFIG_USB_STORAGE_DEBUG
>  void usb_stor_show_command(const struct us_data *us, struct scsi_cmnd *srb);
>  void usb_stor_show_sense(const struct us_data *us, unsigned char key,
> diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
> index 05b80211290d..df4de8323eff 100644
> --- a/drivers/usb/storage/scsiglue.c
> +++ b/drivers/usb/storage/scsiglue.c
> @@ -379,7 +379,7 @@ static int queuecommand_lck(struct scsi_cmnd *srb,
>  
>  	/* check for state-transition errors */
>  	if (us->srb != NULL) {
> -		printk(KERN_ERR USB_STORAGE "Error in %s: us->srb = %p\n",
> +		printk(KERN_ERR "usb-storage: Error in %s: us->srb = %p\n",
>  			__func__, us->srb);

The proper fix for this is to use pr_fmt and convert the printk to pr_err().

Thanks,

	tglx
