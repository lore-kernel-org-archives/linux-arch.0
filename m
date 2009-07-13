From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] reduce export symbol CRC table size on 64-bit	
	 archs
Date: Mon, 13 Jul 2009 09:44:46 +0100
Message-ID: <4A5B101E020000780000A284@vpn.id2.novell.com>
References: <4A4A18780200007800008345@vpn.id2.novell.com>
 <4A4E671C.2090201@suse.cz> <4A51C71B0200007800008EE2@vpn.id2.novell.com>
 <200907092044.22108.rusty@rustcorp.com.au>
 <4A57089B0200007800009C0E@vpn.id2.novell.com> <4A5AEC3C.2060608@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:28955 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZGMIoy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2009 04:44:54 -0400
In-Reply-To: <4A5AEC3C.2060608@suse.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: Ingo Molnar <mingo@elte.hu>, tony.luck@intel.com, Jon Masters <jonathan@jonmasters.org>, Thomas Gleixner <tglx@linutronix.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, hpa@zytor.com

>>> Michal Marek <mmarek@suse.cz> 13.07.09 10:11 >>>
>Jan Beulich napsal(a):
>> Actually I meanwhile think that module-init-tools can easily detect the changed
>> layout without any further kernel side adjustments: Since it is known that a
>> CRC always is a 32-bit value, simply checking whether the so-far-used 64-bit
>> value has more than 32 significant bits should suffice: If so, the new layout
>> is being used (with the symbol name starting at offset 4), else the old one is
>> in effect (name at offset 8). This ought to be a pretty trivial change to that
>> code.
>
>But old module-init-tools will continue reading garbage in this case.

And would you think returning nothing is significantly better than returning
garbage?

Jan
