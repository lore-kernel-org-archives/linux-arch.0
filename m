Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:54808 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbcGRSC3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jul 2016 14:02:29 -0400
Subject: Re: [PATCH 6/9] x86, pkeys: add pkey set/get syscalls
References: <20160707124719.3F04C882@viggo.jf.intel.com>
 <20160707124728.C1116BB1@viggo.jf.intel.com>
 <20160707144508.GZ11498@techsingularity.net> <577E924C.6010406@sr71.net>
 <20160708071810.GA27457@gmail.com> <577FD587.6050101@sr71.net>
 <20160709083715.GA29939@gmail.com>
From: Dave Hansen <dave@sr71.net>
Message-ID: <578D19AF.3020204@sr71.net>
Date: Mon, 18 Jul 2016 11:02:23 -0700
MIME-Version: 1.0
In-Reply-To: <20160709083715.GA29939@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, dave.hansen@linux.intel.com, arnd@arndb.de, hughd@google.com, viro@zeniv.linux.org.uk, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
Message-ID: <20160718180223.UWCRjEcgpOz87fH4IK_hhZXRaMBagvRGCqRi7E9mP14@z>

On 07/09/2016 01:37 AM, Ingo Molnar wrote:
>    I.e. this pattern:
> 
>      ret = pkey_mprotect(NULL, PAGE_SIZE, real_prot, pkey);
> 
>    ... would validate the pkey and we'd return -EOPNOTSUPP for pkey that is not 
>    available? This would allow maximum future flexibility as it would not define 
>    kernel allocated pkeys as a 'range'.

Isn't this  multiplexing an otherwise straightforward system call?  In
addition to providing pkey assignment to memory, it would also being
used to pass pkey allocation information independently from any use for
memory assignment.

The complexity of the ABI comes from its behavior, not from the raw
number of system calls that are needed to implement it.  IOW, this makes
the ABI *more* complicated.
