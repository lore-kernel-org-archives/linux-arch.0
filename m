Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sat, 4 Jun 2005 14:24:13 -0600
From: Grant Grundler <grundler@parisc-linux.org>
Subject: Consolidate endian/swap driver API into 4 calls?
Message-ID: <20050604202413.GH19823@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-arch@vger.kernel.org
Cc: grundler@parisc-linux.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

The endian conversion (swap) macros don't handle "unsigned long" case.
We end up having to #ifdef CONFIG_64BIT around that code.
"Unsigned long" is typically used when searching or manipulating
bit arrays/maps or other in memory byte streams.
HW accesses will always need to use a fixed size (e.g u32).

My last encounter with this issue is the bitfield munging
in drivers/usb/hid/hid-core.c:extract(). I rewrote it to
use "unsigned long" and needed to add an #ifdef to deal
with le32_to_cpu() vs le64_to_cpu().

I'd like to know if people are interested in reducing the
swap API to four macros:
	cpu_to_le(x), cpu_to_be(x), le_to_cpu(x), be_to_cpu(x)

and require the caller declare or cast "x" to the right size.
switch(sizeof(x)) would then select the right arch specific variant.

I have a hard time judging if the risk of introducing subtle bugs
is a good tradeoff for simpler API.

thanks,
grant
