Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:5828 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261862AbUFESl5 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 5 Jun 2004 14:41:57 -0400
Date: Sat, 5 Jun 2004 11:41:13 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: sys getdents64 needs compat wrapper ?
Message-Id: <20040605114113.13926473.akpm@osdl.org>
In-Reply-To: <26879984$108644643740c1db65f33611.91624784@config13.schlund.de>
References: <26879984$108644643740c1db65f33611.91624784@config13.schlund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: arun.sharma@intel.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> wrote:
>
> Arun Sharma <arun.sharma@intel.com> schrieb am 05.06.2004, 02:16:09:
> 
>  > - use put_user instead of copy_to_user for simple data types.
> 
>  Not that I care too much, but what's the point of this change? A single
>  __copy_to_user should be both faster and easier to read than two 
>  seperate __put_user when writing an unaligned 64 bit value.
> 

Easier to read, yes.  But __put_user() is faster.  It's a single instruction!
