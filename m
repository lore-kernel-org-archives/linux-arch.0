Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S266427AbUH0P4J@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:149 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266365AbUH0Py0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 27 Aug 2004 11:54:26 -0400
Date: Fri, 27 Aug 2004 17:52:47 +0200
From: Andi Kleen <ak@suse.de>
Subject: Re: bug in syscal arg sign extension
Message-ID: <20040827155247.GA1024@wotan.suse.de>
References: <20040826180802.4f1e6dbb.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826180802.4f1e6dbb.davem@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Aug 26, 2004 at 06:08:02PM -0700, David S. Miller wrote:
> 
> Remember this topic long ago?
> 
> Anyways, there was a bug in my sparc64 code and it causes all
> kinds of trouble for logging daemons.  I was sign extending
> the buffer pointer arg instead of the length arg to sys_syslog()
> Ooops!
>  :-)
> 
> Fix attached in cases anyone was doing work for the platform
> based upon my sparc64 stuff.

Thanks for the hint. From a quick look at your list I think
there are several bugs on x86-64.

But some entries I don't understand. e.g. why are you sign
extending open or prctl? 

-Andi


> 
> ===== arch/sparc64/kernel/sys32.S 1.9 vs edited =====
> --- 1.9/arch/sparc64/kernel/sys32.S	2004-06-03 14:51:21 -07:00
> +++ edited/arch/sparc64/kernel/sys32.S	2004-08-26 17:49:39 -07:00
> @@ -120,7 +120,7 @@
>  SIGN2(sys32_setpgid, sys_setpgid, %o0, %o1)
>  SIGN3(sys32_setpriority, sys_setpriority, %o0, %o1, %o2)
>  SIGN1(sys32_ssetmask, sys_ssetmask, %o0)
> -SIGN2(sys32_syslog, sys_syslog, %o0, %o1)
> +SIGN2(sys32_syslog, sys_syslog, %o0, %o2)
>  SIGN1(sys32_umask, sys_umask, %o0)
>  SIGN3(sys32_tgkill, sys_tgkill, %o0, %o1, %o2)
>  SIGN1(sys32_sendto, sys_sendto, %o0)
