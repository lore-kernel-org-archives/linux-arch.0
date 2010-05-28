From: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] arch/tile: new multi-core architecture for Linux
Date: Fri, 28 May 2010 13:58:20 -0400
Message-ID: <4C00043C.5030804@tilera.com>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com> <201005271041.30519.arnd@arndb.de> <4BFE73DF.5090107@tilera.com> <201005271611.47963.arnd@arndb.de> <522C1DF17AF50042AD8AE87F7887BD3D01637144CA@exch.hq.tensilica.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from king.tilera.com ([72.1.168.226]:7758 "EHLO king.tilera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751121Ab0E1R6Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 28 May 2010 13:58:25 -0400
In-Reply-To: <522C1DF17AF50042AD8AE87F7887BD3D01637144CA@exch.hq.tensilica.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Gauthier <marc@tensilica.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 5/27/2010 10:52 AM, Marc Gauthier wrote:
>>> We use [a syscall] not for the floating-point operations, but for integer
>>> divide-by-zero.  In principle we could use it for floating-point too,
>>> but we currently don't, since generally folks don't expect it there.
>>>       
>> Ah, I see. That probably makes a lot of sense to present as a signal
>> the way you do.
>>     
> FWIW, this can also be done using some recognizable illegal
> instruction sequence, if the architecture reserves some opcodes
> as always illegal.

We do reserve a range of illegal values, and this is a great idea.  I've
removed the syscall from our kernel, and will add support for the
appropriate magic in the trap handler once we pick an encoding and give
it a name in the assembler.

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
