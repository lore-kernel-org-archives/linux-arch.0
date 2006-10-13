Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.ocs.com.au ([202.147.117.210]:45868 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750824AbWJMNoo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 13 Oct 2006 09:44:44 -0400
Received: from ocs3.ocs.com.au (ocs3w.ocs.com.au [192.168.254.3])
	by mail.ocs.com.au (Postfix) with ESMTP id 0389FE0B209
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:44:42 +1000 (EST)
Received: from ocs3.ocs.com.au (localhost [127.0.0.1])
	by ocs3.ocs.com.au (Postfix) with ESMTP id 4780681EE7
	for <linux-arch@vger.kernel.org>; Fri, 13 Oct 2006 23:45:05 +1000 (EST)
From: Keith Owens <kaos@sgi.com>
Subject: Re: [RFC] Common API for bring the system to a crash_stop state 
In-reply-to: Your message of "Fri, 13 Oct 2006 23:23:35 +1000."
             <26656.1160745815@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 13 Oct 2006 23:45:05 +1000
Message-ID: <9052.1160747105@ocs3.ocs.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Keith Owens (on Fri, 13 Oct 2006 23:23:35 +1000) wrote:
>The solution is to define a common crash_stop API that can be used by
>_all_ of the debug style tools, without reinventing the wheel each
>time.
>
>The following crash_stop patches will only appear on linux-arch.

Forgot to mention that these patches are against 2.6.19-rc1.  They will
have to change for 2.6.19-rc2 due to the pt_regs clean up.

