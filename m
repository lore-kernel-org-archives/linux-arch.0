From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/6] improve sys_personality for compat architectures
Date: Wed, 03 Feb 2010 09:13:09 -0800 (PST)
Message-ID: <20100203.091309.52886984.davem@davemloft.net>
References: <201002021536.51928.arnd@arndb.de>
	<20100202163145.GA30659@lst.de>
	<201002031806.27423.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60144
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757427Ab0BCRM4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2010 12:12:56 -0500
In-Reply-To: <201002031806.27423.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: hch@lst.de, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tony.luck@intel.com, ralf@linux-mips.org, kyle@mcmartin.ca, benh@kernel.crashing.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, viro@zeniv.linux.org.uk

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 3 Feb 2010 18:06:27 +0100

>> But if the consensus is that we should fix this properly I can
>> replace the patch with one introducing a compat_sys_personality
>> which only gets used for compat tasks.
> 
> Right now, sparc64 and powerpc64 use sys32_personality for both native
> and compat tasks, x86 never uses it and all others use it only for
> compat tasks. That seems more sensible if we keep this function at
> all.

If it only gets used for compat tasks, you can only switch in
one direction.  I think it needs to be handled for both compat
and non-compat tasks, in order to allow for that.

That's why powerpc64 and sparc64 do things the way they do,
I am pretty sure.
