Return-Path: <arun.sharma@intel.com>
Received: from fmr04.intel.com ([143.183.121.6]:56247 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262942AbUCYAc3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Mar 2004 19:32:29 -0500
Message-ID: <4062287F.3050003@intel.com>
Date: Wed, 24 Mar 2004 16:31:59 -0800
From: Arun Sharma <arun.sharma@intel.com>
MIME-Version: 1.0
Subject: Re: signal-race-fix.patch
References: <16482.871.918222.70972@napali.hpl.hp.com>
In-Reply-To: <16482.871.918222.70972@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Corey Minyard <minyard@acm.org>, davem@redhat.com, linux-arch@vger.kernel.org, roland@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On 3/24/2004 1:53 PM, David Mosberger wrote:

> It looks fine to me, except that I decided to play chicken as far
> as the give_sigsegv update of sa_handler is concerned.
> 
> Arun, I hope I got the ia32 emulation parts right, but you may want to
> double-check.

Yes, the patch looks good to me and it survived a 32 bit version of Andrew's test program.

	-Arun
