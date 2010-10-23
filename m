From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq@rere.qmqm.pl>
Subject: Re: [PATCH] percpu: Introduce a read-mostly percpu API
Date: Sat, 23 Oct 2010 04:25:45 +0200
Message-ID: <20101023022545.GA18876@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:57993 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751204Ab0JWCZr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 22 Oct 2010 22:25:47 -0400
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

Commit c957ef2c59e952803766ddc22e89981ab534606f that just went into
Linus' tree has a bug - only one of hunks was modified (.readmostly
moved after .page_aligned).


>commit c957ef2c59e952803766ddc22e89981ab534606f
>Author: Shaohua Li <shaohua.li@intel.com>
>Date:   Wed Oct 20 11:07:02 2010 +0800
>
>    percpu: Introduce a read-mostly percpu API
>   =20
>    Add a new readmostly percpu section and API.  This can be used to
>    avoid dirtying data lines which are generally not written to, whic=
h is
>    especially important for data which may be accessed by processors
>    other than the one for which the percpu area belongs to.
>   =20
>    [ hpa: moved it *after* the page-aligned section, for obvious
>      reasons. ]
>   =20
>    Signed-off-by: Shaohua Li <shaohua.li@intel.com>
>    LKML-Reference: <1287544022.4571.7.camel@sli10-conroe.sh.intel.com=
>
>    Cc: Eric Dumazet <eric.dumazet@gmail.com>
>    Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/v=
mlinux.lds.h
>index 8a92a17..d7e7b21 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -677,7 +677,9 @@
> 				- LOAD_OFFSET) {			\
> 		VMLINUX_SYMBOL(__per_cpu_start) =3D .;			\
> 		*(.data..percpu..first)					\
>+		. =3D ALIGN(PAGE_SIZE);					\
> 		*(.data..percpu..page_aligned)				\
>+		*(.data..percpu..readmostly)				\
> 		*(.data..percpu)					\
> 		*(.data..percpu..shared_aligned)			\
> 		VMLINUX_SYMBOL(__per_cpu_end) =3D .;			\
>@@ -703,6 +705,8 @@
> 		VMLINUX_SYMBOL(__per_cpu_load) =3D .;			\
> 		VMLINUX_SYMBOL(__per_cpu_start) =3D .;			\
> 		*(.data..percpu..first)					\
>+		. =3D ALIGN(PAGE_SIZE);					\
>+		*(.data..percpu..readmostly)				\
> 		*(.data..percpu..page_aligned)				\

Here.

> 		*(.data..percpu)					\
> 		*(.data..percpu..shared_aligned)			\
[...]

Best Regards,
Micha=B3 Miros=B3aw
