From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH 3/4] kbuild: link of vmlinux moved to a script
Date: Sat, 05 May 2012 01:05:15 +0200
Message-ID: <4FA460AB.6060309@suse.cz>
References: <20120428205651.GA7426@merkur.ravnborg.org> <20120428205919.GC7442@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20120428205919.GC7442@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, Richard Weinberger <richard@nod.at>, "David S. Miller" <davem@davemloft.net>, Arnaud Lacombe <lacombar@gmail.com>, Andi Kleen <andi@firstfloor.org>
List-Id: linux-arch.vger.kernel.org

Hi Sam,

Thanks a lot for this work and sorry for the delay.

Dne 28.4.2012 22:59, Sam Ravnborg napsal(a):
> +kallsymso=""
> +kallsyms_vmlinux=""
> +if [ -n "${CONFIG_KALLSYMS}" ]; then
> +
[...]
> +
> +	kallsymso=.tmp_kallsyms2.o
> +	kallsyms_vmlinux=.tmp_vmlinux2
> +
> +	# step 1
> +	vmlinux_link "" .tmp_vmlinux1
> +	kallsyms .tmp_vmlinux1 .tmp_kallsyms1.o
> +
> +	# step 2
> +	vmlinux_link .tmp_kallsyms1.o .tmp_vmlinux2
> +	kallsyms .tmp_vmlinux2 .tmp_kallsyms2.o
> +
> +	# step 2a
> +	if [ -n "${KALLSYMS_EXTRA_PASS}" ]; then
> +		kallsymso=.tmp_kallsyms3.o
> +		kallsyms_vmlinux=.tmp_vmlinux2

This should read ".tmp_vmlinux3". Also, how about storing these two
variables in the kallsyms() function instead? That way, you have the
assignment in one place only and this block becomes a little simpler.

This was the only error I spotted, it looks fine otherwise. Please
resubmit with the above typo fixed (whether or not you move the variable
assignments I leave up to you) and I'll add it to linux-next.

Thanks,
Michal
