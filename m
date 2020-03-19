From: Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register access
 functions
Date: Thu, 19 Mar 2020 21:04:58 +0000
Message-ID: <MW2PR2101MB1052AAC1EE6AC082C9ED6779D7F40@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <20200318031130.5476-1-hdanton@sina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn8nam11on2123.outbound.protection.outlook.com ([40.107.236.123]:34400
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgCSVFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Mar 2020 17:05:02 -0400
In-Reply-To: <20200318031130.5476-1-hdanton@sina.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org" <maz@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, vkuznets <vkuznets@redhat.com>, "jasowang@redhat.com" <jasowang@redha>

From: Hillf Danton <hdanton@sina.com> Sent: Tuesday, March 17, 2020 8:12 PM
>=20
> On Sat, 14 Mar 2020 08:35:12 -0700 Michael Kelley wrote:
> > +/*
> > + * Get the value of a single VP register.  One version
> > + * returns just 64 bits and another returns the full 128 bits.
> > + * The two versions are separate to avoid complicating the
> > + * calling sequence for the more frequently used 64 bit version.
> > + */
> > +
> > +/*
> > + * Input and output memory allocation sizes are rounded up to a power
> > + * of 2 so kmalloc() will guarantee alignment. In turn, the alignment
> > + * ensures that the allocations don't cross a page boundary, which is
>=20
> Better to specify kmalloc's current alignment and why it fails to ensure
> (4 * sizeof(u64))-sized allocations wont cross page boundary.
>=20

Is your comment referring to ARCH_KMALLOC_MINALIGN?  If so, I see
how that makes sense.  BUILD_BUG_ON (sizeof (*input) >
ARCH_KMALLOC_MINALIGN) would be a cleaner solution.=20

Thanks,

Michael

> > + * required by the hypercall interface.
> > + */
> > +#define INPUTSIZE (4 * sizeof(u64))
> > +#define OUTPUTSIZE (2 * sizeof(u64))
> > +
> > +static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_outp=
ut *res)
> > +{
> > +	union hv_hypercall_status		status;
> > +	struct hv_get_vp_register_input		*input;
> > +
> > +	BUILD_BUG_ON(sizeof(*input) > INPUTSIZE);
> > +
> > +	input =3D kzalloc(INPUTSIZE, GFP_ATOMIC);
> > +
> > +	input->partitionid =3D HV_PARTITION_ID_SELF;
> > +	input->vpindex =3D HV_VP_INDEX_SELF;
> > +	input->inputvtl =3D 0;
> > +	input->name0 =3D msr;
> > +	input->name1 =3D 0;
> > +
> > +
> > +	status.as_uint64 =3D hv_do_hypercall(
> > +		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COUNT_1,
> > +		input, res);
> > +
> > +	/*
> > +	 * Something is fundamentally broken in the hypervisor if
> > +	 * getting a VP register fails. There's really no way to
> > +	 * continue as a guest VM, so panic.
> > +	 */
> > +	BUG_ON(status.status !=3D HV_STATUS_SUCCESS);
> > +
> > +	kfree(input);
> > +}
