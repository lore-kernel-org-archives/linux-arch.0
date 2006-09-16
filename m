Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:36036 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S932283AbWIPAk1
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 15 Sep 2006 20:40:27 -0400
Received: from localhost.localdomain ([127.0.0.1]:6291 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038432AbWIPAkZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 16 Sep 2006 01:40:25 +0100
Date: Sat, 16 Sep 2006 01:40:37 +0100
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [patch 1/1] make PROT_WRITE imply PROT_READ
Message-ID: <20060916004037.GB4243@linux-mips.org>
References: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609150139.k8F1dl7Y014791@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org, jbaron@redhat.com, ak@muc.de, alan@lxorguk.ukuu.org.uk, arjan@linux.intel.com, benh@kernel.crashing.org, geert@linux-m68k.org, hugh@veritas.com, kkojima@rr.iij4u.or.jp, lethal@linux-sh.org, paulus@samba.org, rmk@arm.linux.org.uk, spyro@f2s.com, tony.luck@intel.com, zippel@linux-m68k.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 14, 2006 at 06:39:47PM -0700, akpm@osdl.org wrote:

> (akpm: needs to be split into nine patches and fed through arch trees. 
> Later.)
> 
> (err, make it's easier to just collect some acks?)

MIPS (with the exception of the 4KSd) is also affected; I've just commited
below patch.

  Ralf

diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index e3a6172..a4f8c45 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -89,7 +89,7 @@ good_area:
 		if (!(vma->vm_flags & VM_WRITE))
 			goto bad_area;
 	} else {
-		if (!(vma->vm_flags & (VM_READ | VM_EXEC)))
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)))
 			goto bad_area;
 	}
 
