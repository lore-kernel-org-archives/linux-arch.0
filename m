Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from triton.rz.uni-saarland.de ([134.96.7.25]:5921 "EHLO
	triton.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513AbYLQKAl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Dec 2008 05:00:41 -0500
From: Alexander van Heukelum <heukelum@fastmail.fm>
Subject: PROC macro to annotate functions in assembly files
Date: Wed, 17 Dec 2008 10:17:53 +0100
Message-ID: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, Cyrill Gorcunov <gorcunov@gmail.com>, Alexander van Heukelum <heukelum@fastmail.fm>
Message-ID: <20081217091753.T_T0C-gHwOCNzfJur-44CHplTM_b11vUT4YiupASyog@z>

The first patch introduces the PROC macro in the generic
header file include/linux/linkage.h to annotate functions
in assembly files. This is a first step to fully annotate
functions (procedures) in .S-files. The PROC macro
complements the already existing and being used ENDPROC
macro. The generic implementation of PROC is exactly the
same as ENTRY.

The goal is to annotate functions, at least those called
from C code, with PROC at the beginning and ENDPROC at the
end. This is for the benefit of debugging and tracing.

The second patch introduces a framework to check for nesting
problems and missing annotations by overriding ENTRY/END
and PROC/ENDPROC in x86-specific code. It should not be
applied at this time, because it will just cause the build
to fail due to existing annotation problems. I intend to
fix the annotations for the x86 assembly files in the
comming months and resubmit this second patch if this
work is comming to an end.

The first patch touches generic code, but I think it is
trivial enough that it can be introduced via the x86 tree.

Greetings,
	Alexander
