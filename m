Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33238
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751035AbWAIJDw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jan 2006 04:03:52 -0500
Date: Mon, 09 Jan 2006 01:03:55 -0800 (PST)
Message-Id: <20060109.010355.69867251.davem@davemloft.net>
Subject: Re: Adding compat_ptrace_request
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060109065914.GS26499@krispykreme>
References: <20060109065914.GS26499@krispykreme>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: anton@samba.org
Cc: linux-arch@vger.kernel.org, sfr@canb.auug.org.au
List-ID: <linux-arch.vger.kernel.org>

From: Anton Blanchard <anton@samba.org>
Date: Mon, 9 Jan 2006 17:59:14 +1100

> We noticed 32/64bit compat issues with GETSIGINFO and SETSIGINFO. It
> looks like s390 are already fixing this up in architecture specific
> code, but here is a patch from Stephen Rothwell to add some generic
> compat ptrace helpers.
> 
> Look OK? 

Looks not too bad, although...

> +		return copy_siginfo_to_user32(data, &lastinfo);

It would be nice to rename this copy_siginfo things to not
have "32" and instead "compat" in their names.
