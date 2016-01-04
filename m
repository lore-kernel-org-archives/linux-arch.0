From: Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v2 14/16] x86,nvdimm,kexec: Use walk_iomem_res_desc() for
 iomem search
Date: Mon, 4 Jan 2016 19:04:27 +0800
Message-ID: <20160104110427.GA2965@dhcp-128-65.nay.redhat.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
 <1451081365-15190-14-git-send-email-toshi.kani@hpe.com>
 <20160104092545.GA7033@dhcp-128-65.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48446 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751455AbcADLEl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 4 Jan 2016 06:04:41 -0500
Content-Disposition: inline
In-Reply-To: <20160104092545.GA7033@dhcp-128-65.nay.redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: akpm@linux-foundation.org, bp@alien8.de, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, x86@kernel.org, linux-nvdimm@ml01.01.org, kexec@lists.infradead.org

On 01/04/16 at 05:25pm, Dave Young wrote:
> Hi, Toshi,
>=20
> On 12/25/15 at 03:09pm, Toshi Kani wrote:
> > Change to call walk_iomem_res_desc() for searching resource entries
> > with the following names:
> >  "ACPI Tables"
> >  "ACPI Non-volatile Storage"
> >  "Persistent Memory (legacy)"
> >  "Crash kernel"
> >=20
> > Note, the caller of walk_iomem_res() with "GART" is left unchanged
> > because this entry may be initialized by out-of-tree drivers, which
> > do not have 'desc' set to IORES_DESC_GART.
>=20
> Found below commit which initialize the GART entry:
> commit 56dd669a138c40ea6cdae487f233430d12372767
> Author: Aaron Durbin <adurbin@google.com>
> Date:   Tue Sep 26 10:52:40 2006 +0200
>=20
>     [PATCH] Insert GART region into resource map
>    =20
>     Patch inserts the GART region into the iomem resource map. The GA=
RT will then
>     be visible within /proc/iomem. It will also allow for other users
>     utilizing the GART to subreserve the region (agp or IOMMU).
>    =20
>     Signed-off-by: Aaron Durbin <adurbin@google.com>
>=20
> But later it was reverted:
> commit 707d4eefbdb31f8e588277157056b0ce637d6c68
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Tue Mar 18 14:26:12 2014 -0600
>=20
>     Revert "[PATCH] Insert GART region into resource map"
>    =20
>     This reverts commit 56dd669a138c, which makes the GART visible in
>     /proc/iomem.  This fixes a regression: e501b3d87f00 ("agp: Suppor=
t 64-bit
>     APBASE") exposed an existing problem with a conflict between the =
GART
>     region and a PCI BAR region.
>    =20
>     The GART addresses are bus addresses, not CPU addresses, and ther=
efore
>     should not be inserted in iomem_resource.
>    =20
>     On many machines, the GART region is addressable by the CPU as we=
ll as by
>     an AGP master, but CPU addressability is not required by the spec=
=2E  On some
>     of these machines, the GART is mapped by a PCI BAR, and in that c=
ase, the
>     PCI core automatically inserts it into iomem_resource, just as it=
 does for
>     all BARs.
>    =20
>     Inserting it here means we'll have a conflict if the PCI core lat=
er tries
>     to claim the GART region, so let's drop the insertion here.
>    =20
>     The conflict indirectly causes X failures, as reported by Jouni i=
n the
>     bugzilla below.  We detected the conflict even before e501b3d87f0=
0, but
>     after it the AGP code (fix_northbridge()) uses the PCI resource (=
which is
>     zeroed because of the conflict) instead of reading the BAR again.
>    =20
>     Conflicts:
>         arch/x86_64/kernel/aperture.c
>    =20
>     Fixes: e501b3d87f00 agp: Support 64-bit APBASE
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D72201
>     Reported-and-tested-by: Jouni Mett=E4l=E4 <jtmettala@gmail.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
>=20
> For amd64 agp, currently the region name is "aperture" instead:
> drivers/char/agp/amd64-agp.c: agp_aperture_valid()
>=20
> This may not be the only case, but I doubt that anyone is testing thi=
s since
> long time ago kexec-tools excluding the 'GART' region. Kexec-tools an=
d kexec_file
> may need update to use "aperture" if someone can test it.
>=20
> I think adding an enum value for compatibility is reasonable, we do n=
ot care
> about third party drivers in mainline.

Hmm, rethink about it, the new kernel will not export "GART" regions th=
us the in-kernel loader should never see such regions as long as there'=
s no other drivers exporting it. Thus dropping the code chunk in crash.=
c about 'GART' should be fine.

Thanks
Dave
