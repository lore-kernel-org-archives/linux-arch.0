From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: semantics of KSTK_ESP and friends
Date: Thu, 12 Feb 2015 07:10:06 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230756658D08C@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay2.synopsys.com ([198.182.60.111]:33062 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbbBLHKL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 12 Feb 2015 02:10:11 -0500
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, james Hogan <james.hogan@imgtec.com>
Cc: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, al Viro <viro@ZenIV.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>

Hi,

Is KSTK_ESP supposed to return the kernel mode SP of a sleeping task or is it supposed to provide the user mode SP at the time of last kernel entry ?

The 2 non arch users of the API expect the user mode SP semantics:
* vm_is_stack_for_task() - to annotate /proc/<pid>/maps stack vma - which is shere Alexey noted this.
* do_task_stat()

ARC port uses these for unwinding the task of a sleeping task (hence kernel mode SP semantics).
metag (from the looks of it) also seem to provide kernel mode value, while most others seem to provide the user mode variant.

 I can fix ARC to work with expectation of generic code, but wanted to understand anyways.

Thx,
-Vineet
