From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2/2] Add dev.mem.restricted sysctl
Date: Sun, 16 Nov 2008 03:33:27 +0300
Message-ID: <20081116003327.GA2405@x200.localdomain>
References: <1226793823-32360-1-git-send-email-bwalle@suse.de> <1226793823-32360-3-git-send-email-bwalle@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:32526 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYKPA3z (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Nov 2008 19:29:55 -0500
Received: by ug-out-1314.google.com with SMTP id 39so165661ugf.37
        for <linux-arch@vger.kernel.org>; Sat, 15 Nov 2008 16:29:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1226793823-32360-3-git-send-email-bwalle@suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bernhard Walle <bwalle@suse.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sun, Nov 16, 2008 at 01:03:43AM +0100, Bernhard Walle wrote:
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -858,6 +858,7 @@ enum {
>  	DEV_MAC_HID=5,
>  	DEV_SCSI=6,
>  	DEV_IPMI=7,
> +	DEV_MEM=8,
>  };
>  
>  /* /proc/sys/dev/cdrom */
> @@ -875,6 +876,11 @@ enum {
>  	DEV_PARPORT_DEFAULT=-3
>  };
>  
> +/* /proc/sys/dev/mem */
> +enum {
> +    DEV_MEM_RESTRICTED=1,
> +};

No new binary sysctls please.
