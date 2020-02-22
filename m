Return-Path: <SRS0=S930=4K=kvack.org=owner-linux-mm@kernel.org>
Date: Sat, 22 Feb 2020 18:51:50 +0100
From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/7] docs: fix broken references to text files
Message-ID: <20200222175150.GI2363188@phenom.ffwll.local>
References: <cover.1582361737.git.mchehab+huawei@kernel.org>
 <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5cfeed6df208b74913312a1c97235ee615180f91.1582361737.git.mchehab+huawei@kernel.org>
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200222175150.rcM7Q7Xm6ZW0F0iPwTbHj1XqRcMRgOg0CMgIs26Wako@z>

On Sat, Feb 22, 2020 at 10:00:03AM +0100, Mauro Carvalho Chehab wrote:
> Several references got broken due to txt to ReST conversion.
>=20
> Several of them can be automatically fixed with:
>=20
> 	scripts/documentation-file-ref-check --fix
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt      | 10 +++++-----
>  Documentation/filesystems/cifs/cifsroot.txt          |  2 +-
>  Documentation/memory-barriers.txt                    |  2 +-
>  Documentation/process/submit-checklist.rst           |  2 +-
>  .../translations/it_IT/process/submit-checklist.rst  |  2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt |  2 +-
>  .../translations/zh_CN/filesystems/sysfs.txt         |  2 +-
>  .../translations/zh_CN/process/submit-checklist.rst  |  2 +-
>  Documentation/virt/kvm/arm/pvtime.rst                |  2 +-
>  Documentation/virt/kvm/devices/vcpu.rst              |  2 +-
>  Documentation/virt/kvm/hypercalls.rst                |  4 ++--
>  arch/powerpc/include/uapi/asm/kvm_para.h             |  2 +-
>  drivers/gpu/drm/Kconfig                              |  2 +-
>  drivers/gpu/drm/drm_ioctl.c                          |  2 +-

These two look very correct. The patch that moved edid.rst seems to have
not updated a lot of references :-/

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

