Return-Path: <ak@suse.de>
Received: from ns.suse.de ([195.135.220.2]:10630 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263238AbUCTG3e (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 20 Mar 2004 01:29:34 -0500
Date: Sat, 20 Mar 2004 05:15:19 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: compat-signal-noarch-2004-01-29.patch again
Message-Id: <20040320051519.780318b8.ak@suse.de>
In-Reply-To: <20040319214949.6b7d50bc.akpm@osdl.org>
References: <20040319214949.6b7d50bc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, carlos@baldric.uwo.ca
List-ID: <linux-arch.vger.kernel.org>

On Fri, 19 Mar 2004 21:49:49 -0800
Andrew Morton <akpm@osdl.org> wrote:

> 
> This patch continues to hang around at Morton manor.  last time it was
> discussed Andi had issues with it and thing petered out.
> 
> Can we please wrap this up one ay or the other?

My only issue was the exporting of is_compat_task() to generic linux/compat.h
If that is fixed (the code that does the is_compat_task is moved to arch/* 
again) then the change is fine and I would also likely use it for x86-64.

-Andi
