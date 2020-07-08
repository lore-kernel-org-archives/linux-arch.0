From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
Date: Wed, 8 Jul 2020 06:21:04 -0700
Message-ID: <7d43f116-51f0-8cab-f8ee-ea9387039d1d@infradead.org>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
 <20200708064332.GD128651@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200708064332.GD128651@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Anshuman Khandual <anshuman.khandual@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 7/7/20 11:43 PM, Mike Rapoport wrote:
> Hi Randy,
> 
> On Tue, Jul 07, 2020 at 06:07:40PM -0700, Randy Dunlap wrote:
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
>>
>> --- linux-next-20200707.orig/Documentation/vm/arch_pgtable_helpers.rst
>> +++ linux-next-20200707/Documentation/vm/arch_pgtable_helpers.rst
>> @@ -17,242 +17,141 @@ test need to be in sync.
>>  PTE Page Table Helpers
>>  ======================
>>  
>> ---------------------------------------------------------------------------------
>> -| pte_same                  | Tests whether both PTE entries are the same      |
>> ---------------------------------------------------------------------------------
> 
> According to ReST docs [1] we can use +---+---+ as row delimiter and
> than we can keep | as column delimiter.
> 
> @Andrew, can you please fold the below patch into Anshuman's original
> patch?
> 
> [1] https://docutils.sourceforge.io/docs/user/rst/quickref.html#tables

Works for me. Thanks.

-- 
~Randy
