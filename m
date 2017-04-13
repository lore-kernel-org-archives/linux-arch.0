Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33741 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbdDMBDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 21:03:22 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mm: add VM_STATIC flag to vmalloc and prevent from
 removing the areas
From: Ho-Eun Ryu <hoeun.ryu@gmail.com>
In-Reply-To: <20170412173151.GA23054@infradead.org>
Date: Thu, 13 Apr 2017 10:03:14 +0900
Content-Transfer-Encoding: quoted-printable
Message-ID: <3F99A1DC-3DEF-4EEB-AD6E-7848D7A6049D@gmail.com>
References: <1491973350-26816-1-git-send-email-hoeun.ryu@gmail.com>
 <20170412060218.GA16170@infradead.org>
 <AC5E3048-6E2B-4DBE-80BA-AAE2D3EED969@gmail.com>
 <20170412173151.GA23054@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andreas Dilger <adilger@dilger.ca>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Chris Wilson <chris@chris-wilson.co.uk>, Ingo Molnar <mingo@kernel.org>, zijun_hu <zijun_hu@htc.com>, Matthew Wilcox <mawilcox@microsoft.com>, Thomas Garnier <thgarnie@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20170413010314.b1caFi-v-HoG2ad3-LIl4RDheOZVFUbZ9bdjaP_gr3o@z>


> On 13 Apr 2017, at 2:31 AM, Christoph Hellwig <hch@infradead.org> =
wrote:
>=20
> On Wed, Apr 12, 2017 at 08:42:08PM +0900, Hoeun Ryu wrote:
>>=20
>>> On Apr 12, 2017, at 3:02 PM, Christoph Hellwig <hch@infradead.org> =
wrote:
>>>=20
>>>> On Wed, Apr 12, 2017 at 02:01:59PM +0900, Hoeun Ryu wrote:
>>>> vm_area_add_early/vm_area_register_early() are used to reserve =
vmalloc area
>>>> during boot process and those virtually mapped areas are never =
unmapped.
>>>> So `OR` VM_STATIC flag to the areas in vmalloc_init() when =
importing
>>>> existing vmlist entries and prevent those areas from being removed =
from the
>>>> rbtree by accident.
>>>=20
>>> How would they be removed "by accident"?
>>=20
>> I don't mean actual use-cases, but I just want to make it robust =
against like programming errors.
>=20
> Oh, ok.  The patch makes sense then, although the changelog could use
> a little update.

OK, I will.
Any other suggestions for code itself ?
