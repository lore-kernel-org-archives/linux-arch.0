From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCHv2 02/10] kernel: Provide READ_ONCE and ASSIGN_ONCE
Date: Tue, 25 Nov 2014 20:35:10 +0100
Message-ID: <5474D9EE.6070305@de.ibm.com>
References: <1416919117-50652-1-git-send-email-borntraeger@de.ibm.com> <1416919117-50652-3-git-send-email-borntraeger@de.ibm.com> <20141125155943.GB5050@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:34197 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaKYTfQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Nov 2014 14:35:16 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Tue, 25 Nov 2014 19:35:14 -0000
In-Reply-To: <20141125155943.GB5050@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: paulmck@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, mingo@kernel.org, torvalds@linux-foundation.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, David Howells <dhowells@redhat.com>, Russell King <linux@arm.linux.org.uk>

Am 25.11.2014 um 16:59 schrieb Paul E. McKenney:
> On Tue, Nov 25, 2014 at 01:38:29PM +0100, Christian Borntraeger wrote:
>> ACCESS_ONCE does not work reliably on non-scalar types. For
>> example gcc 4.6 and 4.7 might remove the volatile tag for such
>> accesses during the SRA (scalar replacement of aggregates) step
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145)
>>
>> Let's provide READ_ONCE/ASSIGN_ONCE that will do all accesses via
>> scalar types.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  include/linux/compiler.h | 34 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 34 insertions(+)
>>
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index d5ad7b1..0ff01f2 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -186,6 +186,40 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
>>  # define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __LINE__)
>>  #endif
>>
>> +#include <linux/types.h>
>> +
>> +static __always_inline void __assign_once_size(volatile void *p, void *res, int size)
>> +{
>> +	switch (size) {
>> +	case 1: *(volatile u8 *)p = *(u8 *)res; break;
>> +	case 2: *(volatile u16 *)p = *(u16 *)res; break;
>> +	case 4: *(volatile u32 *)p = *(u32 *)res; break;
>> +#ifdef CONFIG_64BIT
>> +	case 8: *(volatile u64 *)p = *(u64 *)res; break;
> 
> We really need something like this to catch invalid sizes:
> 
> 	default: invoke_nonexistent_function();
> 
> Of course, a BUILD_BUG_ON() would give a nicer error message.
> 
> Without this, in my testing, the following compiles without error, generating
> no code:
> 
> 	struct foo {
> 		int field[10];
> 	} f, f1;
> 
> 	f1 = READ_ONCE(f);
> 
> There is probably some better way to do this.

Yes, I was trying to do something for default, but we are in compiler.h and BUILD_BUG_ON etc are not defined. including other header files gave me some trouble, but doing it only inside the ifdef !assembly might work out (as I did with linux/types.h). 

The thing is this case was actually detected see the pmd_t compile error for m68k and sparc. Defining an extern function named read_once_called_for_large_object and then let the linker do the real work might work out as well.
