Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35239 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752423AbdKWX3V (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Nov 2017 18:29:21 -0500
Subject: Re: MPK: removing a pkey
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
 <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
 <f42fe774-bdcc-a509-bb7f-fe709fd28fcb@linux.intel.com>
 <9ec19ff3-86f6-7cfe-1a07-1ab1c5d9882c@redhat.com>
 <d98eb4b8-6e59-513d-fdf8-3395485cb851@linux.intel.com>
 <de93997a-7802-96cf-62e2-e59416e745ca@suse.cz>
 <17831167-7142-d42a-c7a0-59bdc8bbb786@linux.intel.com>
 <2d12777f-615a-8101-2156-cf861ec13aa7@suse.cz>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <8051353f-47d3-37a4-a402-41adc8b6eb88@linux.intel.com>
Date: Thu, 23 Nov 2017 15:29:20 -0800
MIME-Version: 1.0
In-Reply-To: <2d12777f-615a-8101-2156-cf861ec13aa7@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Florian Weimer <fweimer@redhat.com>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171123232920.agUBnNHFxZsCI4w2fk65Wj4DHIFi-gyZgdAhH4PxFeg@z>

On 11/23/2017 01:42 PM, Vlastimil Babka wrote:
>> It's supposed to set 0.
>>
>> -1 was, as far as I remember, an internal-to-the-kernel-only thing to
>> tell us that a key came from *mprotect()* instead of pkey_mprotect().
> So, pkey_mprotect(..., 0) will set it to 0, regardless of PROT_EXEC.

Although weird, the thought here was that pkey_mprotect() callers are
new and should know about the interactions with PROT_EXEC.  They can
also *get* PROT_EXEC semantics if they want.

The only wart here is if you do:

	mprotect(..., PROT_EXEC); // key 10 is now the PROT_EXEC key
	pkey_mprotect(..., PROT_EXEC, key=3);

I'm not sure what this does.  We should probably ensure that it returns
an error.

> pkey_mprotect(..., -1) or mprotect() will set it to 0-or-PROT_EXEC-pkey.
> 
> Can't shake the feeling that it's somewhat weird, but I guess it's
> flexible at least. So just has to be well documented.

It *is* weird.  But, layering on top of legacy APIs are often weird.  I
would have been open to other sane, but less weird ways to do it a year
ago. :)
