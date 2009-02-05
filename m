Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60333 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761424AbZBEAnw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 4 Feb 2009 19:43:52 -0500
Message-ID: <498A3608.3010008@zytor.com>
Date: Wed, 04 Feb 2009 16:42:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: + preadv-pwritev-add-preadv-and-pwritev-system-calls.patch added
 to -mm tree
References: <200902022135.n12LZa1a010673@imap1.linux-foundation.org> <49876A91.4000705@zytor.com> <49881904.30705@redhat.com> <498879B3.8030002@zytor.com> <20090203171559.GA20898@flint.arm.linux.org.uk> <49887EF4.1090300@zytor.com> <20090203174257.GC20898@flint.arm.linux.org.uk>
In-Reply-To: <20090203174257.GC20898@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>, Gerd Hoffmann <kraxel@redhat.com>, akpm@linux-foundation.org, mm-commits@vger.kernel.org, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Message-ID: <20090205004248.8wDPOT4OcnY2PLLRskXFFoE_3FW1CgbXvL1GsROZMW0@z>

Russell King wrote:
> 
> This is an overly simplified view of things.  There exist syscalls where
> it's not just a matter of padding, but instead where the chosen argument
> order interacts with the ABI padding requirements to produce something
> which the syscall interface can't handle.  There are two solutions to
> that: reorder the syscall arguments or split them up into 32-bit high/low
> quantities.
> 

I just went back and looked specifically at this, and I wonder if you 
could be more concrete.  In particular, this seems to imply a rule 
somewhere which could probably be improved reasonably easily.

	-hpa

