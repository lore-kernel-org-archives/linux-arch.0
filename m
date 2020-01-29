Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH v16 00/23] selftests, powerpc, x86: Memory Protection Keys
From: Sandipan Das <sandipan@linux.ibm.com>
References: <cover.1579507768.git.sandipan@linux.ibm.com>
 <3ceb2814-f8b0-ec6b-3c24-ec72297a99f5@intel.com>
 <8f14bee0-ab1c-fc90-dfdb-5128607b767f@linux.ibm.com>
 <3eca7a91-aa3e-cb01-47c8-5d36020993a2@intel.com>
 <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Date: Wed, 29 Jan 2020 15:26:35 +0530
MIME-Version: 1.0
In-Reply-To: <fb83ce52-b92a-ed42-dc06-a86ca8431ff6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <3c7b6d98-da08-29c7-cd5b-39d2903b24a2@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: shuah@kernel.org, linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org, fweimer@redhat.com, x86@kernel.org, linuxram@us.ibm.com, mhocko@kernel.org, linux-mm@kvack.org, mingo@redhat.com, aneesh.kumar@linux.ibm.com, bauerman@linux.ibm.com, msuchanek@suse.de, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200129095635.69BaWhoPKXweSGKYnYfkp8UHnk-eSiCqodwbihKhaBk@z>

Hi Dave,

On 28/01/20 3:08 pm, Sandipan Das wrote:
> On 27/01/20 9:12 pm, Dave Hansen wrote:
>>
>> How have you tested this patch (and the whole series for that matter)?
>>
> 
> I replaced the second patch with this one and did a build test.
> Till v16, I had tested the whole series (build + run) on both a POWER8
> system (with 4K and 64K page sizes) and a Skylake SP system but for
> x86_64 only. Following that, I could only do a build test locally on
> my laptop for i386 and x86_64 on my laptop as I did not have access to
> the Skylake system anymore.
> 
> 

I got a chance to use the Skylake system today and tested (build + run)
the whole series (v17 with the fixed Makefile) for both i386 and x86_64.
Everything passed.

- Sandipan
