Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ares61.inai.de ([5.9.23.85]:44836 "EHLO ares60.inai.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753450AbbA0VUT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 27 Jan 2015 16:20:19 -0500
Date: Tue, 27 Jan 2015 22:12:07 +0100 (CET)
From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [opensuse-factory] Re: [opensuse-kernel] libsigsegv build fail
 with kernel 3.18.3
In-Reply-To: <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.1501272205130.3450@nerf60.vanv.qr>
References: <1422361485.6648.71.camel@opensuse.org> <54C78756.9090605@suse.cz> <alpine.LSU.2.11.1501271347440.30227@nerf60.vanv.qr> <1422364084.6648.82.camel@opensuse.org> <s5h7fw8hvdp.wl-tiwai@suse.de>
 <CA+55aFyzy_wYHHnr2gDcYr7qcgOKM2557bRdg6RBa=cxrynd+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, opensuse-factory@opensuse.org, OpenSUSE Kernel Team <opensuse-kernel@opensuse.org>, linux-arch@vger.kernel.org
Message-ID: <20150127211207.GAU3Wu8ygtEkEquSUo94xc_sb5bGX4mzFEKaFubW_zg@z>


On Tuesday 2015-01-27 21:36, Linus Torvalds wrote:
>The only reason it returns SIGBUS is that we don't have an equivalent
>VM_FAULT_SIGSEGV error return.  Which is something of an oversight,
>but adding it is a pain too, simply because the callers are mainly the
>architecture page fault handlers, so the VM_FAULT_SIGSEGV handling has
>to be added to all of them.
>
>Very annoying. The patch would look something like the attached -
>TOTALLY UNTESTED.
>
>Does this fix things for you?

The 2nd patch (from 12:57:20 -0800) plus the one-liner for mm/memory.c
at the callsite for check_stack_guard_page makes the test still 
not succeed.
