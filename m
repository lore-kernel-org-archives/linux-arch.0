From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: [RFC] Normalizing byteorder/unaligned access API
Date: Tue, 07 Oct 2008 14:53:11 -0700
Message-ID: <1223416391.8195.22.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:5399 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120AbYJGVxQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Oct 2008 17:53:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3637335wfd.4
        for <linux-arch@vger.kernel.org>; Tue, 07 Oct 2008 14:53:15 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, James Bottomley <James.Bottomley@HansenPartnership.com>, Matthew Wilcox <matthew@wil.cx>, linux-scsi <linux-scsi@vger.kernel.org>, Boaz Harrosh <bharrosh@panasas.com>

[related question regarding the SCSI-private endian helper needs at the end]

Currently on the read side, we have (le16 as an example endianness)

le16_to_cpup(__le16 *)
get_unaligned_le16(void *)

And on the write side:

*(__le16)ptr = cpu_to_le16(u16)
put_unaligned_le16(u16, void *);

On the read side, Al said he would have preferred the unaligned version
take the same types as the aligned, rather than void *.  AKPM didn't think
the use of get_ was that great as get/put generally implies some kind of reference
taking in the kernel.

As the le16_to_cpup has been around for so long and is more recognizable, let's
make it the same for the unaligned case and typesafe:

le16_to_cpup(__le16 *)
unaligned_le16_to_cpup(__le16 *)

On the write side, the above get/put and type issues are still there, in addition AKPM felt
that the ordering of the put_unaligned parameters was opposite what was intuitive and that
the pointer should come first.

In this case, as there is currently no aligned helper (other than in some drivers defining macros)
define the api thusly:

Aligned:
write_le16(__le16 *ptr, u16 val)

Unaligned:
unaligned_write_le16(__le16 *ptr, u16 val)

The existing get/put_unaligned macros do not necessarily need to be modified.  It would
present one oddity that the parameter order was different, but that's not a huge issue.

These could be phased in as they do not collide with the current API and the old api converted
over fairly quickly as not many places use the get/put_unaligned_{endian} helpers yet.

In addition, there are some subsystems (scsi) that are looking into some differently sized
endian helpers (be24) and it may be worthwhile to have some agreement whether it is worth
making them common infrastructure and whether they should present a similar API to the
common byteorder/unaligned API.

Is this a worthwhile direction to take?

Cheers,

Harvey
