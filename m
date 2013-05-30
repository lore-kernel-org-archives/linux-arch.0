From: Wang YanQing <udknight@gmail.com>
Subject: Re: [PATCH] arch: parisc: kernel: using strlcpy() instead of strcpy()
Date: Thu, 30 May 2013 23:06:36 +0800
Message-ID: <20130530150636.GA2121@udknight>
References: <51A6A8F3.2030200@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51A6A8F3.2030200@asianux.com>
Sender: linux-parisc-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Greg KH <gregkh@linuxfoundation.org>, Parisc List <linux-parisc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 30, 2013 at 09:18:43AM +0800, Chen Gang wrote:
> 
> 'boot_args' is an input args, and 'boot_command_line' has a fix length.
> 
> So need use strlcpy() instead of strcpy() to avoid memory overflow.
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/parisc/kernel/setup.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
> index 60c1ae6..7349a3f 100644
> --- a/arch/parisc/kernel/setup.c
> +++ b/arch/parisc/kernel/setup.c
> @@ -69,7 +69,8 @@ void __init setup_cmdline(char **cmdline_p)
>  		/* called from hpux boot loader */
>  		boot_command_line[0] = '\0';
>  	} else {
> -		strcpy(boot_command_line, (char *)__va(boot_args[1]));
> +		strlcpy(boot_command_line, (char *)__va(boot_args[1]),
> +			COMMAND_LINE_SIZE);

What about add 
boot_command_line[COMMAND_LINE_SIZE - 1] = '\0';
to protect the following another strcpy?

"
strcpy(command_line, boot_command_line);
"
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  		if (boot_args[2] != 0) /* did palo pass us a ramdisk? */
> -- 
> 1.7.7.6
