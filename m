Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn3nam01on0085.outbound.protection.outlook.com ([104.47.33.85]:11779
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725986AbeIHBes (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 7 Sep 2018 21:34:48 -0400
From: Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH v2 4/6] x86/alternatives: initializing temporary mm for
 patching
Date: Fri, 7 Sep 2018 20:52:04 +0000
Message-ID: <B41E8041-C4AD-4098-B0BA-665847F4A0F6@vmware.com>
References: <20180902173224.30606-1-namit@vmware.com>
 <20180902173224.30606-5-namit@vmware.com>
 <20180906090142.GG24082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180906090142.GG24082@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <099BF27455C18C4AB822FFF2F7FD03DF@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>
Message-ID: <20180907205204.WxnN6j6kfWJgE7QSETiAwJ-D2tyrdYpoOEpOhTsNalg@z>

at 2:01 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> On Sun, Sep 02, 2018 at 10:32:22AM -0700, Nadav Amit wrote:
>> +void __init poking_init(void)
>> +{
>> +	unsigned long poking_addr;
>> +
>> +	poking_mm =3D copy_init_mm();
>> +	if (!poking_mm) {
>> +		pr_err("x86/mm: error setting a separate poking address space");
>> +		return;
>> +	}
>> +
>> +	/*
>> +	 * Randomize the poking address, but make sure that the following page
>> +	 * will be mapped at the same PMD. We need 2 pages, so find space for =
3,
>> +	 * and adjust the address if the PMD ends after the first one.
>> +	 */
>> +	poking_addr =3D TASK_UNMAPPED_BASE +
>> +		(kaslr_get_random_long("Poking") & PAGE_MASK) %
>> +		(TASK_SIZE - TASK_UNMAPPED_BASE - 3 * PAGE_SIZE);
>> +
>> +	if (((poking_addr + PAGE_SIZE) & ~PMD_MASK) =3D=3D 0)
>> +		poking_addr +=3D PAGE_SIZE;
>> +}
>=20
> This fails to compile for me.. I don't have kaslr_get_random_long().

Will be fixed in v3. Thanks.
