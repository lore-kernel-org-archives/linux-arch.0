From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/2] OF: clean coding style - prom_parse.c
Date: Sat, 03 May 2008 19:25:15 +0200
Message-ID: <481C9FFB.3090207@gmail.com>
References: <monstr@seznam.cz> <1209827626-8562-1-git-send-email-monstr@seznam.cz> <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:21792 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761489AbYECRZ2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 13:25:28 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1367723fgg.17
        for <linux-arch@vger.kernel.org>; Sat, 03 May 2008 10:25:26 -0700 (PDT)
In-Reply-To: <c382f7ff87d1502c20423742ad738e50a118cf62.1209827449.git.monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: paulus@samba.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On 05/03/2008 05:13 PM, monstr@seznam.cz wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  arch/powerpc/kernel/prom_parse.c |   98 ++++++++++++++++++--------------------
>  1 files changed, 46 insertions(+), 52 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 90eb3a3..7c6b07c 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -31,21 +25,19 @@ static int __of_address_to_resource(struct device_node *dev,
>  		const u32 *addrp, u64 size, unsigned int flags,
>  		struct resource *r);
>  
> -
>  /* Debug utility */
>  #ifdef DEBUG
>  static void of_dump_addr(const char *s, const u32 *addr, int na)
>  {
> -	printk("%s", s);
> -	while(na--)
> -		printk(" %08x", *(addr++));
> -	printk("\n");
> +	printk(KERN_INFO "%s", s);
> +	while (na--)
> +		printk(KERN_INFO " %08x", *(addr++));
> +	printk(KERN_INFO "\n");

This is wrong you'll get
string <6> XXXXXXXX <6> XXXXXXX ... <6>
