From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
Date: Tue, 7 Jul 2020 19:06:52 -0700
Message-ID: <13943665-f1c8-dc34-37cc-a1f56ae57a5b@infradead.org>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
 <b9dfad77-8dee-4628-a9f3-43417568a0e5@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgGHCHA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2020 22:07:00 -0400
In-Reply-To: <b9dfad77-8dee-4628-a9f3-43417568a0e5@arm.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On 7/7/20 6:22 PM, Anshuman Khandual wrote:
> 
> 
> On 07/08/2020 06:37 AM, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Make the tables be presented as tables in the generated output files
>> (the line drawing did not present well).
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>>  1 file changed, 116 insertions(+), 217 deletions(-)
> 
> Do you have a git URL some where to see these new output ? This
> documentation is also useful when reading from a terminal where
> these manual line drawing tables make sense.
> 

No, I don't have a git URL.
You can go to
https://drive.google.com/file/d/1FO6lCRKldzESwLdylvY8tw10dOBvwz84/view?usp=sharing

I had to Download the file and then view it locally. I couldn't get Google Drive
to display it for me as html (only as text).

I understand about reading tables at a terminal.
This file could have been a txt file for that, but it's not. It's a RsT file.

If you want to leave it as is, please fix these warnings:

Documentation/vm/arch_pgtable_helpers.rst:24: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:28: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:32: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:36: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:40: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:44: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:48: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:52: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:56: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:60: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:64: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:68: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:72: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:76: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:88: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:92: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:96: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:100: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:104: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:108: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:112: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:116: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:120: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:124: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:128: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:132: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:136: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:140: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:144: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:148: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:152: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:162: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:166: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:170: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:174: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:178: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:182: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:186: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:190: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:194: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:198: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:202: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:206: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:218: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:222: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:226: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:230: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:234: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:244: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:248: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:252: WARNING: Line block ends without a blank line.
Documentation/vm/arch_pgtable_helpers.rst:256: WARNING: Line block ends without a blank line.


thanks.
-- 
~Randy
