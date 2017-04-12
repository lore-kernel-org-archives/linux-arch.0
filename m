Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33944 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdDLLmL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 07:42:11 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: add VM_STATIC flag to vmalloc and prevent from removing the areas
From: Hoeun Ryu <hoeun.ryu@gmail.com>
In-Reply-To: <20170412060218.GA16170@infradead.org>
Date: Wed, 12 Apr 2017 20:42:08 +0900
Content-Transfer-Encoding: quoted-printable
Message-ID: <AC5E3048-6E2B-4DBE-80BA-AAE2D3EED969@gmail.com>
References: <1491973350-26816-1-git-send-email-hoeun.ryu@gmail.com> <20170412060218.GA16170@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andreas Dilger <adilger@dilger.ca>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Chris Wilson <chris@chris-wilson.co.uk>, Ingo Molnar <mingo@kernel.org>, zijun_hu <zijun_hu@htc.com>, Matthew Wilcox <mawilcox@microsoft.com>, Thomas Garnier <thgarnie@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20170412114208.CV8yeX_HHOaGMDexBtNVaj0qHkDiDnJP-SoNRUjcrcY@z>


> On Apr 12, 2017, at 3:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
>=20
>> On Wed, Apr 12, 2017 at 02:01:59PM +0900, Hoeun Ryu wrote:
>> vm_area_add_early/vm_area_register_early() are used to reserve vmalloc ar=
ea
>> during boot process and those virtually mapped areas are never unmapped.
>> So `OR` VM_STATIC flag to the areas in vmalloc_init() when importing
>> existing vmlist entries and prevent those areas from being removed from t=
he
>> rbtree by accident.
>=20
> How would they be removed "by accident"?

I don't mean actual use-cases, but I just want to make it robust against lik=
e programming errors.
