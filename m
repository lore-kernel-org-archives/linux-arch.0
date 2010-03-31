From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 14:08:17 -0700
Message-ID: <4BB3B9C1.5000100@zytor.com>
References: <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <20100331210555.GA17715@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33670 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758186Ab0CaVM0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 17:12:26 -0400
In-Reply-To: <20100331210555.GA17715@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, cl@linux-founda

On 03/31/2010 02:05 PM, Russell King wrote:
> 
> We use the standard generic kernel implementation.  Is x86 different? ;)
> 

Yes, these are optimized on x86.

	-hpa
