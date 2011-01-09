From: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: Cross compilers (Was: Re: [PATCH] Fix unconditional GFP_KERNEL
 allocations in __vmalloc().)
Date: Mon, 10 Jan 2011 10:17:07 +1100
Message-ID: <20110109231707.GD19615@ozlabs.org>
References: <1292381126-5710-1-git-send-email-ricardo.correia@oracle.com>
 <1292381600.2994.6.camel@oralap>
 <20101215144835.adf2078f.sfr@canb.auug.org.au>
 <20101223133709.d5973e48.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:33139 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849Ab1AIXRJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 9 Jan 2011 18:17:09 -0500
Content-Disposition: inline
In-Reply-To: <20101223133709.d5973e48.randy.dunlap@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "Ricardo M. Correia" <ricardo.correia@oracle.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org, andreas.dilger@oracle.com, behlendorf1@llnl.gov

On Thu, Dec 23, 2010 at 01:37:09PM -0800, Randy Dunlap wrote:

> OK, what am I doing wrong?

You're not doign anything wrong.  The build systems ahd glibc2.11 installed and
the crosstool chains have detected that and explictly set that as the required
version for mkstemps.

I'll see if I can force an older version for that symbol (without patching
gcc), until then try a system with 2.11 ?

This does limit the utility of these cross compilers.
 
> Using alpha or s390x gcc builds on x86_64 host give me:
> 
> /local/cross/gcc-4.5.1-nolibc/s390x-linux/bin/s390x-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.11' not found (required by /local/cross/gcc-4.5.1-nolibc/s390x-linux/bin/s390x-linux-gcc)
> 
> or
> 
> /local/cross/gcc-4.5.1-nolibc/alpha-linux/bin/alpha-linux-gcc: /lib64/libc.so.6: version `GLIBC_2.11' not found (required by /local/cross/gcc-4.5.1-nolibc/alpha-linux/bin/alpha-linux-gcc)

Yours Tony
