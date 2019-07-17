From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Date: Wed, 17 Jul 2019 09:44:35 +0200
Message-ID: <20190717074435.GU3419@hirez.programming.kicks-ass.net>
References: <20190715192536.104548-1-alex.kogan@oracle.com>
 <20190715192536.104548-4-alex.kogan@oracle.com>
 <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <9fa54e98-0b9b-0931-db32-c6bd6ccfe75b@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com, jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, Alex Kogan <alex.kogan@oracle.com>, steven.sistare@oracle.com, tglx@linutronix.de, daniel.m.jordan@oracle.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 16, 2019 at 10:16:29PM -0400, Waiman Long wrote:
>  A simple graphic to illustrate those queues will help too, for example

Very much yes!

> /*
> =A0* MCS lock holder
> =A0* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =A0*=A0=A0=A0 mcs_node
> =A0*=A0=A0 +--------+=A0=A0=A0=A0=A0 +----+=A0=A0=A0=A0=A0=A0=A0=A0 +----+
> =A0*=A0=A0 | next=A0=A0 | ---> |next| -> ...=A0 |next| -> NULL=A0 [Main q=
ueue]
> =A0*=A0=A0 | locked | -+=A0=A0 +----+=A0=A0=A0=A0=A0=A0=A0=A0 +----+
> =A0*=A0=A0 +--------+=A0 |
> =A0*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 +----+=A0=A0=A0=A0=
=A0=A0=A0=A0 +----+
> =A0*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-> |next| -> ...=A0 |next=
| -> X=A0=A0=A0=A0 [Secondary queue]
> =A0*=A0=A0=A0 cna_node=A0=A0=A0=A0=A0=A0 +----+=A0=A0=A0=A0=A0=A0=A0=A0 +=
----+
> =A0*=A0=A0 +--------*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 ^
> =A0*=A0=A0 | tail=A0=A0 | ----------------------+
> =A0*=A0=A0 +--------*=A0=A0=A0

Almost; IIUC that cna_node is the same as the one from locked, so you
end up with something like:

> =A0*=A0=A0=A0 mcs_node
> =A0*=A0=A0 +--------+=A0=A0=A0=A0=A0 +----+=A0=A0=A0=A0=A0=A0=A0=A0 +----+
> =A0*=A0=A0 | next=A0=A0 | ---> |next| -> ...=A0 |next| -> NULL=A0 [Main q=
ueue]
> =A0*=A0=A0 | locked | -+=A0=A0 +----+=A0=A0=A0=A0=A0=A0=A0=A0 +----+
> =A0*=A0=A0 +--------+=A0 |
> =A0*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0=A0 +---------+=A0=A0=
=A0=A0=A0=A0=A0=A0 +----+
> =A0*=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +-> |mcs::next| -> ...=A0 =
|next| -> NULL=A0=A0=A0=A0 [Secondary queue]
>  *                   |cna::tail| -+      +----+
> =A0*=A0=A0=A0          =A0=A0=A0=A0=A0 +---------+  |        ^
>  *                                +--------+
> =A0*
> =A0* N.B. locked =3D 1 if secondary queue is absent.
> =A0*/
