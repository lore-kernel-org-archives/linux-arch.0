Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45931 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S939365AbXGTRip (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 20 Jul 2007 13:38:45 -0400
Message-ID: <46A0F301.4020703@zytor.com>
Date: Fri, 20 Jul 2007 10:38:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: build fix for x86_64...
References: <617E1C2C70743745A92448908E030B2A01FA46A9@scsmsx411.amr.corp.intel.com> <46A0EAC8.9020203@zytor.com> <200707201925.12036.ak@suse.de>
In-Reply-To: <200707201925.12036.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, Randy Dunlap <randy.dunlap@oracle.com>, Andi Kleen <ak@novell.com>, Arthur Jones <arthur.jones@qlogic.com>, Vasily Tarasov <vtaras@openvz.org>, linux-kernel@vger.kernel.org, Jan Kara <jack@ucw.cz>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andi Kleen wrote:
> 
> That doesn't help for any old interfaces, like the one here. For those
> still ifdefs are needed. Interfaces that use compat_u64 just use
> a normal #ifdef CONFIG_COMPAT.
> 
> Besides I have my doubts compat_u64 will be the solution
> to these worries. We have hundreds of people adding various interfaces
> to Linux and it's unlikely they all heard about it. So likely
> these cases will occur again and again.
> 

Of course they will.  compat_u64 will have no effect on a properly
designed interface where everything is aligned.

To me, the whole point with compat_u64 is that when someone has designed
an interface improperly (so it's alignment-dependent) then we can
replace u64 with compat_u64 and use the same structure on 64 bits even
though the original interface was broken.

	-hpa
