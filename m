From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: x86: include: asm: need 'unsigned' type cast for
 atomic_clear_mask()
Date: Sat, 08 Jun 2013 16:02:05 +0800
Message-ID: <51B2E4FD.4000708@asianux.com>
References: <51B2CF75.1090207@asianux.com> <51B2DDC7.4070107@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:61366 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3FHIDW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jun 2013 04:03:22 -0400
In-Reply-To: <51B2DDC7.4070107@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, shli@fusionio.com, "dhowells@redhat.com" <dhowells@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/08/2013 03:31 PM, H. Peter Anvin wrote:
> On 06/07/2013 11:30 PM, Chen Gang wrote:
>> > 
>> > atomic_set_mask() has already have 'unsigned' type case, and
>> > atomic_clear_mask() is the pair of atomic_set_mask().
>> > 
>> > So it also need 'unsigned' type case.
>> > 
> Pray tell, in what situation does this matter?  The only reason I can
> think of is if "mask" is actually a long...

Excuse me, in fact, I don't know whether it will cause issue. Since
atomic_set_mask() has done, I think atomic_clear_mask() also need it.

If atomic_clear_mask() do need it, the atomic_set_mask() do not need it
either, they are the pairs --> they will face the same situation.


Thanks.
-- 
Chen Gang

Asianux Corporation