>  drivers/hwtracing/coresight/Kconfig                  |  2 +-
>  fs/fat/Kconfig                                       |  8 ++++----
>  fs/fuse/Kconfig                                      |  2 +-
>  fs/fuse/dev.c                                        |  2 +-
>  fs/nfs/Kconfig                                       |  2 +-
>  fs/overlayfs/Kconfig                                 |  6 +++---
>  include/linux/mm.h                                   |  4 ++--
>  include/uapi/linux/ethtool_netlink.h                 |  2 +-
>  include/uapi/rdma/rdma_user_ioctl_cmds.h             |  2 +-
>  mm/gup.c                                             | 12 ++++++------
>  net/ipv4/Kconfig                                     |  6 +++---
>  net/ipv4/ipconfig.c                                  |  2 +-
>  virt/kvm/arm/vgic/vgic-mmio-v3.c                     |  2 +-
>  virt/kvm/arm/vgic/vgic.h                             |  4 ++--
>  28 files changed, 47 insertions(+), 47 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> index 8be1d0bbfd16..e0fe9f70d22b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -957,7 +957,7 @@
>  			edid/1680x1050.bin, or edid/1920x1080.bin is given
>  			and no file with the same name exists. Details and
>  			instructions how to build your own EDID data are
> -			available in Documentation/driver-api/edid.rst. An EDID
> +			available in Documentation/admin-guide/edid.rst. An EDID
>  			data set will only be used for a particular connector,
>  			if its name and a colon are prepended to the EDID
>  			name. Each connector may use a unique EDID data
> @@ -1884,7 +1884,7 @@
>  			No delay
> =20
>  	ip=3D		[IP_PNP]
> -			See Documentation/filesystems/nfs/nfsroot.txt.
> +			See Documentation/admin-guide/nfs/nfsroot.rst.
> =20
>  	ipcmni_extend	[KNL] Extend the maximum number of unique System V
>  			IPC identifiers from 32,768 to 16,777,216.
> @@ -2863,13 +2863,13 @@
>  			Default value is 0.
> =20
>  	nfsaddrs=3D	[NFS] Deprecated.  Use ip=3D instead.
> -			See Documentation/filesystems/nfs/nfsroot.txt.
> +			See Documentation/admin-guide/nfs/nfsroot.rst.
> =20
>  	nfsroot=3D	[NFS] nfs root filesystem for disk-less boxes.
> -			See Documentation/filesystems/nfs/nfsroot.txt.
> +			See Documentation/admin-guide/nfs/nfsroot.rst.
> =20
>  	nfsrootdebug	[NFS] enable nfsroot debugging messages.
> -			See Documentation/filesystems/nfs/nfsroot.txt.
> +			See Documentation/admin-guide/nfs/nfsroot.rst.
> =20
>  	nfs.callback_nr_threads=3D
>  			[NFSv4] set the total number of threads that the
> diff --git a/Documentation/filesystems/cifs/cifsroot.txt b/Documentatio=
n/filesystems/cifs/cifsroot.txt
> index 0fa1a2c36a40..947b7ec6ce9e 100644
> --- a/Documentation/filesystems/cifs/cifsroot.txt
> +++ b/Documentation/filesystems/cifs/cifsroot.txt
> @@ -13,7 +13,7 @@ network by utilizing SMB or CIFS protocol.
> =20
>  In order to mount, the network stack will also need to be set up by
>  using 'ip=3D' config option. For more details, see
> -Documentation/filesystems/nfs/nfsroot.txt.
> +Documentation/admin-guide/nfs/nfsroot.rst.
> =20
>  A CIFS root mount currently requires the use of SMB1+UNIX Extensions
>  which is only supported by the Samba server. SMB1 is the older
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-b=
arriers.txt
> index e1c355e84edd..eaabc3134294 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -620,7 +620,7 @@ because the CPUs that the Linux kernel supports don=
't do writes
>  until they are certain (1) that the write will actually happen, (2)
>  of the location of the write, and (3) of the value to be written.
>  But please carefully read the "CONTROL DEPENDENCIES" section and the
> -Documentation/RCU/rcu_dereference.txt file:  The compiler can and does
> +Documentation/RCU/rcu_dereference.rst file:  The compiler can and does
>  break dependencies in a great many highly creative ways.
> =20
>  	CPU 1		      CPU 2
> diff --git a/Documentation/process/submit-checklist.rst b/Documentation=
/process/submit-checklist.rst
> index 8e56337d422d..3f8e9d5d95c2 100644
> --- a/Documentation/process/submit-checklist.rst
> +++ b/Documentation/process/submit-checklist.rst
> @@ -107,7 +107,7 @@ and elsewhere regarding submitting Linux kernel pat=
ches.
>      and why.
> =20
>  26) If any ioctl's are added by the patch, then also update
> -    ``Documentation/ioctl/ioctl-number.rst``.
> +    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
> =20
>  27) If your modified source code depends on or uses any of the kernel
>      APIs or features that are related to the following ``Kconfig`` sym=
bols,
> diff --git a/Documentation/translations/it_IT/process/submit-checklist.=
rst b/Documentation/translations/it_IT/process/submit-checklist.rst
> index 995ee69fab11..3e575502690f 100644
> --- a/Documentation/translations/it_IT/process/submit-checklist.rst
> +++ b/Documentation/translations/it_IT/process/submit-checklist.rst
> @@ -117,7 +117,7 @@ sottomissione delle patch, in particolare
>      sorgenti che ne spieghi la logica: cosa fanno e perch=C3=A9.
> =20
>  25) Se la patch aggiunge nuove chiamate ioctl, allora aggiornate
> -    ``Documentation/ioctl/ioctl-number.rst``.
> +    ``Documentation/userspace-api/ioctl/ioctl-number.rst``.
> =20
>  26) Se il codice che avete modificato dipende o usa una qualsiasi inte=
rfaccia o
>      funzionalit=C3=A0 del kernel che =C3=A8 associata a uno dei seguen=
ti simboli
> diff --git a/Documentation/translations/ko_KR/memory-barriers.txt b/Doc=
umentation/translations/ko_KR/memory-barriers.txt
> index 2e831ece6e26..e50fe6541335 100644
> --- a/Documentation/translations/ko_KR/memory-barriers.txt
> +++ b/Documentation/translations/ko_KR/memory-barriers.txt
> @@ -641,7 +641,7 @@ P =EB=8A=94 =EC=A7=9D=EC=88=98 =EB=B2=88=ED=98=B8 =EC=
=BA=90=EC=8B=9C =EB=9D=BC=EC=9D=B8=EC=97=90 =EC=A0=80=EC=9E=A5=EB=90=98=EC=
=96=B4 =EC=9E=88=EA=B3=A0, =EB=B3=80=EC=88=98 B =EB=8A=94 =ED=99=80=EC=88=
=98=20
>  =EB=A6=AC=EB=88=85=EC=8A=A4 =EC=BB=A4=EB=84=90=EC=9D=B4 =EC=A7=80=EC=9B=
=90=ED=95=98=EB=8A=94 CPU =EB=93=A4=EC=9D=80 (1) =EC=93=B0=EA=B8=B0=EA=B0=
=80 =EC=A0=95=EB=A7=90=EB=A1=9C =EC=9D=BC=EC=96=B4=EB=82=A0=EC=A7=80, (2)=
 =EC=93=B0=EA=B8=B0=EA=B0=80 =EC=96=B4=EB=94=94=EC=97=90
