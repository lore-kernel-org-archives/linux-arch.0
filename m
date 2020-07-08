From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
Date: Wed, 8 Jul 2020 10:39:38 +0530
Message-ID: <b738eae9-79b7-60d6-0d8e-0c57d23d4e41@arm.com>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
 <b9dfad77-8dee-4628-a9f3-43417568a0e5@arm.com>
 <13943665-f1c8-dc34-37cc-a1f56ae57a5b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:42080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgGHFKM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 8 Jul 2020 01:10:12 -0400
In-Reply-To: <13943665-f1c8-dc34-37cc-a1f56ae57a5b@infradead.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>



On 07/08/2020 07:36 AM, Randy Dunlap wrote:
> On 7/7/20 6:22 PM, Anshuman Khandual wrote:
>>
>>
>> On 07/08/2020 06:37 AM, Randy Dunlap wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>
>>> Make the tables be presented as tables in the generated output files
>>> (the line drawing did not present well).
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Cc: Jonathan Corbet <corbet@lwn.net>
>>> Cc: linux-doc@vger.kernel.org
>>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>>> Cc: Mike Rapoport <rppt@kernel.org>
>>> Cc: linux-arch@vger.kernel.org
>>> Cc: linux-mm@kvack.org
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> ---
>>>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>>>  1 file changed, 116 insertions(+), 217 deletions(-)
>>
>> Do you have a git URL some where to see these new output ? This
>> documentation is also useful when reading from a terminal where
>> these manual line drawing tables make sense.
>>
> 
> No, I don't have a git URL.
> You can go to
> https://drive.google.com/file/d/1FO6lCRKldzESwLdylvY8tw10dOBvwz84/view?usp=sharing
> 
> I had to Download the file and then view it locally. I couldn't get Google Drive
> to display it for me as html (only as text).

I could see it locally as well on a browser and the table looks the same
way like those current manual ones on a terminal, so looks good to me.

> 
> I understand about reading tables at a terminal.
> This file could have been a txt file for that, but it's not. It's a RsT file.

Thats right. All files in Documentation/vm/ are .rst type, hence would
not like to have a .txt type in there.

> 
> If you want to leave it as is, please fix these warnings:

Thats right. Can not have in both ways. Lets stick with .rst and change
as required.
