Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:47974 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727948AbfJNNiw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Oct 2019 09:38:52 -0400
Date: Mon, 14 Oct 2019 15:38:43 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 04/28] x86/asm/entry: Annotate THUNKs
Message-ID: <20191014133843.GC4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-5-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
Message-ID: <20191014133843.g0FOVlqwir6U6BpWKRvH35EMo4h4_gMOeNhzQeVbxe8@z>

On Fri, Oct 11, 2019 at 01:50:44PM +0200, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.

Yeah, I guess the NOALIGN is causing some relaxing of alignment because
the symbols all "move up", from looking at the addresses:

before:
$ readelf -a vmlinux | grep -E "\W(trace_hardirqs_o(n|ff)_thunk|lockdep_sys_exit_thunk|___preempt_schedule)"
 70007: ffffffff81001c60    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78467: ffffffff81001c40    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82067: ffffffff81001cc0    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86509: ffffffff81001c80    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 87594: ffffffff81001ca0    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

after:
$ readelf -a vmlinux | grep -E "\W(trace_hardirqs_o(n|ff)_thunk|lockdep_sys_exit_thunk|___preempt_schedule)"
 70007: ffffffff81001c50    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78467: ffffffff81001c34    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82067: ffffffff81001c9c    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86509: ffffffff81001c6c    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 87594: ffffffff81001c84    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
