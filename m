From: Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Tue, 11 Mar 2008 11:02:51 +0100
Message-ID: <200803111102.51653.borntraeger@de.ibm.com>
References: <200803071326.06682.borntraeger@de.ibm.com> <200803110810.49759.borntraeger@de.ibm.com> <je7ig9hag4.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <je7ig9hag4.fsf-+JVCjXrnBTholqkO4TVVkw@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab-l3A5Bk7waGM@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>, Sam Ravnborg <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Am Dienstag, 11. M=E4rz 2008 schrieb Andreas Schwab:
> Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org> writes:
>=20
> >  include/asm-alpha/kvm.h        |    6 ++++++
>=20
> Can't you put it in asm-generic?

I dont think so. The generic part is in include/linux/kvm.h. asm/kvm.h =
is=20
populated by each architecture which gets kvm support with arch specfic=
=20
definitions. x86 has support and s390, powerpc and ia64 are currently k=
now=20
to work on ports.=20


Christian
--
To unsubscribe from this list: send the line "unsubscribe linux-arch" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
