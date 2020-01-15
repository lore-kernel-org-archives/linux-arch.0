Return-Path: <owner-linux-mm@kvack.org>
Subject: Re: [PATCH v3 0/9] Fixup page directory freeing
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
 <20200114162526.87863ebce00695cc979b5217@linux-foundation.org>
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Date: Wed, 15 Jan 2020 20:17:24 +0530
MIME-Version: 1.0
In-Reply-To: <20200114162526.87863ebce00695cc979b5217@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-ID: <950b9610-30b9-a9ec-24e9-ca3fdec23199@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, will@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200115144724.af5cwtudf7pG32YKcooX7mD5xfk3g-9f4htbvZ6wwzA@z>

On 1/15/20 5:55 AM, Andrew Morton wrote:
> On Tue, 14 Jan 2020 15:31:36 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
>> This is a repost of patch series from Peter with the arch specific changes except ppc64 dropped.
>> ppc64 changes are added here because we are redoing the patch series on top of ppc64 changes. This makes it
>> easy to backport these changes. Only the first 3 patches need to be backported to stable.
> 
> But none of these patches had a cc:stable in the changelog?

Patch 2 mention

Fixes: a46cc7a90fd8 ("powerpc/mm/radix: Improve TLB/PWC flushes")

-aneesh
