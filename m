From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: MPK: removing a pkey
Date: Wed, 22 Nov 2017 08:10:10 -0800
Message-ID: <f42fe774-bdcc-a509-bb7f-fe709fd28fcb@linux.intel.com>
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
 <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:31085 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751617AbdKVQKO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Nov 2017 11:10:14 -0500
In-Reply-To: <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Florian Weimer <fweimer@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>

On 11/22/2017 04:15 AM, Florian Weimer wrote:
> On 11/22/2017 09:18 AM, Vlastimil Babka wrote:
>> And, was the pkey == -1 internal wiring supposed to be exposed to the
>> pkey_mprotect() signal, or should there have been a pre-check returning
>> EINVAL in SYSCALL_DEFINE4(pkey_mprotect), before calling
>> do_mprotect_pkey())? I assume it's too late to change it now anyway (or
>> not?), so should we also document it?
> 
> I think the -1 case to the set the default key is useful because it
> allows you to use a key value of -1 to mean “MPK is not supported”, and
> still call pkey_mprotect.

The behavior to not allow 0 to be set was unintentional and is a bug.
We should fix that.
