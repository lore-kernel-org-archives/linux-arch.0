From: Christian Borntraeger <borntraeger-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
Subject: Re: [patch 06/24] kvm: provide kvm.h for all architecture: fixes headers_install
Date: Fri, 28 Mar 2008 22:51:34 +0100
Message-ID: <200803282251.34635.borntraeger@de.ibm.com>
References: <200803282115.m2SLFscm010265@imap1.linux-foundation.org> <alpine.LFD.1.00.0803281435090.14670@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.LFD.1.00.0803281435090.14670-5CScLwifNT1QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org

Am Freitag, 28. M=E4rz 2008 schrieb Linus Torvalds:
> That makes no sense. Commit 040922c04cf2c8ac70be2e88a8a9614ecdb41d2e =
is=20
> "include falloc.h in header-y", and seems to have nothing to do with=20
> kvm.h.
[...]
> So please - add the one-liner to all SHA1 ones, so that non-git peopl=
e see=20
> what it is all about, and so that people who just read the commit log=
 can=20
> make sense of it. And in trying to make sense of it, it can become ob=
vious=20
> that it doesn't actually make any sense!

Sorry, you are right. The proper commit is=20
fb56dbb31c4738a3918db81fd24da732ce3b4ae6 (KVM: Export include/linux/kvm=
=2Eh=20
only if $ARCH actually supports KVM) and I have clue at all, why I wrot=
e=20
the wrong SHA1 id. Sorry, I will double check the next time and also ad=
d=20
the description.

Christian
