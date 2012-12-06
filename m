From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 12/44] metag: TBX source
Date: Thu, 6 Dec 2012 15:03:49 +0000
Message-ID: <50C0B3D5.50707@imgtec.com>
References: <1354723742-6195-1-git-send-email-james.hogan@imgtec.com>  <1354723742-6195-13-git-send-email-james.hogan@imgtec.com>  <1354733607.8320.3.camel@joe-AO722> <50C066D9.9010700@imgtec.com> <1354798778.17565.8.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56806 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423662Ab2LFPDw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Dec 2012 10:03:52 -0500
In-Reply-To: <1354798778.17565.8.camel@joe-AO722>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 06/12/12 12:59, Joe Perches wrote:
> On Thu, 2012-12-06 at 09:35 +0000, James Hogan wrote:
>> On 05/12/12 18:53, Joe Perches wrote:
>>> On Wed, 2012-12-05 at 16:08 +0000, James Hogan wrote:
>>>> Add source files from the Thread Binary Interface (TBI) library which
>>>> provides useful low level operations and traps/context management.
>>> []
>>>>  arch/metag/tbx/tbicache.c  |  462 ++++++++++++++++++++++++++++++++++++++++++++
>>>
>>> Could you please run checkpatch on this file?
>>
>> Hi Joe,
>>
>> Thanks for taking a look.
>>
>> I'd prefer to avoid making style modifications to the tbx/ files if
>> possible to ease maintenance, as the code is shared with other projects
>> and maintained by a separate group.
>>
>> Of course if cleaning up the style is deemed absolutely necessary then
>> so be it.
> 
> Your choice though the file looks to me to be linux
> specific as it uses #include <linux/stddef.h>

Yes, I have rearranged the TBX headers and includes a bit, including
this one to get the definition of NULL, but have avoided making changes
to the actual code so far.

> 
> Also, two functions, __TBIDataCacheFlush and
> __TBICodeCacheFlush, have an unnecessary indentation
> level after a test and return.

> void __TBICodeCacheFlush( const void *pStart, int Bytes )
> {
> 	volatile int *pCtrl = (volatile int *) SYSC_CACHE_MMU_CONFIG;
> 
> 	if ( !__TBICacheDoneInit )
> 		__TBICacheInit();
> 
> 	if ( (pCtrl[0] & SYSC_CMMUCFG_IC_ON_BIT) == 0 )
> 	{
> 		/* No need to flush the code cache it's not actually enabled */
> 		return;
> 	} 
> 
> 	{
> 		/* Use a sequence of writes to flush the cache region requested */	
> 		int Loops, Step;
> 
> 		etc.
> 
> I believe the automatics in the second blocks should
> be moved to the start of the function and the
> unnecessary braces and extra indentation removed.
> 

TBI_GETREG reads a control register so the compiler won't be able to
move it, so these should probably be kept in the same order, but yes I
agree with moving the declarations to the top and getting rid of the
extra indentation.

tbh since there are only 2 tbx/*.c files and they're both small, I'll
clean them both up properly.

Thanks
James
