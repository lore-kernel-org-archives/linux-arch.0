Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58058 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751718AbZGJOjD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 10:39:03 -0400
Message-ID: <4A575202.40407@zytor.com>
Date: Fri, 10 Jul 2009 07:36:50 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit	 archs
References: <4A4A18780200007800008345@vpn.id2.novell.com> <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com> <200907092044.22108.rusty@rustcorp.com.au> <4A57089B0200007800009C0E@vpn.id2.novell.com>
In-Reply-To: <4A57089B0200007800009C0E@vpn.id2.novell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Michal Marek <mmarek@suse.cz>, Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Jon Masters <jonathan@jonmasters.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Message-ID: <20090710143650.2V0cvcUeqshc6KFcZPv8mmwQMkYMFSl2qCmW5Gm3RGw@z>

Jan Beulich wrote:
> 
> Actually I meanwhile think that module-init-tools can easily detect the changed
> layout without any further kernel side adjustments: Since it is known that a
> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
> value has more than 32 significant bits should suffice: If so, the new layout
> is being used (with the symbol name starting at offset 4), else the old one is
> in effect (name at offset 8). This ought to be a pretty trivial change to that
> code.
> 

If we're changing module-init-tools, it seems changing the section name
would be cleaner anyway.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

