Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:1764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751921AbdKWPAg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Nov 2017 10:00:36 -0500
Subject: Re: MPK: removing a pkey
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
 <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
 <f42fe774-bdcc-a509-bb7f-fe709fd28fcb@linux.intel.com>
 <9ec19ff3-86f6-7cfe-1a07-1ab1c5d9882c@redhat.com>
 <d98eb4b8-6e59-513d-fdf8-3395485cb851@linux.intel.com>
 <de93997a-7802-96cf-62e2-e59416e745ca@suse.cz>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <17831167-7142-d42a-c7a0-59bdc8bbb786@linux.intel.com>
Date: Thu, 23 Nov 2017 07:00:32 -0800
MIME-Version: 1.0
In-Reply-To: <de93997a-7802-96cf-62e2-e59416e745ca@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Florian Weimer <fweimer@redhat.com>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171123150032.6F9mRf7_q1WiiAZ9RXfar-smfRX12vn3mXXCRoueN-w@z>

On 11/23/2017 12:11 AM, Vlastimil Babka wrote:
>> No, the default is clearly 0 and documented to be so.  The PROT_EXEC
>> emulation one should be inaccessible in all the APIs so does not even
>> show up as *being* a key in the API.  The fact that it's implemented
>> with pkeys should be pretty immaterial other than the fact that you
>> can't touch the high bits in PKRU.
> So, just to be sure, if we call pkey_mprotect() with 0, will it blindly
> set 0, or the result of arch_override_mprotect_pkey() (thus equivalent
> to call with -1) ? I assume the latter?

It's supposed to set 0.

-1 was, as far as I remember, an internal-to-the-kernel-only thing to
tell us that a key came from *mprotect()* instead of pkey_mprotect().
