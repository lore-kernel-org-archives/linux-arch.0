From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v7 4/5] locking/qspinlock: Introduce starvation avoidance
 into CNA
Date: Fri, 6 Dec 2019 13:09:40 -0500
Message-ID: <3d06a43e-0cf7-dc47-a2c7-7a9145a29ad5@redhat.com>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-5-alex.kogan@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191125210709.10293-5-alex.kogan@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Kogan <alex.kogan@oracle.com>, linux@armlinux.org.uk, peterz@infradead.org, mingo@redhat.com, will.deacon@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de, hpa@zytor.com, x86@kernel.org, guohanjun@huawei.com, jglauber@marvell.com
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, dave.dice@oracle.com, rahul.x.yadav@oracle.com
List-Id: linux-arch.vger.kernel.org

On 11/25/19 4:07 PM, Alex Kogan wrote:
> Keep track of the number of intra-node lock handoffs, and force
> inter-node handoff once this number reaches a preset threshold.
> The default value for the threshold can be overridden with
> the new kernel boot command-line option "numa_spinlock_threshold".
>
> Signed-off-by: Alex Kogan <alex.kogan@oracle.com>
> Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++++++
>  arch/x86/kernel/alternative.c                 | 27 +++++++++++++++++++
>  kernel/locking/qspinlock.c                    |  3 +++
>  kernel/locking/qspinlock_cna.h                | 27 ++++++++++++++++---
>  4 files changed, 62 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 904cb32f592d..887fbfce701d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3185,6 +3185,14 @@
>  =09=09=09Not specifying this option is equivalent to
>  =09=09=09numa_spinlock=3Dauto.
> =20
> +=09numa_spinlock_threshold=3D=09[NUMA, PV_OPS]
> +=09=09=09Set the threshold for the number of intra-node
> +=09=09=09lock hand-offs before the NUMA-aware spinlock
> +=09=09=09is forced to be passed to a thread on another NUMA node.
> +=09=09=09Valid values are in the [0..31] range. Smaller values
> +=09=09=09result in a more fair, but less performant spinlock, and
> +=09=09=09vice versa. The default value is 16.
> +
>  =09cpu0_hotplug=09[X86] Turn on CPU0 hotplug feature when
>  =09=09=09CONFIG_BOOTPARAM_HOTPLUG_CPU0 is off.
>  =09=09=09Some features depend on CPU0. Known dependencies are:
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.=
c
> index 6a4ccbf4e09c..28552e0491b5 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -723,6 +723,33 @@ static int __init numa_spinlock_setup(char *str)
> =20
>  __setup("numa_spinlock=3D", numa_spinlock_setup);
> =20
> +/*
> + * Controls the threshold for the number of intra-node lock hand-offs be=
fore
> + * the NUMA-aware variant of spinlock is forced to be passed to a thread=
 on
> + * another NUMA node. By default, the chosen value provides reasonable
> + * long-term fairness without sacrificing performance compared to a lock
> + * that does not have any fairness guarantees.
> + */
> +int intra_node_handoff_threshold =3D 1 << 16;

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ro_after_init

> +
> +static int __init numa_spinlock_threshold_setup(char *str)
> +{
> +=09int new_threshold_param;
> +
> +=09if (get_option(&str, &new_threshold_param)) {
> +=09=09/* valid value is between 0 and 31 */
> +=09=09if (new_threshold_param < 0 || new_threshold_param > 31)
> +=09=09=09return 0;
> +
> +=09=09intra_node_handoff_threshold =3D 1 << new_threshold_param;
> +=09=09return 1;
> +=09}
> +
> +=09return 0;
> +}
> +
> +__setup("numa_spinlock_threshold=3D", numa_spinlock_threshold_setup);
> +
>  #endif
> =20

Against, this should be in qspinlock_can.h not in alternative.c.

Cheers,
Longman
