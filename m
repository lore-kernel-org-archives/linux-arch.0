From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 12/22] docs: driver-api: add .rst files from the main
 dir
Date: Wed, 19 Jun 2019 10:24:28 +0200
Message-ID: <20190619082428.GK3187@ulmo>
References: <cover.1560890771.git.mchehab+samsung@kernel.org>
 <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1027878540=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b0d24e805d5368719cc64e8104d64ee9b5b89dd0.1560890772.git.mchehab+samsung@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: kernel-hardening@lists.openwall.com, Farhan Ali <alifm@linux.ibm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>, Evgeniy Polyakov <zbr@ioremap.net>, linux-arch@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Halil Pasic <pasic@linux.ibm.com>, Alan Stern <stern@rowland.harvard.edu>, Jiri Slaby <jslaby@suse.com>, Guenter Roeck <linux@roeck-us.net>, Ohad Ben-Cohen <ohad@wizery.com>, Marc Zyngier <marc.zyngier@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Sean Paul <sean@poorly.run>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger>
List-Id: linux-arch.vger.kernel.org


--===============1027878540==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="x1F0m3RQhDZyj8sd"
Content-Disposition: inline


--x1F0m3RQhDZyj8sd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2019 at 05:53:17PM -0300, Mauro Carvalho Chehab wrote:
> Those files belong to the driver-api guide. Add them to the
> driver-api book.
>=20
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/ABI/removed/sysfs-class-rfkill  |  2 +-
>  Documentation/ABI/stable/sysfs-class-rfkill   |  2 +-
>  .../ABI/testing/sysfs-class-switchtec         |  2 +-
>  Documentation/PCI/pci.rst                     |  2 +-
>  Documentation/admin-guide/hw-vuln/l1tf.rst    |  2 +-
>  .../admin-guide/kernel-parameters.txt         |  4 +-
>  .../admin-guide/kernel-per-cpu-kthreads.rst   |  2 +-
>  .../{ =3D> driver-api}/atomic_bitops.rst        |  2 -
>  Documentation/{ =3D> driver-api}/bt8xxgpio.rst  |  2 -
>  .../bus-virt-phys-mapping.rst                 |  2 -
>  .../{connector =3D> driver-api}/connector.rst   |  2 -
>  .../{console =3D> driver-api}/console.rst       |  2 -
>  Documentation/{ =3D> driver-api}/crc32.rst      |  2 -
>  Documentation/{ =3D> driver-api}/dcdbas.rst     |  2 -
>  .../{ =3D> driver-api}/debugging-modules.rst    |  2 -
>  .../debugging-via-ohci1394.rst                |  2 -
>  Documentation/{ =3D> driver-api}/dell_rbu.rst   |  2 -
>  Documentation/{ =3D> driver-api}/digsig.rst     |  2 -
>  .../{EDID/howto.rst =3D> driver-api/edid.rst}   |  2 -
>  Documentation/{ =3D> driver-api}/eisa.rst       |  2 -
>  .../{ =3D> driver-api}/futex-requeue-pi.rst     |  2 -
>  .../{ =3D> driver-api}/gcc-plugins.rst          |  2 -
>  Documentation/{ =3D> driver-api}/hwspinlock.rst |  2 -
>  Documentation/driver-api/index.rst            | 66 +++++++++++++++++++
>  Documentation/{ =3D> driver-api}/io-mapping.rst |  2 -
>  .../{ =3D> driver-api}/io_ordering.rst          |  2 -
>  .../{IPMI.rst =3D> driver-api/ipmi.rst}         |  2 -
>  .../irq-affinity.rst}                         |  2 -
>  .../irq-domain.rst}                           |  2 -
>  Documentation/{IRQ.rst =3D> driver-api/irq.rst} |  2 -
>  .../{ =3D> driver-api}/irqflags-tracing.rst     |  2 -
>  Documentation/{ =3D> driver-api}/isa.rst        |  2 -
>  Documentation/{ =3D> driver-api}/isapnp.rst     |  2 -
>  Documentation/{ =3D> driver-api}/kobject.rst    |  4 +-
>  Documentation/{ =3D> driver-api}/kprobes.rst    |  2 -
>  Documentation/{ =3D> driver-api}/kref.rst       |  2 -
>  .../pblk.txt =3D> driver-api/lightnvm-pblk.rst} |  0
>  Documentation/{ =3D> driver-api}/lzo.rst        |  2 -
>  Documentation/{ =3D> driver-api}/mailbox.rst    |  2 -
>  .../{ =3D> driver-api}/men-chameleon-bus.rst    |  2 -
>  Documentation/{ =3D> driver-api}/nommu-mmap.rst |  2 -
>  Documentation/{ =3D> driver-api}/ntb.rst        |  2 -
>  Documentation/{nvmem =3D> driver-api}/nvmem.rst |  2 -
>  Documentation/{ =3D> driver-api}/padata.rst     |  2 -
>  .../{ =3D> driver-api}/parport-lowlevel.rst     |  2 -
>  .../{ =3D> driver-api}/percpu-rw-semaphore.rst  |  2 -
>  Documentation/{ =3D> driver-api}/pi-futex.rst   |  2 -
>  Documentation/driver-api/pps.rst              |  2 -
>  .../{ =3D> driver-api}/preempt-locking.rst      |  2 -
>  .../{pti =3D> driver-api}/pti_intel_mid.rst     |  2 -
>  Documentation/driver-api/ptp.rst              |  2 -
>  Documentation/{ =3D> driver-api}/pwm.rst        |  2 -
>  Documentation/{ =3D> driver-api}/rbtree.rst     |  2 -
>  Documentation/{ =3D> driver-api}/remoteproc.rst |  4 +-
>  Documentation/{ =3D> driver-api}/rfkill.rst     |  2 -
>  .../{ =3D> driver-api}/robust-futex-ABI.rst     |  2 -
>  .../{ =3D> driver-api}/robust-futexes.rst       |  2 -
>  Documentation/{ =3D> driver-api}/rpmsg.rst      |  2 -
>  Documentation/{ =3D> driver-api}/sgi-ioc4.rst   |  2 -
>  .../{SM501.rst =3D> driver-api/sm501.rst}       |  2 -
>  .../{ =3D> driver-api}/smsc_ece1099.rst         |  2 -
>  .../{ =3D> driver-api}/speculation.rst          |  8 +--
>  .../{ =3D> driver-api}/static-keys.rst          |  2 -
>  Documentation/{ =3D> driver-api}/switchtec.rst  |  4 +-
>  Documentation/{ =3D> driver-api}/sync_file.rst  |  2 -
>  Documentation/{ =3D> driver-api}/tee.rst        |  2 -
>  .../{ =3D> driver-api}/this_cpu_ops.rst         |  2 -
>  .../unaligned-memory-access.rst               |  2 -
>  .../{ =3D> driver-api}/vfio-mediated-device.rst |  4 +-
>  Documentation/{ =3D> driver-api}/vfio.rst       |  2 -
>  Documentation/{ =3D> driver-api}/xillybus.rst   |  2 -
>  Documentation/{ =3D> driver-api}/xz.rst         |  2 -
>  Documentation/{ =3D> driver-api}/zorro.rst      |  2 -
>  Documentation/driver-model/device.rst         |  2 +-
>  Documentation/fb/fbcon.rst                    |  4 +-
>  Documentation/filesystems/sysfs.txt           |  2 +-
>  Documentation/gpu/drm-mm.rst                  |  2 +-
>  Documentation/ia64/irq-redir.rst              |  2 +-
>  Documentation/laptops/thinkpad-acpi.rst       |  6 +-
>  Documentation/locking/rt-mutex.rst            |  2 +-
>  Documentation/networking/scaling.rst          |  4 +-
>  Documentation/s390/vfio-ccw.rst               |  6 +-
>  Documentation/sysctl/kernel.rst               |  2 +-
>  Documentation/sysctl/vm.rst                   |  2 +-
>  Documentation/trace/kprobetrace.rst           |  2 +-
>  Documentation/translations/zh_CN/IRQ.txt      |  4 +-
>  .../translations/zh_CN/filesystems/sysfs.txt  |  2 +-
>  .../translations/zh_CN/io_ordering.txt        |  4 +-
>  Documentation/w1/w1.netlink                   |  2 +-
>  Documentation/watchdog/hpwdt.rst              |  2 +-
>  MAINTAINERS                                   | 46 ++++++-------
>  arch/Kconfig                                  |  4 +-
>  arch/unicore32/include/asm/io.h               |  2 +-
>  drivers/base/core.c                           |  2 +-
>  drivers/char/ipmi/Kconfig                     |  2 +-
>  drivers/char/ipmi/ipmi_si_hotmod.c            |  2 +-
>  drivers/char/ipmi/ipmi_si_intf.c              |  2 +-
>  drivers/dma-buf/Kconfig                       |  2 +-
>  drivers/gpio/Kconfig                          |  2 +-
>  drivers/gpu/drm/Kconfig                       |  2 +-
>  drivers/pci/switch/Kconfig                    |  2 +-
>  drivers/platform/x86/Kconfig                  |  4 +-
>  drivers/platform/x86/dcdbas.c                 |  2 +-
>  drivers/platform/x86/dell_rbu.c               |  2 +-
>  drivers/pnp/isapnp/Kconfig                    |  2 +-
>  drivers/tty/Kconfig                           |  2 +-
>  drivers/vfio/Kconfig                          |  2 +-
>  drivers/vfio/mdev/Kconfig                     |  2 +-
>  drivers/w1/Kconfig                            |  2 +-
>  include/asm-generic/bitops/atomic.h           |  2 +-
>  include/linux/io-mapping.h                    |  2 +-
>  include/linux/jump_label.h                    |  2 +-
>  include/linux/kobject.h                       |  2 +-
>  include/linux/kobject_ns.h                    |  2 +-
>  include/linux/rbtree.h                        |  2 +-
>  include/linux/rbtree_augmented.h              |  2 +-
>  init/Kconfig                                  |  2 +-
>  kernel/padata.c                               |  2 +-
>  lib/Kconfig                                   |  2 +-
>  lib/Kconfig.debug                             |  2 +-
>  lib/crc32.c                                   |  2 +-
>  lib/kobject.c                                 |  4 +-
>  lib/lzo/lzo1x_decompress_safe.c               |  2 +-
>  lib/xz/Kconfig                                |  2 +-
>  mm/Kconfig                                    |  2 +-
>  mm/nommu.c                                    |  2 +-
>  samples/Kconfig                               |  2 +-
>  samples/kprobes/kprobe_example.c              |  2 +-
>  samples/kprobes/kretprobe_example.c           |  2 +-
>  scripts/gcc-plugins/Kconfig                   |  2 +-
>  tools/include/linux/rbtree.h                  |  2 +-
>  tools/include/linux/rbtree_augmented.h        |  2 +-
>  132 files changed, 173 insertions(+), 235 deletions(-)
>  rename Documentation/{ =3D> driver-api}/atomic_bitops.rst (99%)
>  rename Documentation/{ =3D> driver-api}/bt8xxgpio.rst (99%)
>  rename Documentation/{ =3D> driver-api}/bus-virt-phys-mapping.rst (99%)
>  rename Documentation/{connector =3D> driver-api}/connector.rst (99%)
>  rename Documentation/{console =3D> driver-api}/console.rst (99%)
>  rename Documentation/{ =3D> driver-api}/crc32.rst (99%)
>  rename Documentation/{ =3D> driver-api}/dcdbas.rst (99%)
>  rename Documentation/{ =3D> driver-api}/debugging-modules.rst (98%)
>  rename Documentation/{ =3D> driver-api}/debugging-via-ohci1394.rst (99%)
>  rename Documentation/{ =3D> driver-api}/dell_rbu.rst (99%)
>  rename Documentation/{ =3D> driver-api}/digsig.rst (99%)
>  rename Documentation/{EDID/howto.rst =3D> driver-api/edid.rst} (99%)
>  rename Documentation/{ =3D> driver-api}/eisa.rst (99%)
>  rename Documentation/{ =3D> driver-api}/futex-requeue-pi.rst (99%)
>  rename Documentation/{ =3D> driver-api}/gcc-plugins.rst (99%)
>  rename Documentation/{ =3D> driver-api}/hwspinlock.rst (99%)
>  rename Documentation/{ =3D> driver-api}/io-mapping.rst (99%)
>  rename Documentation/{ =3D> driver-api}/io_ordering.rst (99%)
>  rename Documentation/{IPMI.rst =3D> driver-api/ipmi.rst} (99%)
>  rename Documentation/{IRQ-affinity.rst =3D> driver-api/irq-affinity.rst}=
 (99%)
