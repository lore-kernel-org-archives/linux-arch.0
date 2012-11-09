From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 12/40] metag: Build infrastructure
Date: Fri, 9 Nov 2012 14:55:40 +0000
Message-ID: <509D196C.1060407@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <1351700061-7203-13-git-send-email-james.hogan@imgtec.com> <201211091446.28068.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:54480 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753497Ab2KIOzn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Nov 2012 09:55:43 -0500
In-Reply-To: <201211091446.28068.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

On 09/11/12 14:46, Arnd Bergmann wrote:
> On Wednesday 31 October 2012, James Hogan wrote:
>> diff --git a/arch/metag/include/asm/Kbuild b/arch/metag/include/asm/Kbuild
>> new file mode 100644
>> index 0000000..1678d85
>> --- /dev/null
>> +++ b/arch/metag/include/asm/Kbuild
>> @@ -0,0 +1,59 @@
>> +include include/asm-generic/Kbuild.asm
>> +
>> +header-y += tbx/
>> +
>> +header-y += hw_breakpoints.h
>> +
>> +generic-y += auxvec.h
>> +generic-y += bitsperlong.h
>> +generic-y += bugs.h
>> +generic-y += cputime.h
>> +generic-y += current.h
> 
> The header files will have to change now for the UAPI split, see the discussion
> about the same thing for the ARC architecture.

Yes, I've managed to do the UAPI split now (thanks to some help from
David Howells), so the next version will be based on at least v3.7-rc4
and have the split combined in.

Thanks
James
