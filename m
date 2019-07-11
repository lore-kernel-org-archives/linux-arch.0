Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38504 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfGKKdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jul 2019 06:33:03 -0400
Date: Thu, 11 Jul 2019 20:30:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC PATCH] mm: remove quicklist page table caches
References: <20190711030339.20892-1-npiggin@gmail.com>
        <20190711082539.GC29483@dhcp22.suse.cz>
In-Reply-To: <20190711082539.GC29483@dhcp22.suse.cz>
MIME-Version: 1.0
Message-Id: <1562840680.snxfuzmtxv.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Christoph Lameter <cl@linux.com>, linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mm@kvack.org, linux-sh@vger.kernel.org

Michal Hocko's on July 11, 2019 6:25 pm:
> On Thu 11-07-19 13:03:39, Nicholas Piggin wrote:
>> Remove page table allocator "quicklists". These have been around for a
>> long time, but have not got much traction in the last decade and are
>> only used on ia64 and sh architectures.
>>=20
>> The numbers in the initial commit look interesting but probably don't
>> apply anymore. If anybody wants to resurrect this it's in the git
>> history, but it's unhelpful to have this code and divergent allocator
>> behaviour for minor archs.
>>=20
>> Also it might be better to instead make more general improvements to
>> page allocator if this is still so slow.
>=20
> Agreed. And if that is not possible for whatever reason then we have a
> proper justification for the revert at least.
>=20
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks. If it's agreed with ia64 and sh maintainers, I can send
individual patches through their trees, then the removal patch
will be functionally a nop that can be easily pushed through.

Thanks,
Nick
=