>  rename Documentation/{IRQ-domain.rst =3D> driver-api/irq-domain.rst} (99=
%)
>  rename Documentation/{IRQ.rst =3D> driver-api/irq.rst} (99%)
>  rename Documentation/{ =3D> driver-api}/irqflags-tracing.rst (99%)
>  rename Documentation/{ =3D> driver-api}/isa.rst (99%)
>  rename Documentation/{ =3D> driver-api}/isapnp.rst (98%)
>  rename Documentation/{ =3D> driver-api}/kobject.rst (99%)
>  rename Documentation/{ =3D> driver-api}/kprobes.rst (99%)
>  rename Documentation/{ =3D> driver-api}/kref.rst (99%)
>  rename Documentation/{lightnvm/pblk.txt =3D> driver-api/lightnvm-pblk.rs=
t} (100%)
>  rename Documentation/{ =3D> driver-api}/lzo.rst (99%)
>  rename Documentation/{ =3D> driver-api}/mailbox.rst (99%)
>  rename Documentation/{ =3D> driver-api}/men-chameleon-bus.rst (99%)
>  rename Documentation/{ =3D> driver-api}/nommu-mmap.rst (99%)
>  rename Documentation/{ =3D> driver-api}/ntb.rst (99%)
>  rename Documentation/{nvmem =3D> driver-api}/nvmem.rst (99%)
>  rename Documentation/{ =3D> driver-api}/padata.rst (99%)
>  rename Documentation/{ =3D> driver-api}/parport-lowlevel.rst (99%)
>  rename Documentation/{ =3D> driver-api}/percpu-rw-semaphore.rst (99%)
>  rename Documentation/{ =3D> driver-api}/pi-futex.rst (99%)
>  rename Documentation/{ =3D> driver-api}/preempt-locking.rst (99%)
>  rename Documentation/{pti =3D> driver-api}/pti_intel_mid.rst (99%)
>  rename Documentation/{ =3D> driver-api}/pwm.rst (99%)
>  rename Documentation/{ =3D> driver-api}/rbtree.rst (99%)
>  rename Documentation/{ =3D> driver-api}/remoteproc.rst (99%)
>  rename Documentation/{ =3D> driver-api}/rfkill.rst (99%)
>  rename Documentation/{ =3D> driver-api}/robust-futex-ABI.rst (99%)
>  rename Documentation/{ =3D> driver-api}/robust-futexes.rst (99%)
>  rename Documentation/{ =3D> driver-api}/rpmsg.rst (99%)
>  rename Documentation/{ =3D> driver-api}/sgi-ioc4.rst (99%)
>  rename Documentation/{SM501.rst =3D> driver-api/sm501.rst} (99%)
>  rename Documentation/{ =3D> driver-api}/smsc_ece1099.rst (99%)
>  rename Documentation/{ =3D> driver-api}/speculation.rst (99%)
>  rename Documentation/{ =3D> driver-api}/static-keys.rst (99%)
>  rename Documentation/{ =3D> driver-api}/switchtec.rst (97%)
>  rename Documentation/{ =3D> driver-api}/sync_file.rst (99%)
>  rename Documentation/{ =3D> driver-api}/tee.rst (99%)
>  rename Documentation/{ =3D> driver-api}/this_cpu_ops.rst (99%)
>  rename Documentation/{ =3D> driver-api}/unaligned-memory-access.rst (99%)
>  rename Documentation/{ =3D> driver-api}/vfio-mediated-device.rst (99%)
>  rename Documentation/{ =3D> driver-api}/vfio.rst (99%)
>  rename Documentation/{ =3D> driver-api}/xillybus.rst (99%)
>  rename Documentation/{ =3D> driver-api}/xz.rst (99%)
>  rename Documentation/{ =3D> driver-api}/zorro.rst (99%)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--x1F0m3RQhDZyj8sd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0J8TwACgkQ3SOs138+
s6FwnBAAgAw4Y4VTIu9fC7EKqGeq67QHb5tbw5DZb3z2ZbpFT2k82eX/X5PTclLE
yPDjKTqXPGwQ7MnAmYqcMZGlWdrkYXS0/n/nEQ7cpbpzVaOA7NJzs58dgr48qAb0
bWHbIpuKXs5LAQp/JjrW1bLYDZOSFf3QKpOYJ999lI6qo5peqP+Oi5kIZuob/RYe
MayT0gsMmjD39kEVWQny/DchbJj+oa4US5kw3mo3JgYdbIDGgj28urwUBCBOgBsH
IkWf/8NdCW0ypWrTonk0jxmEZy9MAhW8XkIQ/Xu5VzOWVomXOK8KF2SIczESlGSr
HpZSWhxgu1/sGitcWoPlQM6H2nFOOQIPRLAR53vzCc1KMeYfQ5uBDqsCw8im+lkw
qkXrljQ5mmFmFN0eVt38/hR/LzEofvCOF8LySe4+Ho5jZj0Fkr3istEObrFfks7l
CAhqy+UEYLxujLZ95dHPq3vvKSq56XQj4xmSZ3QCB2PJ9xAgGXywCURXN+euFk2r
JX6l+AVuQrNJy8sffyugZO1QX7AjcuDYScZsuKn6w/J1jih9NmpPe0UMbYXDHoJ/
ZSIYMZgi4RMjlmh71fAg4ClUsQ5G5UPwAlUm2CcmAfrFKZJfkUu1SnI406y0xe0Y
n/mzJsnMuPU8hgQkzfBGPpEInrOG3Bqr+G9L80TZR/7j+sBFBlA=
=iOMR
-----END PGP SIGNATURE-----

--x1F0m3RQhDZyj8sd--

--===============1027878540==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============1027878540==--
