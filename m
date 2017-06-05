From: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/20] asm-generic: Drop getrlimit and setrlimit syscalls
 from default list
Date: Mon, 5 Jun 2017 15:44:06 +0100
Message-ID: <20170605144406.GT6973@jhogan-linux.le.imgtec.org>
References: <20170604120009.342-1-ynorov@caviumnetworks.com>
 <20170604120009.342-4-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+OVWeTxrbAwQuiek"
Return-path: <linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170604120009.342-4-ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: linux-metag-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andrew Pinski <pinskia-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Pinski <Andrew.Pinski-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Adam Borowski <kilobyte-b9QjgO8OEXPVItvQsEIGlw@public.gmane.org>, Chris Metcalf <cmetcalf-d5a29ZRxExrQT0dZR+AlfA@public.gmane.org>, Steve Ellcey <sellcey-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Maxim Kuvyrkov <maxim.kuvyrkov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Ramana Radhakrishnan <ramana.gcc-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Florian Weimer <fweimer-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bamvor Zhangjian <bamvor.zhangjian-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Andreas Schwab <schwab-l3A5Bk7waGM@public.gmane.org>, Chris Metcalf <cmetcalf-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Heiko Carstens <heiko.carstens-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Joseph Myers <joseph-qD8j1LwMmJjtCj0u4l0SBw@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

--+OVWeTxrbAwQuiek
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sun, Jun 04, 2017 at 02:59:52PM +0300, Yury Norov wrote:
> The newer prlimit64 syscall provides all the functionality provided by
> the getrlimit and setrlimit syscalls and adds the pid of target process,
> so future architectures won't need to include getrlimit and setrlimit.
>=20
> Therefore drop getrlimit and setrlimit syscalls from the generic syscall
> list unless __ARCH_WANT_SET_GET_RLIMIT is defined by the architecture's
> unistd.h prior to including asm-generic/unistd.h, and adjust all architec=
tures
> using the generic syscall list to define it so that no in-tree architectu=
res
> are affected.
>=20
> Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Cc: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
> Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> Cc: Aurelien Jacquiot <a-jacquiot-l0cyMroinI0@public.gmane.org>
> Cc: linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org
> Cc: Richard Kuo <rkuo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: linux-metag-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Jonas Bonn <jonas-A9uVI2HLR7kOP4wsBPIw7w@public.gmane.org>
> Cc: linux-ZwoEplunGu2h2975yA52AaxOck334EZe@public.gmane.org
> Cc: Chen Liqin <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Chris Metcalf <cmetcalf-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
> Cc: Guan Xuetao <gxt-TG0Ac1+ktVePQbnJrJN+5g@public.gmane.org>
> Cc: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
> Cc: nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
> Cc: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>
> Cc: uclinux-h8-devel-5NWGOfrQmneRv+LV9MX5uooqe+aC9MnS@public.gmane.org
> Signed-off-by: Yury Norov <ynorov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Acked-by: Mark Salter <msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> [c6x]
> Acked-by: James Hogan <james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> [metag]
> Acked-by: Ley Foon Tan <lftan-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org> [nios2]
> Acked-by: Stafford Horne <shorne-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> [openrisc]
> Acked-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> [arm64]
> Acked-by: Vineet Gupta <vgupta-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> #arch/arc bits
> ---
>  arch/arc/include/uapi/asm/unistd.h       | 1 +
>  arch/arm64/include/uapi/asm/unistd.h     | 1 +
>  arch/c6x/include/uapi/asm/unistd.h       | 1 +
>  arch/h8300/include/uapi/asm/unistd.h     | 1 +
>  arch/hexagon/include/uapi/asm/unistd.h   | 1 +
>  arch/metag/include/uapi/asm/unistd.h     | 1 +
>  arch/nios2/include/uapi/asm/unistd.h     | 1 +
>  arch/openrisc/include/uapi/asm/unistd.h  | 1 +
>  arch/score/include/uapi/asm/unistd.h     | 1 +
>  arch/tile/include/uapi/asm/unistd.h      | 1 +
>  arch/unicore32/include/uapi/asm/unistd.h | 1 +
>  include/uapi/asm-generic/unistd.h        | 5 +++++

Don't forget to add __IGNORE_getrlimit and __IGNORE_setrlimit to
scripts/checksyscalls.sh, or you'll get warnings about missing syscalls.

Cheers
James

--+OVWeTxrbAwQuiek
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlk1biwACgkQbAtpk944
dnrVcg//UZcmXgi0ckej9MixRPVufo5+Oak4JvcCYjNjvUrPmaTQkfKO5rxbai/q
j6cdZOEE7ypJeSN6BXth9NvTzS8v212O7xcUv6+5c0VLx3lRwH89EJbrw3j6OuzY
2D/APaWBDrSBoZMEVuRyewQiEY6gz8wtyrFO94hfI0qNFtOFT1lzvSGeRVrsAlEE
gj8Mw+pswMla6aFm2oI6adqT0P+0ZwvfkKBHDu/euMrkLZnmBeO6ACiLBvB/IKam
IJGNSDWjNE+OsULzqV0QOtElWPRqUWRJ/l5tf1JqQE+pKjHE418QwzJluXKR7tMC
MexPIKQFol7yn57bnTeGv3dymlbkaQ4TDjsIKdPfcmEwz07kZhq2VcpS4ubjvtp/
c5n4CWV4lGY++aF17nbDpX64qfPYuHhpGI+FfrOHN78jCxutmf+H9LQ2T/Ep3MZ1
9K1uMrwqE0rSt1cg/HLS9jPg+pyFU1iTJ+CdulSVljwLIrjGh95tw2d3MHuuXGL7
03VA9rTgYTv6MM17dGtH63HeP3VcDxmMwT5wgntRl/7ZRPU4T2a4eGlaw19A/Nim
RjIVDkX3XFSOESLR14ILR4QUwa0Q07SJFxlmCsb/OHU+CGJBqMrX/q6YImXR3/JG
qhW2Iq8UCTsMYvQc0WL7dcTTMIHI9pLAmpexWx0mxhoqSWeAC0c=
=DDq9
-----END PGP SIGNATURE-----

--+OVWeTxrbAwQuiek--
