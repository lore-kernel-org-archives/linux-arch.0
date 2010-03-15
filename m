From: David Miller <davem@davemloft.net>
Subject: Re: 64-syscall args on 32-bit vs syscall()
Date: Mon, 15 Mar 2010 12:00:04 -0700 (PDT)
Message-ID: <20100315.120004.209998642.davem@davemloft.net>
References: <20100315134449.GB1653@linux-mips.org>
	<4B9E4EB1.9010800@zytor.com>
	<4B9E59B7.6060405@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:35846
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965680Ab0COS7n (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 15 Mar 2010 14:59:43 -0400
In-Reply-To: <4B9E59B7.6060405@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: drepper@redhat.com
Cc: hpa@zytor.com, ralf@linux-mips.org, benh@kernel.crashing.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@teksavvy.com, torvalds@linux-foundation.org, munroesj@linux.vnet.ibm.com

From: Ulrich Drepper <drepper@redhat.com>
Date: Mon, 15 Mar 2010 09:00:55 -0700

> On 03/15/2010 08:13 AM, H. Peter Anvin wrote:
>> One option would be to do a libkernel.so,
> 
> No need.  Put it in the vdso.  And name it something other than syscall.
>  The syscall() API is fixed, you cannot change it.
> 
> All this only if it makes sense for ALL archs.  If it cannot work for
> just one arch then it's not worth it at all.

There are many archs that still lack VDSO.
