Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:58661 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932575AbXAGPNY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 7 Jan 2007 10:13:24 -0500
Date: Sun, 7 Jan 2007 15:13:19 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Common compat_sys_sysinfo
Message-ID: <20070107151319.GA23478@infradead.org>
References: <20070107144850.GB3207@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070107144850.GB3207@athena.road.mcmartin.ca>
Sender: linux-arch-owner@vger.kernel.org
To: Kyle McMartin <kyle@parisc-linux.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, parisc-linux@lists.parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Jan 07, 2007 at 09:48:50AM -0500, Kyle McMartin wrote:
> While tracking a bug for Thibaut Varene, I noticed that almost all
> architectures implemented exactly the same sys32_sysinfo... except
> parisc, where a bug was to be found in handling of the uptime. So
> let's remove a whole whack of code for fun and profit. Cribbed
> compat_sys_sysinfo from x86_64's implementation, since I figured
> it would be the best tested.
> 
> This patch incorporates Arnd's suggestion of not using set_fs/get_fs,
> but instead extracting out the common code from sys_sysinfo.
> 
> Tested on a handful of architectures (ia64, parisc, x86_64.)

Looks generally good to me, but..

> +asmlinkage long
> +compat_sys_sysinfo(struct compat_sysinfo __user *info)
> +{
> +	extern int do_sysinfo(struct sysinfo *info);

Please always put prototypes for functions with external linkage in
header files.

> +int do_sysinfo(struct sysinfo *info)
>  {
> -	struct sysinfo val;
>  	unsigned long mem_total, sav_total;
>  	unsigned int mem_unit, bitcount;
>  	unsigned long seq;
>  
> -	memset((char *)&val, 0, sizeof(struct sysinfo));
> +	memset((char *)info, 0, sizeof(struct sysinfo));

No need for the cast here.


Btw, in case you have some spare time there are some other syscalls
that want similar treatment.  sendfile(64) come to mind as these
could use a do_sendfile helper aswell, the various stat and readdir/getdents
variants could do with some unification, the various timing calls
like alarm and get/settimeofday are common across architectures,
sysctl should be the same everywhere, the uid/git related syscalls
should be consolidated, sched_rr_get_interval looks trivial,
and last but not least we probably want a unified mechanisms to deal
with the 64bit arguments that are broken up into two 32bit ones (not just
for emulation but also for 32it BE architectures)

Okay, okay - we should probably put this into a Wiki somewhere :)
