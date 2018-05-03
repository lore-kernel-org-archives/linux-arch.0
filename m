Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42758 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750954AbeECOmf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 May 2018 10:42:35 -0400
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
 <cf71c470-9712-ce7c-a84a-f78468ebb4a8@intel.com>
 <AE502DA2-5B8E-4144-937F-E39DCCC57540@amacapital.net>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <63f948aa-17fe-9879-fbbc-7f2351e31028@redhat.com>
Date: Thu, 3 May 2018 16:42:32 +0200
MIME-Version: 1.0
In-Reply-To: <AE502DA2-5B8E-4144-937F-E39DCCC57540@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>, Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Linux-MM <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>, linux-x86_64@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linuxram@us.ibm.com

On 05/03/2018 03:14 AM, Andy Lutomirski wrote:
> No, I’m saying that all threads should get the*requested*  access.  If I’m protecting the GOT, I want all threads to get RO access. If I’m writing a crypto library, I probably want all threads to have no access.  If I’m writing a database, I probably want all threads to get RO by default.  If I’m writing some doodad to sandbox some carefully constructed code, I might want all threads to have full access by default.

Just a clarification: This key allocation issue is *not* a blocker for 
anything related to a safer GOT, or any other use of memory protection 
keys by the C implementation itself.  I agree that there could be 
application issues if threads are created early, but solving this issue 
in a general way appears to be quite costly.

Thanks,
Florian
