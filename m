Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: Double free of initramfs
Date: Tue, 22 Mar 2005 15:07:07 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F032117C0@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Sam Ravnborg <sam@ravnborg.org>, Ralf Baechle <ralf@linux-mips.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Adrian Bunk <bunk@stusta.de>
List-ID: <linux-arch.vger.kernel.org>

>+
>+/* initramfs area. */
>+# define INITRAMFS		\
>+	. = ALIGN(4096);		\
>+	.init.ramfs : {						

Why the 4096 alignment?  If you need it page aligned (and I can't
see why you would), then bear in mind that not all architectures
use a 4k pagesize.

-Tony
