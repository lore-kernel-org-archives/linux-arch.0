Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45563 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfFCCWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 2 Jun 2019 22:22:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so9650643pfm.12
        for <linux-arch@vger.kernel.org>; Sun, 02 Jun 2019 19:22:03 -0700 (PDT)
Date: Mon, 03 Jun 2019 12:22:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/4] mm/large system hash: use vmalloc for size >
 MAX_ORDER when !hashdist
References: <20190528120453.27374-1-npiggin@gmail.com>
        <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
In-Reply-To: <CAHk-=whHWqVPWMeNRYuxAd8xnZscshoXUP8SFPmJivJfds5-HQ@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <1559527990.5jatqytnit.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-arch <linux-arch@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>, Toshi Kani <toshi.kani@hp.com>, Uladzislau Rezki <urezki@gmail.com>

Linus Torvalds's on June 1, 2019 4:30 am:
> On Tue, May 28, 2019 at 5:08 AM Nicholas Piggin <npiggin@gmail.com> wrote=
:
>>
>> The kernel currently clamps large system hashes to MAX_ORDER when
>> hashdist is not set, which is rather arbitrary.
>=20
> I think the *really* arbitrary part here is "hashdist".
>=20
> If you enable NUMA support, hashdist is just set to 1 by default on
> 64-bit, whether the machine actually has any numa characteristics or
> not. So you take that vmalloc() TLB overhead whether you need it or
> not.

Yeah, that's strange it seems to just be an oversight nobody ever
picked up. Patch 2/4 actually fixed that exactly the way you said.

>=20
> So I think your series looks sane, and should help the vmalloc case
> for big hash allocations, but I also think that this whole
> alloc_large_system_hash() function should be smarter in general.
>=20
> Yes, it's called "alloc_large_system_hash()", but it's used on small
> and perfectly normal-sized systems too, and often for not all that big
> hashes.
>=20
> Yes, we tend to try to make some of those hashes large (dentry one in
> particular), but we also use this for small stuff.
>=20
> For example, on my machine I have several network hashes that have
> order 6-8 sizes, none of which really make any sense to use vmalloc
> space for (and which are smaller than a large page, so your patch
> series wouldn't help).
>=20
> So on the whole I have no issues with this series, but I do think we
> should maybe fix that crazy "if (hashdist)" case. Hmm?

Yes agreed. Even after this series with 2MB mappings it's actually a bit=20
sad that we can't use the linear map for the non-NUMA case. My laptop=20
has a 32MB dentry cache and 16MB inode cache so doing a bunch of name=20
lookups is quite a waste of TLB entries (although at least with 2MB=20
pages it doesn't blow the TLB completely).

We might be able to go a step further and use memblock allocator for
those as well, or reserve some boot CMA for that common case ot just
use the linear map for these hashes. I'll look into that.

Thanks,
Nick

=
