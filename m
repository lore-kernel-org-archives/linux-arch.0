From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] arch: x86: include: asm: need 'unsigned' type cast for
 atomic_clear_mask()
Date: Sat, 08 Jun 2013 00:31:19 -0700
Message-ID: <51B2DDC7.4070107@zytor.com>
References: <51B2CF75.1090207@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60120 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282Ab3FHHcD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 8 Jun 2013 03:32:03 -0400
In-Reply-To: <51B2CF75.1090207@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, shli@fusionio.com, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/07/2013 11:30 PM, Chen Gang wrote:
> 
> atomic_set_mask() has already have 'unsigned' type case, and
> atomic_clear_mask() is the pair of atomic_set_mask().
> 
> So it also need 'unsigned' type case.
> 

Pray tell, in what situation does this matter?  The only reason I can
think of is if "mask" is actually a long...

	-hpa
