Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17575 "EHLO mga02.intel.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1729518AbgA0Px1
 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jan 2020 10:53:27 -0500
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
Date: Mon, 27 Jan 2020 07:42:33 -0800
MIME-Version: 1.0
In-Reply-To: <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sandipan Das <sandipan@linux.ibm.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Message-ID: <20200127154233.0zpicrDQMtQksGcv3MXZFcqQlox-SYS6_Nj9Nf5adlI@z>

On 1/27/20 2:11 AM, Sandipan Das wrote:
> Hi Dave,
> 
> On 23/01/20 12:15 am, Dave Hansen wrote:
>> Still doesn't build for me:
>>
> I have this patch that hopefully fixes this. My understanding was
> that the vm tests are supposed to be generic but this has quite a
> bit of x86-specific conditional code which complicates things even
> though it is not used by any of the other tests.
> 
> I'm not sure if we should keep x86 multilib build support for these
> selftests but I'll let the maintainers take a call.

How have you tested this patch (and the whole series for that matter)?
