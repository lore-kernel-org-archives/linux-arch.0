From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH -next] Documentation/vm: fix tables in
 arch_pgtable_helpers
Date: Wed, 8 Jul 2020 06:52:42 +0530
Message-ID: <b9dfad77-8dee-4628-a9f3-43417568a0e5@arm.com>
References: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <02ee60d0-e836-2237-4881-5c57ccac5551@infradead.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Mike Rapoport <rppt@kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org



On 07/08/2020 06:37 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make the tables be presented as tables in the generated output files
> (the line drawing did not present well).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  Documentation/vm/arch_pgtable_helpers.rst |  333 ++++++--------------
>  1 file changed, 116 insertions(+), 217 deletions(-)

Do you have a git URL some where to see these new output ? This
documentation is also useful when reading from a terminal where
these manual line drawing tables make sense.
