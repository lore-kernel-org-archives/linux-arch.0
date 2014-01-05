From: Dave Hansen <dave@sr71.net>
Subject: Re: [PATCH 1/3] kconfig: consolidate arch-specific seccomp options
Date: Sat, 04 Jan 2014 16:41:31 -0800
Message-ID: <52C8AA3B.5010302@sr71.net>
References: <20140102202014.CA206E9B@viggo.jf.intel.com>	<20140105023853.dda6c1f9c6f9875159634e69@canb.auug.org.au>	<52C85B34.6040001@sr71.net> <20140105103353.9bf06782c851f8eaec0e0f33@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from www.sr71.net ([198.145.64.142]:36231 "EHLO blackbird.sr71.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754579AbaAEAlj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 4 Jan 2014 19:41:39 -0500
In-Reply-To: <20140105103353.9bf06782c851f8eaec0e0f33@canb.auug.org.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-arch@vger.kernel.org

On 01/04/2014 03:33 PM, Stephen Rothwell wrote:
>> I _believe_ the /proc interface has gone away.  I can't find any
>> reference to /proc/<pid>/seccomp in any of the code.  Is there some
>> /proc dependency that I'm missing outside of the removed
>> /proc/<pid>/seccomp interface?
> 
> I don't know, but if it has gone then it is worth mentioning in the
> commit message

Maybe like this? ;)

> There are 7 architecures with "config SECCOMP".  They all have
> virtually the same help text except for those referencing the
> /proc interface which was removed in 2007.

I guess I could call it out a _bit_ more clearly that I removed the
dependency because the code is gone.

> ... and you did preserve the dependency in the sparc64 case.

Ahh, I did.  I'll remove it.  Thanks!
