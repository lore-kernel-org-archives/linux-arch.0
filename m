From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 1/8] bootmem: Replace work_with_active_regions() with
 for_each_mem_pfn_range()
Date: Thu, 14 Jul 2011 09:44:55 +0200
Message-ID: <20110714074455.GC3455@htj.dyndns.org>
References: <1310460395-30913-1-git-send-email-tj@kernel.org>
 <1310460395-30913-2-git-send-email-tj@kernel.org>
 <4E1E5058.5020702@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:53025 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753761Ab1GNHpA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 14 Jul 2011 03:45:00 -0400
Content-Disposition: inline
In-Reply-To: <4E1E5058.5020702@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, yinghai@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On Wed, Jul 13, 2011 at 07:11:36PM -0700, H. Peter Anvin wrote:
> On 07/12/2011 01:46 AM, Tejun Heo wrote:
> > Callback based iteration is cumbersome and much less useful than
> > for_each_*() iterator.  This patch implements for_each_mem_pfn_rang=
e()
> > which replaces work_with_active_regions().  All the current users o=
f
> > work_with_active_regions() are converted.
> >=20
> > This simplifies walking over early_node_map and will allow converti=
ng
> > internal logics in page_alloc to use iterator instead of walking
> > early_node_map directly, which in turn will enable moving node
> > information to memblock.
> >=20
> > powerpc change is only compile tested.
> >=20
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > Cc: Yinghai Lu <yinghai@kernel.org>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> This patch causes a build failure on x86-64 with the attached .config=
:
>=20
> /home/hpa/kernel/linux-2.6-tip.memblock/drivers/pci/intel-iommu.c: In
> function =E2=80=98si_domain_init=E2=80=99:
> /home/hpa/kernel/linux-2.6-tip.memblock/drivers/pci/intel-iommu.c:221=
6:4: error:
> implicit declaration of function =E2=80=98iommuc_domain_identity_map=E2=
=80=99
> [-Werror=3Dimplicit-function-declaration]
> cc1: some warnings being treated as errors

It was a typo that I fixed before sending the patches but obviously I
sent the old one.  The git tree had the updated one.  I'll re-post the
updated one.

Thank you.

--=20
tejun
