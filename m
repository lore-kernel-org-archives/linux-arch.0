Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from barikada.upol.cz ([158.194.242.200]:39485 "EHLO
	barikada.upol.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897AbXIVW6V (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Sep 2007 18:58:21 -0400
Subject: Re: [patch 1/7] Extended crashkernel command line
In-Reply-To: <20070920171846.062209000@stravinsky.suse.de>
References: <20070920171845.774383000@stravinsky.suse.de> <20070920171846.062209000@stravinsky.suse.de>
Date: Sun, 23 Sep 2007 01:14:00 +0200
Message-Id: <E1IZEAi-00051i-23@flower>
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

* Thu, 20 Sep 2007 19:18:46 +0200

[]
>  extern u32 vmcoreinfo_note[VMCOREINFO_NOTE_SIZE/4];
>  extern unsigned int vmcoreinfo_size;
>  extern unsigned int vmcoreinfo_max_size;
> +int __init parse_crashkernel(char *cmdline, unsigned long long system_ram,
> +		unsigned long long *crash_size, unsigned long long *crash_base);

(BTW, why `system_ram' is `unsigned long' in parse_crashkernel_mem() but
`unsigned long long' in parse_crashkernel()?)

> +static int __init parse_crashkernel_mem(char 			*cmdline,
> +					unsigned long 		system_ram,
> +					unsigned long long 	*crash_size,
> +					unsigned long long 	*crash_base)
> +{
> +	char *cur = cmdline;
> +
> +	/* for each entry of the comma-separated list */
> +	do {
> +		unsigned long long start = 0, end = ULLONG_MAX;
> +		unsigned long long size = -1;
[]

What is the point of not using `ulong' and `u64'?

What about another names?

 +int __init get_crashkernel_params(u64 *memsize, u64 *addrbase, char *cmdline, u64 ram);
_____
