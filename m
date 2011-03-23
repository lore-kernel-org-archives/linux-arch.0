From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Link breakage on all architectures which implement their own
 show_mem
Date: Wed, 23 Mar 2011 11:41:46 -0500
Message-ID: <1300898506.15899.24.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:60879 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751719Ab1CWQlt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 23 Mar 2011 12:41:49 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Rientjes <rientjes@google.com>
Cc: linux-arch@vger.kernel.org

This is the problem a lot of architectures will see:

Specifically this:
  LD      vmlinux.o
lib/lib.a(show_mem.o): In function `show_mem':
(.text.show_mem+0x0): multiple definition of `show_mem'
arch/parisc/mm/built-in.o:(.text.show_mem+0x0): first defined here
make: *** [vmlinux.o] Error 1

Caused by this patch:

commit ddd588b5dd55f14320379961e47683db4e4c1d90
Author: David Rientjes <rientjes@google.com>
Date:   Tue Mar 22 16:30:46 2011 -0700

    oom: suppress nodes that are not allowed from meminfo on oom kill

Is the cause.  What it does is introduce a new __show_mem() which is
required by files in mm/, so the object containing it: show_mem.o gets
pulled in all the time in the link and that gives every architecture
that implements their own show_mem() a link failure because of the
double definition.  Library linking works at the file level, not at the
function level.  To work, you have to put these functions in separate
files.

James
