From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Generic syscall ABI support
Date: Wed, 27 Mar 2013 22:35:20 -0700
Message-ID: <5153D698.6010102@zytor.com>
References: <1364440182.2289.45.camel@leyfoon-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48362 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab3C1Ffh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 28 Mar 2013 01:35:37 -0400
In-Reply-To: <1364440182.2289.45.camel@leyfoon-vm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org

On 03/27/2013 08:09 PM, Ley Foon Tan wrote:
> Need advise regarding the generic syscall ABI support.
> 
> We are planning to upstream our Nios II kernel (arch/nios2) to mainline.
> But it doesn't support generic syscall ABI yet (It requires an updated
> Glibc port as well). 
> 
> The question is, is it a requirement for new arch to support generic
> syscall ABI when upstreaming? Can we upstream a non-generic syscall ABI
> first and migrate to generic syscall ABI in future?
> Thanks.
> 
> Regards
> LFTAN
> 

That would be extremely difficult.

In general, you should use the generic ABI for a new port unless you
have *very* strong and convincing reasons not to.

Given how long the Nios2 port has been in upstreaming (unfortunate, I
like to play with FPGAs ;) it seems worthwhile to adjust it before
pushing it.

	-hpa
