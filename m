From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture:
 fixes headers_install
Date: Mon, 10 Mar 2008 23:20:39 -0700
Message-ID: <20080310232039.d2a34f5a.akpm@linux-foundation.org>
References: <200803071326.06682.borntraeger@de.ibm.com>
	<1204933418.2495.14.camel@shinybook.infradead.org>
	<200803101411.04175.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200803101411.04175.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel@lists.sourceforge.net>
List-Help: <mailto:kvm-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: kvm-devel-bounces@lists.sourceforge.net
Errors-To: kvm-devel-bounces@lists.sourceforge.net
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-arch@vger.kernel.org, mm-commits@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, Avi Kivity <avi@qumranet.com>, David Howells <dhowells@redhat.com>, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-arch.vger.kernel.org

On Mon, 10 Mar 2008 14:11:04 +0100 Christian Borntraeger <borntraeger@de.ib=
m.com> wrote:

> [PATCH v2] kvm: provide kvm.h for all architecture: fixes headers_install
> =

> Currently include/linux/kvm.h is not considered by make headers_install, =

> because Kbuild cannot handle " unifdef-$(CONFIG_FOO) +=3D foo.h. =

> This problem was introduced by 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e, =

> which makes this an 2.6.25 regression.
> =

> One way of solving the issue is to enhance Kbuild, but Avi Kivity and Dav=
id
> Woodhouse conviced me, that changing headers_install is not the way to go=
. =

> This patch changes the definition for linux/kvm.h to unifdef-y.
> =

> If =A0unifdef-y is used for linux/kvm.h "make headers_check" will fail on=
 all
> architectures without asm/kvm.h. Therefore, this patch also provides =

> asm/kvm.h on all architectures.
> =

> Changes since v1:
> o use asm-generic/Kbuild.asm (Arnd Bergmann)
> o fix comment in asm-frv (David Howells)

err, this doesn't work.

alpha and m68k (at least) fail make headers_check

/usr/src/devel/usr/include/linux/kvm.h requires asm/kvm.h, which does not e=
xist in exported headers

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
