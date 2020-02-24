From: Federico Vaga <federico.vaga@cern.ch>
Subject: Re: [PATCH 3/7] docs: fix broken references to text files
Date: Mon, 24 Feb 2020 10:26:39 +0100
Message-ID: <3929512.qvrp2sLpzG@pcbe13614>
References: <cover.1582361737.git.mchehab+huawei@kernel.org> <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
Reply-To: <federico.vaga@cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-Id: linux-arch.vger.kernel.org

On Saturday, February 22, 2020 10:00:03 AM CET Mauro Carvalho Chehab wrote:
> Several references got broken due to txt to ReST conversion.
>=20
> Several of them can be automatically fixed with:
>=20
> 	scripts/documentation-file-ref-check --fix
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---


>  26) If any ioctl's are added by the patch, then also update
> -    ``Documentation/ioctl/ioctl-number.rst``.
> +    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
>=20
>  27) If your modified source code depends on or uses any of the kernel
>      APIs or features that are related to the following ``Kconfig`` symbo=
ls,
> diff --git a/Documentation/translations/it_IT/process/submit-checklist.rst
> b/Documentation/translations/it_IT/process/submit-checklist.rst index
> 995ee69fab11..3e575502690f 100644
> --- a/Documentation/translations/it_IT/process/submit-checklist.rst
> +++ b/Documentation/translations/it_IT/process/submit-checklist.rst
> @@ -117,7 +117,7 @@ sottomissione delle patch, in particolare
>      sorgenti che ne spieghi la logica: cosa fanno e perch=E9.
>=20
>  25) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
> -    ``Documentation/ioctl/ioctl-number.rst``.
> +    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.


Acked-By: Federico Vaga <federico.vaga@vaga.pv.it>
