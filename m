From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 15/16] checkpatch: Add warning on deprecated
 walk_iomem_res
Date: Fri, 25 Dec 2015 16:05:07 -0800
Message-ID: <1451088307.12498.3.camel@perches.com>
References: <1451081365-15190-1-git-send-email-toshi.kani@hpe.com>
	 <1451081365-15190-15-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1451081365-15190-15-git-send-email-toshi.kani@hpe.com>
Sender: owner-linux-mm@kvack.org
To: Toshi Kani <toshi.kani@hpe.com>, akpm@linux-foundation.org, bp@alien8.de
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
List-Id: linux-arch.vger.kernel.org

On Fri, 2015-12-25 at 15:09 -0700, Toshi Kani wrote:
> Use of walk_iomem_res() is deprecated in new code.=A0=A0Change
> checkpatch.pl to check new use of walk_iomem_res() and suggest
> to use walk_iomem_res_desc() instead.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3424,6 +3424,12 @@ sub process {
> =A0			}
> =A0		}
> =A0
> +# check for uses of walk_iomem_res()
> +		if ($line =3D~ /\bwalk_iomem_res\(/) {
> +			WARN("walk_iomem_res",
> +			=A0=A0=A0=A0=A0"Use of walk_iomem_res is deprecated, please use wal=
k_iomem_res_desc instead\n" . $herecurr)
> +		}
> +
> =A0# check for new typedefs, only function parameters and sparse annota=
tions
> =A0# make sense.
> =A0		if ($line =3D~ /\btypedef\s/ &&

There are 6 uses of this function in the entire kernel tree.
Why not just change them, remove the function and avoid this?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
