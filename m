Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:56835 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751838AbeEBX60 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 May 2018 19:58:26 -0400
Subject: Re: [PATCH] pkeys: Introduce PKEY_ALLOC_SIGNALINHERIT and change
 signal semantics
References: <20180502132751.05B9F401F3041@oldenburg.str.redhat.com>
 <248faadb-e484-806f-1485-c34a72a9ca0b@intel.com>
 <822a28c9-5405-68c2-11bf-0c282887466d@redhat.com>
 <57459C6F-C8BA-4E2D-99BA-64F35C11FC05@amacapital.net>
 <6286ba0a-7e09-b4ec-e31f-bd091f5940ff@redhat.com>
 <CALCETrVrm6yGiv6_z7RqdeB-324RoeMmjpf1EHsrGOh+iKb7+A@mail.gmail.com>
 <b2df1386-9df9-2db8-0a25-51bf5ff63592@redhat.com>
 <CALCETrW_Dt-HoG4keFJd8DSD=tvyR+bBCFrBDYdym4GQbfng4A@mail.gmail.com>
 <a37b7deb-7f5a-3dfa-f360-956cab8a813a@intel.com>
 <CALCETrUM7wWZh55gaLiAoPqtxLLUJ4QC8r8zj62E9avJ6ZVu0w@mail.gmail.com>
 <f9f7edc5-6426-91aa-f279-2f9f4671957a@intel.com>
 <2BE03B9A-B1E0-4707-8705-203F88B62A1C@amacapital.net>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cf71c470-9712-ce7c-a84a-f78468ebb4a8@intel.com>
Date: Wed, 2 May 2018 16:58:25 -0700
MIME-Version: 1.0
In-Reply-To: <2BE03B9A-B1E0-4707-8705-203F88B62A1C@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Florian Weimer <fweimer@redhat.com>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linuxram@us.ibm.com

On 05/02/2018 04:32 PM, Andy Lutomirski wrote:
>> But, where do those come from in this scenario?  I'm not getting
>> the secondary mechanism is that *makes* them unsafe.
> pkey_alloc() itself.  If someone tries to allocate a key with a given
> default mode, unless there’s already a key that already had that
> value in all threads or pkey_alloc() needs to asynchronously create
> such a key.

I think you are saying: If a thread calls pkey_alloc(), all threads
should, by default, implicitly get access.  That
broadcast-to-other-threads is the thing that the current architecture
doesn't do.  In this situation, CPU threads have to go opt-out of
getting access to data protected with a given, allocated key.

Right?
