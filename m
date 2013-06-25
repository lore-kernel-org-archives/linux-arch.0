From: Chen Gang <gang.chen@asianux.com>
Subject: [Suggestion] arch: s390: mm: the warnings with allmodconfig and "EXTRA_CFLAGS=-W"
Date: Tue, 25 Jun 2013 09:54:41 +0800
Message-ID: <51C8F861.9010101@asianux.com>
References: <51C8F685.6000209@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <51C8F685.6000209@asianux.com>
Sender: owner-linux-mm@kvack.org
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com, cornelia.huck@de.ibm.com, mtosatti@redhat.com, Thomas Gleixner <tglx@linutronix.de>, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

Hello Maintainers:

When allmodconfig for " IBM zSeries model z800 and z900"

It will report the related warnings ("EXTRA_CFLAGS=3D-W"):
  mm/slub.c:1875:1: warning: =91deactivate_slab=92 uses dynamic stack all=
ocation [enabled by default]
  mm/slub.c:1941:1: warning: =91unfreeze_partials.isra.32=92 uses dynamic=
 stack allocation [enabled by default]
  mm/slub.c:2575:1: warning: =91__slab_free=92 uses dynamic stack allocat=
ion [enabled by default]
  mm/slub.c:1582:1: warning: =91get_partial_node.isra.34=92 uses dynamic =
stack allocation [enabled by default]
  mm/slub.c:2311:1: warning: =91__slab_alloc.constprop.42=92 uses dynamic=
 stack allocation [enabled by default]

Is it OK ?


Thanks.
--
Chen Gang

Asianux Corporation=20

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
