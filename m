Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] set_pte() part 1 (was Re: [PATCH] ppc32: Wrong vaddr in flush_hash_one_pte())
Date: Wed, 23 Feb 2005 16:55:50 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F02F5D4B4@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "David S. Miller" <davem@davemloft.net>, Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>I've been over this a few times this afternoon and the patch looks
>correct.  Please test the build and boot of your platform, any build
>failures should be trivial typos and nothing major.

Builds (no new warnings) and boots on ia64.

-Tony