>  =EC=9D=B4=EB=A3=A8=EC=96=B4=EC=A7=88=EC=A7=80, =EA=B7=B8=EB=A6=AC=EA=B3=
=A0 (3) =EC=93=B0=EC=97=AC=EC=A7=88 =EA=B0=92=EC=9D=84 =ED=99=95=EC=8B=A4=
=ED=9E=88 =EC=95=8C=EA=B8=B0 =EC=A0=84=EA=B9=8C=EC=A7=80=EB=8A=94 =EC=93=B0=
=EA=B8=B0=EB=A5=BC =EC=88=98=ED=96=89=ED=95=98=EC=A7=80 =EC=95=8A=EA=B8=B0
>  =EB=95=8C=EB=AC=B8=EC=9E=85=EB=8B=88=EB=8B=A4.  =ED=95=98=EC=A7=80=EB=A7=
=8C "=EC=BB=A8=ED=8A=B8=EB=A1=A4 =EC=9D=98=EC=A1=B4=EC=84=B1" =EC=84=B9=EC=
=85=98=EA=B3=BC
> -Documentation/RCU/rcu_dereference.txt =ED=8C=8C=EC=9D=BC=EC=9D=84 =EC=A3=
=BC=EC=9D=98 =EA=B9=8A=EA=B2=8C =EC=9D=BD=EC=96=B4 =EC=A3=BC=EC=8B=9C=EA=B8=
=B0 =EB=B0=94=EB=9E=8D=EB=8B=88=EB=8B=A4:
> +Documentation/RCU/rcu_dereference.rst =ED=8C=8C=EC=9D=BC=EC=9D=84 =EC=A3=
=BC=EC=9D=98 =EA=B9=8A=EA=B2=8C =EC=9D=BD=EC=96=B4 =EC=A3=BC=EC=8B=9C=EA=B8=
=B0 =EB=B0=94=EB=9E=8D=EB=8B=88=EB=8B=A4:
>  =EC=BB=B4=ED=8C=8C=EC=9D=BC=EB=9F=AC=EB=8A=94 =EB=A7=A4=EC=9A=B0 =EC=B0=
=BD=EC=9D=98=EC=A0=81=EC=9D=B8 =EB=A7=8E=EC=9D=80 =EB=B0=A9=EB=B2=95=EC=9C=
=BC=EB=A1=9C =EC=A2=85=EC=86=8D=EC=84=B1=EC=9D=84 =EA=B9=B0 =EC=88=98 =EC=
=9E=88=EC=8A=B5=EB=8B=88=EB=8B=A4.
> =20
>  	CPU 1		      CPU 2
> diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/D=
ocumentation/translations/zh_CN/filesystems/sysfs.txt
> index ee1f37da5b23..a15c3ebdfa82 100644
> --- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
> +++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
> @@ -281,7 +281,7 @@ drivers/ =E5=8C=85=E5=90=AB=E4=BA=86=E6=AF=8F=E4=B8=
=AA=E5=B7=B2=E4=B8=BA=E7=89=B9=E5=AE=9A=E6=80=BB=E7=BA=BF=E4=B8=8A=E7=9A=84=
=E8=AE=BE=E5=A4=87=E8=80=8C=E6=8C=82=E8=BD=BD=E7=9A=84=E9=A9=B1=E5=8A=A8=E7=
=A8=8B=E5=BA=8F
>  =E5=81=87=E5=AE=9A=E9=A9=B1=E5=8A=A8=E6=B2=A1=E6=9C=89=E8=B7=A8=E8=B6=8A=
=E5=A4=9A=E4=B8=AA=E6=80=BB=E7=BA=BF=E7=B1=BB=E5=9E=8B)=E3=80=82
> =20
>  fs/ =E5=8C=85=E5=90=AB=E4=BA=86=E4=B8=80=E4=B8=AA=E4=B8=BA=E6=96=87=E4=
=BB=B6=E7=B3=BB=E7=BB=9F=E8=AE=BE=E7=AB=8B=E7=9A=84=E7=9B=AE=E5=BD=95=E3=80=
=82=E7=8E=B0=E5=9C=A8=E6=AF=8F=E4=B8=AA=E6=83=B3=E8=A6=81=E5=AF=BC=E5=87=BA=
=E5=B1=9E=E6=80=A7=E7=9A=84=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=BF=85=E9=
=A1=BB
> -=E5=9C=A8 fs/ =E4=B8=8B=E5=88=9B=E5=BB=BA=E8=87=AA=E5=B7=B1=E7=9A=84=E5=
=B1=82=E6=AC=A1=E7=BB=93=E6=9E=84(=E5=8F=82=E8=A7=81Documentation/filesys=
tems/fuse.txt)=E3=80=82
> +=E5=9C=A8 fs/ =E4=B8=8B=E5=88=9B=E5=BB=BA=E8=87=AA=E5=B7=B1=E7=9A=84=E5=
=B1=82=E6=AC=A1=E7=BB=93=E6=9E=84(=E5=8F=82=E8=A7=81Documentation/filesys=
tems/fuse.rst)=E3=80=82
> =20
>  dev/ =E5=8C=85=E5=90=AB=E4=B8=A4=E4=B8=AA=E5=AD=90=E7=9B=AE=E5=BD=95=EF=
=BC=9A char/ =E5=92=8C block/=E3=80=82=E5=9C=A8=E8=BF=99=E4=B8=A4=E4=B8=AA=
=E5=AD=90=E7=9B=AE=E5=BD=95=E4=B8=AD=EF=BC=8C=E6=9C=89=E4=BB=A5
>  <major>:<minor> =E6=A0=BC=E5=BC=8F=E5=91=BD=E5=90=8D=E7=9A=84=E7=AC=A6=
=E5=8F=B7=E9=93=BE=E6=8E=A5=E3=80=82=E8=BF=99=E4=BA=9B=E7=AC=A6=E5=8F=B7=E9=
=93=BE=E6=8E=A5=E6=8C=87=E5=90=91 sysfs =E7=9B=AE=E5=BD=95
> diff --git a/Documentation/translations/zh_CN/process/submit-checklist.=
rst b/Documentation/translations/zh_CN/process/submit-checklist.rst
> index 8738c55e42a2..50386e0e42e7 100644
> --- a/Documentation/translations/zh_CN/process/submit-checklist.rst
> +++ b/Documentation/translations/zh_CN/process/submit-checklist.rst
> @@ -97,7 +97,7 @@ Linux=E5=86=85=E6=A0=B8=E8=A1=A5=E4=B8=81=E6=8F=90=E4=
=BA=A4=E6=B8=85=E5=8D=95
>  24) =E6=89=80=E6=9C=89=E5=86=85=E5=AD=98=E5=B1=8F=E9=9A=9C=E4=BE=8B=E5=
=A6=82 ``barrier()``, ``rmb()``, ``wmb()`` =E9=83=BD=E9=9C=80=E8=A6=81=E6=
=BA=90=E4=BB=A3=E7=A0=81=E4=B8=AD=E7=9A=84=E6=B3=A8
>      =E9=87=8A=E6=9D=A5=E8=A7=A3=E9=87=8A=E5=AE=83=E4=BB=AC=E6=AD=A3=E5=
=9C=A8=E6=89=A7=E8=A1=8C=E7=9A=84=E6=93=8D=E4=BD=9C=E5=8F=8A=E5=85=B6=E5=8E=
=9F=E5=9B=A0=E7=9A=84=E9=80=BB=E8=BE=91=E3=80=82
> =20
> -25) =E5=A6=82=E6=9E=9C=E8=A1=A5=E4=B8=81=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=
=BB=BB=E4=BD=95ioctl=EF=BC=8C=E9=82=A3=E4=B9=88=E4=B9=9F=E8=A6=81=E6=9B=B4=
=E6=96=B0 ``Documentation/ioctl/ioctl-number.rst``
> +25) =E5=A6=82=E6=9E=9C=E8=A1=A5=E4=B8=81=E6=B7=BB=E5=8A=A0=E4=BA=86=E4=
=BB=BB=E4=BD=95ioctl=EF=BC=8C=E9=82=A3=E4=B9=88=E4=B9=9F=E8=A6=81=E6=9B=B4=
=E6=96=B0 ``Documentation/userspace-api/ioctl/ioctl-number.rst``
> =20
>  26) =E5=A6=82=E6=9E=9C=E4=BF=AE=E6=94=B9=E5=90=8E=E7=9A=84=E6=BA=90=E4=
=BB=A3=E7=A0=81=E4=BE=9D=E8=B5=96=E6=88=96=E4=BD=BF=E7=94=A8=E4=B8=8E=E4=BB=
=A5=E4=B8=8B ``Kconfig`` =E7=AC=A6=E5=8F=B7=E7=9B=B8=E5=85=B3=E7=9A=84=E4=
=BB=BB=E4=BD=95=E5=86=85=E6=A0=B8API=E6=88=96
>      =E5=8A=9F=E8=83=BD=EF=BC=8C=E5=88=99=E5=9C=A8=E7=A6=81=E7=94=A8=E7=
=9B=B8=E5=85=B3 ``Kconfig`` =E7=AC=A6=E5=8F=B7=E5=92=8C/=E6=88=96 ``=3Dm`=
` =EF=BC=88=E5=A6=82=E6=9E=9C=E8=AF=A5=E9=80=89=E9=A1=B9=E5=8F=AF=E7=94=A8=
=EF=BC=89=E7=9A=84=E6=83=85=E5=86=B5
> diff --git a/Documentation/virt/kvm/arm/pvtime.rst b/Documentation/virt=
/kvm/arm/pvtime.rst
> index 2357dd2d8655..687b60d76ca9 100644
> --- a/Documentation/virt/kvm/arm/pvtime.rst
> +++ b/Documentation/virt/kvm/arm/pvtime.rst
> @@ -76,5 +76,5 @@ It is advisable that one or more 64k pages are set as=
ide for the purpose of
>  these structures and not used for other purposes, this enables the gue=
st to map
>  the region using 64k pages and avoids conflicting attributes with othe=
r memory.
> =20
> -For the user space interface see Documentation/virt/kvm/devices/vcpu.t=
xt
> +For the user space interface see Documentation/virt/kvm/devices/vcpu.r=
st
>  section "3. GROUP: KVM_ARM_VCPU_PVTIME_CTRL".
> diff --git a/Documentation/virt/kvm/devices/vcpu.rst b/Documentation/vi=
rt/kvm/devices/vcpu.rst
> index 9963e680770a..ca374d3fe085 100644
> --- a/Documentation/virt/kvm/devices/vcpu.rst
> +++ b/Documentation/virt/kvm/devices/vcpu.rst
> @@ -110,5 +110,5 @@ Returns:
> =20
>  Specifies the base address of the stolen time structure for this VCPU.=
 The
