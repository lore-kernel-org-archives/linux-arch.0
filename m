From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: + drivers-acpi-apei-erst-dbgc-get_useru64-doesnt-work-on-i386.patch
 added to -mm tree
Date: Wed, 11 Aug 2010 21:22:51 -0700
Message-ID: <4C63771B.6030005@zytor.com>
References: <201008112336.o7BNaNEj020805@imap1.linux-foundation.org>	<20100811164310.a4790773.randy.dunlap@oracle.com> <20100811173327.3ae325ff.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100811173327.3ae325ff.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, gcosta@redhat.com, lenb@kernel.org, mingo@elte.hu, tglx@linutronix.de, ying.huang@intel.com, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

[Adding Linux and linux-arch.  The context is that get_user/put_user
don't work on 64 bit values on i386.]

On 08/11/2010 05:33 PM, Andrew Morton wrote:
>=20
> Anyway, this should be fixed in x86 core, I suspect.

After looking at it -- and suffering a bad case of d=C3=A9j=C3=A0 vu --=
 I'm
reluctant to change it, as get/put_user are specified to work only on
locally atomic data:

 * This macro copies a single simple variable from user space to kernel
 * space.  It supports simple types like char and int, but not larger
 * data types like structures or arrays.

Given that u64 is not a simple type on 32 bits, it would appear that th=
e
behavior is intentional.

A user might very well find that supporting u64 and/or structure types
would be beneficial, but it would a) be a semantic change, and b) would
introduce the possibility of a partially completed transfer.  That is a
semantic change to the interface.  However, it may very well be nicer t=
o
have a generally available get_user()/put_user() for the cases which
would just kick an EFAULT up the stack when they fail anyway.

If there is consensus for making get_user/put_user a general interface,
I'm more than willing to do the x86 changes, but I don't want to do the=
m
a) unilaterally and b) for 2.6.36.  This seems like .37 material at thi=
s
point.

	-hpa

--=20
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
