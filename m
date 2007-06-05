Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([192.83.249.54]:41476 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbXFEAGX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jun 2007 20:06:23 -0400
Message-ID: <4664A87C.5040609@zytor.com>
Date: Mon, 04 Jun 2007 17:04:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: 64-bit syscall ABI issue
References: <Pine.LNX.4.64.0706042051280.16431@digraph.polyomino.org.uk> <20070604.142557.68139332.davem@davemloft.net>
In-Reply-To: <20070604.142557.68139332.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: joseph@codesourcery.com, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Miller wrote:
> From: "Joseph S. Myers" <joseph@codesourcery.com>
> Date: Mon, 4 Jun 2007 20:56:57 +0000 (UTC)
> 
> [ added linux-arch which is a great place to discuss these
>   kinds of issues. ]
> 
>> What should the kernel syscall ABI be in such cases (any case where the 
>> syscall implementations expect arguments narrower than registers, so 
>> mainly 32-bit arguments on 64-bit platforms)?  There are two obvious 
>> possibilities:
> 
> In general we've taken the stance that the syscall dispatch
> should create the proper calling environment for C code
> implementing the system calls, and this thus means properly
> sign and zero extending the arguments as expected by the C
> calling convention.

This is, in fact, rather fundamental (some ABIs don't require sign or
zero extension, e.g. x86-64); otherwise libc's job becomes a whole lot
harder.

	-hpa