>  base address must be 64 byte aligned and exist within a valid guest me=
mory
> -region. See Documentation/virt/kvm/arm/pvtime.txt for more information
> +region. See Documentation/virt/kvm/arm/pvtime.rst for more information
>  including the layout of the stolen time structure.
> diff --git a/Documentation/virt/kvm/hypercalls.rst b/Documentation/virt=
/kvm/hypercalls.rst
> index dbaf207e560d..ed4fddd364ea 100644
> --- a/Documentation/virt/kvm/hypercalls.rst
> +++ b/Documentation/virt/kvm/hypercalls.rst
> @@ -22,7 +22,7 @@ S390:
>    number in R1.
> =20
>    For further information on the S390 diagnose call as supported by KV=
M,
> -  refer to Documentation/virt/kvm/s390-diag.txt.
> +  refer to Documentation/virt/kvm/s390-diag.rst.
> =20
>  PowerPC:
>    It uses R3-R10 and hypercall number in R11. R4-R11 are used as outpu=
t registers.
> @@ -30,7 +30,7 @@ PowerPC:
> =20
>    KVM hypercalls uses 4 byte opcode, that are patched with 'hypercall-=
instructions'
>    property inside the device tree's /hypervisor node.
> -  For more information refer to Documentation/virt/kvm/ppc-pv.txt
> +  For more information refer to Documentation/virt/kvm/ppc-pv.rst
> =20
>  MIPS:
>    KVM hypercalls use the HYPCALL instruction with code 0 and the hyper=
call
> diff --git a/arch/powerpc/include/uapi/asm/kvm_para.h b/arch/powerpc/in=
clude/uapi/asm/kvm_para.h
> index be48c2215fa2..a809b1b44ddf 100644
> --- a/arch/powerpc/include/uapi/asm/kvm_para.h
> +++ b/arch/powerpc/include/uapi/asm/kvm_para.h
> @@ -31,7 +31,7 @@
>   * Struct fields are always 32 or 64 bit aligned, depending on them be=
ing 32
>   * or 64 bit wide respectively.
>   *
> - * See Documentation/virt/kvm/ppc-pv.txt
> + * See Documentation/virt/kvm/ppc-pv.rst
>   */
>  struct kvm_vcpu_arch_shared {
>  	__u64 scratch1;
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index d0aa6cff2e02..df0970994655 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -164,7 +164,7 @@ config DRM_LOAD_EDID_FIRMWARE
>  	  monitor are unable to provide appropriate EDID data. Since this
>  	  feature is provided as a workaround for broken hardware, the
>  	  default case is N. Details and instructions how to build your own
> -	  EDID data are given in Documentation/driver-api/edid.rst.
> +	  EDID data are given in Documentation/admin-guide/edid.rst.
> =20
>  config DRM_DP_CEC
>  	bool "Enable DisplayPort CEC-Tunneling-over-AUX HDMI support"
> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 5afb39688b55..e469e701b381 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -740,7 +740,7 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D=
 {
>   *     };
>   *
>   * Please make sure that you follow all the best practices from
> - * ``Documentation/ioctl/botching-up-ioctls.rst``. Note that drm_ioctl=
()
> + * ``Documentation/process/botching-up-ioctls.rst``. Note that drm_ioc=
tl()
>   * automatically zero-extends structures, hence make sure you can add =
more stuff
>   * at the end, i.e. don't put a variable sized array there.
>   *
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/co=
resight/Kconfig
> index 6ff30e25af55..6d42a6d3766f 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -107,7 +107,7 @@ config CORESIGHT_CPU_DEBUG
>  	  can quickly get to know program counter (PC), secure state,
>  	  exception level, etc. Before use debugging functionality, platform
>  	  needs to ensure the clock domain and power domain are enabled
> -	  properly, please refer Documentation/trace/coresight-cpu-debug.rst
> +	  properly, please refer Documentation/trace/coresight/coresight-cpu-=
debug.rst
>  	  for detailed description and the example for usage.
> =20
>  endif
> diff --git a/fs/fat/Kconfig b/fs/fat/Kconfig
> index 718163d0c621..ca31993dcb47 100644
> --- a/fs/fat/Kconfig
> +++ b/fs/fat/Kconfig
> @@ -69,7 +69,7 @@ config VFAT_FS
> =20
>  	  The VFAT support enlarges your kernel by about 10 KB and it only
>  	  works if you said Y to the "DOS FAT fs support" above.  Please read
> -	  the file <file:Documentation/filesystems/vfat.txt> for details.  If
> +	  the file <file:Documentation/filesystems/vfat.rst> for details.  If
>  	  unsure, say Y.
> =20
>  	  To compile this as a module, choose M here: the module will be call=
ed
> @@ -82,7 +82,7 @@ config FAT_DEFAULT_CODEPAGE
>  	help
>  	  This option should be set to the codepage of your FAT filesystems.
>  	  It can be overridden with the "codepage" mount option.
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
> =20
>  config FAT_DEFAULT_IOCHARSET
>  	string "Default iocharset for FAT"
> @@ -96,7 +96,7 @@ config FAT_DEFAULT_IOCHARSET
>  	  Note that "utf8" is not recommended for FAT filesystems.
>  	  If unsure, you shouldn't set "utf8" here - select the next option
>  	  instead if you would like to use UTF-8 encoded file names by defaul=
t.
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
> =20
>  	  Enable any character sets you need in File Systems/Native Language
>  	  Support.
> @@ -114,4 +114,4 @@ config FAT_DEFAULT_UTF8
> =20
>  	  Say Y if you use UTF-8 encoding for file names, N otherwise.
> =20
> -	  See <file:Documentation/filesystems/vfat.txt> for more information.
> +	  See <file:Documentation/filesystems/vfat.rst> for more information.
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index eb2a585572dc..774b2618018a 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -12,7 +12,7 @@ config FUSE_FS
>  	  although chances are your distribution already has that library
>  	  installed if you've installed the "fuse" package itself.
> =20
> -	  See <file:Documentation/filesystems/fuse.txt> for more information.
> +	  See <file:Documentation/filesystems/fuse.rst> for more information.
>  	  See <file:Documentation/Changes> for needed library/utility version=
.
> =20
>  	  If you want to develop a userspace FS, or if you want to use
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 97eec7522bf2..c7a65cf2bcca 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2081,7 +2081,7 @@ static void end_polls(struct fuse_conn *fc)
>   * The same effect is usually achievable through killing the filesyste=
m daemon
>   * and all users of the filesystem.  The exception is the combination =
of an
>   * asynchronous request and the tricky deadlock (see
> - * Documentation/filesystems/fuse.txt).
> + * Documentation/filesystems/fuse.rst).
>   *
>   * Aborting requests under I/O goes as follows: 1: Separate out unlock=
ed
>   * requests, they should be finished off immediately.  Locked requests=
 will be
> diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
> index 40b6c5ac46c0..88e1763e02f3 100644
> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -164,7 +164,7 @@ config ROOT_NFS
>  	  If you want your system to mount its root file system via NFS,
>  	  choose Y here.  This is common practice for managing systems
>  	  without local permanent storage.  For details, read
> -	  <file:Documentation/filesystems/nfs/nfsroot.txt>.
> +	  <file:Documentation/admin-guide/nfs/nfsroot.rst>.
> =20
>  	  Most people say N here.
> =20
> diff --git a/fs/overlayfs/Kconfig b/fs/overlayfs/Kconfig
> index 444e2da4f60e..b35e128ee2fd 100644
> --- a/fs/overlayfs/Kconfig
> +++ b/fs/overlayfs/Kconfig
> @@ -9,7 +9,7 @@ config OVERLAY_FS
>  	  'lower' filesystem is either hidden or, in the case of directories,
>  	  merged with the 'upper' object.
> =20
> -	  For more information see Documentation/filesystems/overlayfs.txt
> +	  For more information see Documentation/filesystems/overlayfs.rst
> =20
>  config OVERLAY_FS_REDIRECT_DIR
>  	bool "Overlayfs: turn on redirect directory feature by default"
> @@ -38,7 +38,7 @@ config OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW
>  	  If backward compatibility is not an issue, then it is safe and
>  	  recommended to say N here.
> =20
> -	  For more information, see Documentation/filesystems/overlayfs.txt
> +	  For more information, see Documentation/filesystems/overlayfs.rst
> =20
>  	  If unsure, say Y.
> =20
> @@ -102,7 +102,7 @@ config OVERLAY_FS_XINO_AUTO
>  	  If compatibility with applications that expect 32bit inodes is not =
an
>  	  issue, then it is safe and recommended to say Y here.
> =20
> -	  For more information, see Documentation/filesystems/overlayfs.txt
> +	  For more information, see Documentation/filesystems/overlayfs.rst
> =20
>  	  If unsure, say N.
> =20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9f8fb6a34157..65ced68ab010 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1108,7 +1108,7 @@ void unpin_user_pages(struct page **pages, unsign=
ed long npages);
>   * used to track the pincount (instead using of the GUP_PIN_COUNTING_B=
IAS
>   * scheme).
>   *
> - * For more information, please see Documentation/vm/pin_user_pages.rs=
t.
> + * For more information, please see Documentation/core-api/pin_user_pa=
ges.rst.
>   *
>   * @page:	pointer to page to be queried.
>   * @Return:	True, if it is likely that the page has been "dma-pinned".
> @@ -2711,7 +2711,7 @@ struct page *follow_page(struct vm_area_struct *v=
ma, unsigned long address,
>   * releasing pages: get_user_pages*() pages must be released via put_p=
age(),
>   * while pin_user_pages*() pages must be released via unpin_user_page(=
).
>   *
> - * Please see Documentation/vm/pin_user_pages.rst for more information=
.
> + * Please see Documentation/core-api/pin_user_pages.rst for more infor=
mation.
>   */
> =20
>  static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flag=
s)
> diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/=
ethtool_netlink.h
> index 7e0b460f872c..76513acc650f 100644
> --- a/include/uapi/linux/ethtool_netlink.h
> +++ b/include/uapi/linux/ethtool_netlink.h
> @@ -2,7 +2,7 @@
>  /*
>   * include/uapi/linux/ethtool_netlink.h - netlink interface for ethtoo=
l
>   *
> - * See Documentation/networking/ethtool-netlink.txt in kernel source t=
ree for
> + * See Documentation/networking/ethtool-netlink.rst in kernel source t=
ree for
>   * doucumentation of the interface.
>   */
> =20
> diff --git a/include/uapi/rdma/rdma_user_ioctl_cmds.h b/include/uapi/rd=
ma/rdma_user_ioctl_cmds.h
> index 7b1ec806f8f9..38ab7accb7be 100644
> --- a/include/uapi/rdma/rdma_user_ioctl_cmds.h
> +++ b/include/uapi/rdma/rdma_user_ioctl_cmds.h
> @@ -36,7 +36,7 @@
>  #include <linux/types.h>
>  #include <linux/ioctl.h>
> =20
> -/* Documentation/ioctl/ioctl-number.rst */
> +/* Documentation/userspace-api/ioctl/ioctl-number.rst */
>  #define RDMA_IOCTL_MAGIC	0x1b
>  #define RDMA_VERBS_IOCTL \
>  	_IOWR(RDMA_IOCTL_MAGIC, 1, struct ib_uverbs_ioctl_hdr)
> diff --git a/mm/gup.c b/mm/gup.c
> index 441f7a48f370..bbf2d627b7f3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2770,9 +2770,9 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(=
). Please
> - * see Documentation/vm/pin_user_pages.rst for further details.
> + * see Documentation/core-api/pin_user_pages.rst for further details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_page=
s.rst. It
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_use=
r_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
> @@ -2795,9 +2795,9 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(=
). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_page=
s.rst. It
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_use=
r_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *=
mm,
> @@ -2822,9 +2822,9 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>   * FOLL_PIN is set.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(=
). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_page=
s.rst. It
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_use=
r_pages.rst. It
>   * is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
> diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
> index 6490b845e17b..25a8888826b8 100644
> --- a/net/ipv4/Kconfig
> +++ b/net/ipv4/Kconfig
> @@ -129,7 +129,7 @@ config IP_PNP_DHCP
> =20
>  	  If unsure, say Y. Note that if you want to use DHCP, a DHCP server
>  	  must be operating on your network.  Read
> -	  <file:Documentation/filesystems/nfs/nfsroot.txt> for details.
> +	  <file:Documentation/admin-guide/nfs/nfsroot.rst> for details.
> =20
>  config IP_PNP_BOOTP
>  	bool "IP: BOOTP support"
> @@ -144,7 +144,7 @@ config IP_PNP_BOOTP
>  	  does BOOTP itself, providing all necessary information on the kerne=
l
>  	  command line, you can say N here. If unsure, say Y. Note that if yo=
u
>  	  want to use BOOTP, a BOOTP server must be operating on your network=
.
> -	  Read <file:Documentation/filesystems/nfs/nfsroot.txt> for details.
> +	  Read <file:Documentation/admin-guide/nfs/nfsroot.rst> for details.
> =20
>  config IP_PNP_RARP
>  	bool "IP: RARP support"
> @@ -157,7 +157,7 @@ config IP_PNP_RARP
>  	  older protocol which is being obsoleted by BOOTP and DHCP), say Y
>  	  here. Note that if you want to use RARP, a RARP server must be
>  	  operating on your network. Read
> -	  <file:Documentation/filesystems/nfs/nfsroot.txt> for details.
> +	  <file:Documentation/admin-guide/nfs/nfsroot.rst> for details.
> =20
>  config NET_IPIP
>  	tristate "IP: tunneling"
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index 4438f6b12335..561f15b5a944 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1621,7 +1621,7 @@ late_initcall(ip_auto_config);
> =20
>  /*
>   *  Decode any IP configuration options in the "ip=3D" or "nfsaddrs=3D=
" kernel
> - *  command line parameter.  See Documentation/filesystems/nfs/nfsroot=
.txt.
> + *  command line parameter.  See Documentation/admin-guide/nfs/nfsroot=
.rst.
>   */
>  static int __init ic_proto_name(char *name)
>  {
> diff --git a/virt/kvm/arm/vgic/vgic-mmio-v3.c b/virt/kvm/arm/vgic/vgic-=
mmio-v3.c
> index ebc218840fc2..84fcd88cc34e 100644
> --- a/virt/kvm/arm/vgic/vgic-mmio-v3.c
> +++ b/virt/kvm/arm/vgic/vgic-mmio-v3.c
> @@ -252,7 +252,7 @@ static unsigned long vgic_v3_uaccess_read_pending(s=
truct kvm_vcpu *vcpu,
>  	 * pending state of interrupt is latched in pending_latch variable.
>  	 * Userspace will save and restore pending state and line_level
>  	 * separately.
> -	 * Refer to Documentation/virt/kvm/devices/arm-vgic-v3.txt
> +	 * Refer to Documentation/virt/kvm/devices/arm-vgic-v3.rst
>  	 * for handling of ISPENDR and ICPENDR.
>  	 */
>  	for (i =3D 0; i < len * 8; i++) {
> diff --git a/virt/kvm/arm/vgic/vgic.h b/virt/kvm/arm/vgic/vgic.h
> index c7fefd6b1c80..42166ce359b4 100644
> --- a/virt/kvm/arm/vgic/vgic.h
> +++ b/virt/kvm/arm/vgic/vgic.h
> @@ -42,7 +42,7 @@
>  			    VGIC_AFFINITY_LEVEL(val, 3))
> =20
>  /*
> - * As per Documentation/virt/kvm/devices/arm-vgic-v3.txt,
> + * As per Documentation/virt/kvm/devices/arm-vgic-v3.rst,
>   * below macros are defined for CPUREG encoding.
>   */
>  #define KVM_REG_ARM_VGIC_SYSREG_OP0_MASK   0x000000000000c000
> @@ -63,7 +63,7 @@
>  				      KVM_REG_ARM_VGIC_SYSREG_OP2_MASK)
> =20
>  /*
> - * As per Documentation/virt/kvm/devices/arm-vgic-its.txt,
> + * As per Documentation/virt/kvm/devices/arm-vgic-its.rst,
>   * below macros are defined for ITS table entry encoding.
>   */
>  #define KVM_ITS_CTE_VALID_SHIFT		63
> --=20
> 2.24.1
>=20

--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
