From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v7 7/8] uapi: export all headers under uapi directories
Date: Tue, 28 Feb 2017 05:48:44 +0300
Message-ID: <20170228024844.GA28691@altlinux.org>
References: <CAK8P3a3mrqWQnpOjUA8kRO4ksjH7yB6Q5XiHmt1fukJMwD_yUw@mail.gmail.com> <1487954956-23318-1-git-send-email-nicolas.dichtel@6wind.com> <1487954956-23318-8-git-send-email-nicolas.dichtel@6wind.com> <56b1003e-1ac9-9ed3-f204-01e609427b98@6wind.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=x-unknown;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56b1003e-1ac9-9ed3-f204-01e609427b98@6wind.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: arnd@arndb.de, mmarek@suse.com, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, airlied@linux.ie, davem@davemloft.net, linux@armlinux.org.uk, bp@alien8.de, slash.tmp@free.fr, daniel.vetter@ffwll.ch, rmk+kernel@armlinux.org.uk, msalter@redhat.com, jengelh@inai.de, hch@infradead.org, tklauser@distanz.ch, mpe@ellerman.id.au, mingo@kernel.org, tglx@linutronix.de
List-Id: linux-arch.vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 05:01:55PM +0100, Nicolas Dichtel wrote:
> Le 24/02/2017 =C3=A0 17:49, Nicolas Dichtel a =C3=A9crit :
> > Regularly, when a new header is created in include/uapi/, the developer
> > forgets to add it in the corresponding Kbuild file. This error is usual=
ly
> > detected after the release is out.
> >=20
> > In fact, all headers under uapi directories should be exported, thus it=
's
> > useless to have an exhaustive list.
> >=20
> > After this patch, the following files, which were not exported, are now
> > exported (with make headers_install_all):
> > asm-arc/kvm_para.h
> > asm-arc/ucontext.h
> > asm-avr32/kvm_para.h
> > asm-blackfin/shmparam.h
> > asm-blackfin/ucontext.h
> > asm-c6x/shmparam.h
> > asm-c6x/ucontext.h
> > asm-cris/kvm_para.h
> > asm-h8300/shmparam.h
> > asm-h8300/ucontext.h
> > asm-hexagon/shmparam.h
> > asm-m32r/kvm_para.h
> > asm-m68k/kvm_para.h
> > asm-m68k/shmparam.h
> > asm-metag/kvm_para.h
> > asm-metag/shmparam.h
> > asm-metag/ucontext.h
> > asm-mips/hwcap.h
> > asm-mips/reg.h
> > asm-mips/ucontext.h
> > asm-nios2/kvm_para.h
> > asm-nios2/ucontext.h
> > asm-openrisc/shmparam.h
> > asm-parisc/kvm_para.h
> > asm-powerpc/perf_regs.h
> > asm-sh/kvm_para.h
> > asm-sh/ucontext.h
> > asm-tile/shmparam.h
> > asm-unicore32/shmparam.h
> > asm-unicore32/ucontext.h
> > asm-x86/hwcap2.h
> > asm-xtensa/kvm_para.h
> > drm/armada_drm.h
> > drm/etnaviv_drm.h
> > drm/vgem_drm.h
> > linux/auto_dev-ioctl.h
> > linux/bcache.h
> > linux/btrfs_tree.h
> > linux/cifs
> > linux/cifs/cifs_mount.h
> > linux/coresight-stm.h
> > linux/cryptouser.h
> > linux/genwqe
> > linux/genwqe/genwqe_card.h
> > linux/hash_info.h
> > linux/kcm.h
> > linux/kcov.h
> > linux/kfd_ioctl.h
> > linux/lightnvm.h
> > linux/module.h
> > linux/nilfs2_api.h
> > linux/nilfs2_ondisk.h
> > linux/nsfs.h
> > linux/pr.h
> > linux/qrtr.h
> > linux/rpmsg.h
> > linux/sed-opal.h
> > linux/smc.h
> > linux/smc_diag.h
> > linux/stm.h
> > linux/userio.h
> > linux/wil6210_uapi.h
> > rdma/bnxt_re-abi.h
> >=20
> > Note that I have removed from this list the files which are generated i=
n every
> > exported directories (like .install or .install.cmd).
> >=20
> > Thanks to Julien Floret <julien.floret@6wind.com> for the tip to get all
> > subdirs with a pure makefile command.
> >=20
> > For the record, note that exported files for asm directories are a mix =
of
> > files listed by:
> >  - include/uapi/asm-generic/Kbuild.asm;
> >  - arch/<arch>/include/uapi/asm/Kbuild;
> >  - arch/<arch>/include/asm/Kbuild.
> >=20
> > Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> > Acked-by: Mark Salter <msalter@redhat.com>
> > Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
> Is there any chance to get this series in before the rc1?

Note that the following newly exported headers have userspace compilation
errors:

/usr/include/drm/armada_drm.h:26:2: error: unknown type name 'uint32_t'
  uint32_t handle;

/usr/include/linux/btrfs_tree.h:390:12: error: 'BTRFS_UUID_SIZE' undeclared=
 here (not in a function)
  __u8 uuid[BTRFS_UUID_SIZE];

/usr/include/linux/cryptouser.h:58:16: error: 'CRYPTO_MAX_ALG_NAME' undecla=
red here (not in a function)
  char cru_name[CRYPTO_MAX_ALG_NAME];

/usr/include/linux/kfd_ioctl.h:33:2: error: unknown type name 'uint32_t'
  uint32_t major_version; /* from KFD */

/usr/include/linux/smc_diag.h:6:27: fatal error: rdma/ib_verbs.h: No such f=
ile or directory
 #include <rdma/ib_verbs.h>

/usr/include/linux/wil6210_uapi.h:73:2: error: unknown type name 'uint32_t'
  uint32_t op; /* enum wil_memio_op */

I think they should be fixed first.


--=20
ldv

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtOUMAAoJEAVFT+BVnCUIXZcQAJjBhgwRduM4ornRNnJ+r0OT
Dp60SvSOrap2/hcZwX20Q91UnmB3PiSzn+imx5SJXFayIIq70unv4p06GojDab+k
uwoRqwik9EdbnlXruqRlmccNj/phV73o5cog8BFvA/fDPegsgD20iVRx9SMVObFP
e7v/KokJxOJDdhTHwWyW8VfCP85V3dxbfavqFaHRZH/Gq+zxcKUL9MXnkPSSW4/N
4NfA5qcZMzLfNy2lBT9ug5p8jUyQennPu3FtqbLGDkiO+R/xt0oZxqsLO5TWzJ09
2F+cEEKugZOhnqIH8aibZP8Ils4hL349Tu8BJcd+Ig8Eo/+aY5UzkkRzrG4zudUb
UmHvyckJREPGanjDtFCvXHlhSGrSukW+qve9E7/7jujWbeIV3YwcJdOeNJUPbblv
cE15blaIjrpM5HvKKFwpihiFyr4HxyS5IO8ZRBZOk+Nxtd3pp6a2XQIe30LPkTfB
2UWxIrp4pUg39buml3CliXVY9dvy8vHIcBKuPTlS/7HxZHC54xVdc224Bi+za8Lm
Dwtk+a1DFWDQlmeNt5kH7TUPh46qmYyQireuKJ1UDkEc4j4GYYdyLuXPT9+o8747
U2/ZmCPn486b33jn18r+aN0cy7fMZlEb9cdfAjrAj4ZF03AiYxX/S8Fruai+b6zm
kt+6X0mbTdJsLA8nA9lQ
=1TEX
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
