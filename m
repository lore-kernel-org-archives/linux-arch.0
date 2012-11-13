From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [GIT PULL] UAPI: perf fixes
Date: Tue, 13 Nov 2012 13:34:58 -0300
Message-ID: <20121113163458.GA1023@ghostprotocols.net>
References: <1378.1352379110@warthog.procyon.org.uk>
 <CA+5PVA5vMyNmQYCLX315Jc+kN9zQuZo_h0Devpjfr43TezE-qA@mail.gmail.com>
 <18065.1352820271@warthog.procyon.org.uk>
 <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yh0-f46.google.com ([209.85.213.46]:58781 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136Ab2KMQfG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 13 Nov 2012 11:35:06 -0500
Content-Disposition: inline
In-Reply-To: <CA+5PVA6qaxCzr8RBV616D3kEXyj9XjS3okeZXhJJL1R4+-Yv_A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Josh Boyer <jwboyer@gmail.com>
Cc: David Howells <dhowells@redhat.com>, xiaoguangrong@linux.vnet.ibm.com, mingo@kernel.org, haodong@linux.vnet.ibm.com, runzhen@linux.vnet.ibm.com, dsahern@gmail.com, tglx@linutronix.de, bp@alien8.de, namhyung@gmail.com, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Em Tue, Nov 13, 2012 at 10:42:02AM -0500, Josh Boyer escreveu:
> On Tue, Nov 13, 2012 at 10:24 AM, David Howells <dhowells@redhat.com> wrote:
> > Josh Boyer <jwboyer@gmail.com> wrote:
> > tools/perf/builtin-kvm.c became x86-only with the following commit:
> >
> >         commit bcf6edcd6fdb8965290f0b635a530fa3c6c212e1
> >         Author: Xiao Guangrong <xiaoguangrong@linux.vnet.ibm.com>
> >         Date:   Mon Sep 17 16:31:15 2012 +0800
> >         Subject: perf kvm: Events analysis tool
> >
> > when it added:
> >
> >         +#include "../../arch/x86/include/asm/svm.h"
> >         +#include "../../arch/x86/include/asm/vmx.h"
> >         +#include "../../arch/x86/include/asm/kvm.h"
> >
> > and my changing these to <asm/foo.h> doesn't matter because of this in the
> > same file:
> >
> >         +struct exit_reasons_table vmx_exit_reasons[] = {
> >         +       VMX_EXIT_REASONS
> >         +};
> >         +
> >         +struct exit_reasons_table svm_exit_reasons[] = {
> >         +       SVM_EXIT_REASONS
> >         +};
> >
> > which use macros only x86 defines.
> 
> Ah.  You are quite right.  So your patches actually fix the unistd.h
> error we were seeing early and just got us far enough to hit this other
> unrelated problem.  My mistake.
> 
> > Should the exported parts of these files be moved to asm-generic?
> 
> Good question.

Probably we should do Makefile changes to build 'perf kvm' only on the
platforms where it makes sense.

- Arnaldo
