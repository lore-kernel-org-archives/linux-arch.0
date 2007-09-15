Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.189]:7895 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbXIOIrU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 15 Sep 2007 04:47:20 -0400
Received: by fk-out-0910.google.com with SMTP id z23so970432fkz
        for <linux-arch@vger.kernel.org>; Sat, 15 Sep 2007 01:47:18 -0700 (PDT)
Message-ID: <46EB9BD7.9050209@gmail.com>
Date: Sat, 15 Sep 2007 10:46:15 +0200
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
MIME-Version: 1.0
Subject: ELF randomization questions 
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hello,

I have a couple questions about the process stack randomization but
I'm not sure who should be CCed for such questions.

I submitted a patch to enable 'inside the page' stack randomization on
MIPS few weeks ago and which has been now committed. But I noticed
that this patch is actually useless because this randomization depends
on ELF_PLATFORM symbol to be defined which it isn't on MIPS. All of
this happens in create_elf_tables() function defined in
fs/binfmt_elf.c.

So my first question is now, why is this dependency for ? Can we
remove it and unconditionally do the 'inside the page' randomization
for platforms that implement it ?  I'm not sure how ELF_PLATFORM is
used, I guess it is used later by ld.so on certain architectures but
dunno how.

The second question is that the stack randomization is currently
mainly part of the elf code, but shouldn't it be put in exec.c and
thus be used by all others binary handlers ?

thanks for any hints.

		Franck
