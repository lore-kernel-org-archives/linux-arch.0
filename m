Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:45440 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfHOMmn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Aug 2019 08:42:43 -0400
Date: Thu, 15 Aug 2019 14:43:28 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v8 04/28] x86/asm/entry: annotate THUNKs
Message-ID: <20190815124328.GG15313@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-5-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190815124328.jv_-QB4GZNHaCMyk-Fe-Cq6UhUinPL4QjqdJMWoWTHw@z>

On Thu, Aug 08, 2019 at 12:38:30PM +0200, Jiri Slaby wrote:
> Place SYM_*_START_NOALIGN and SYM_*_END around the THUNK macro body.
> Preserve @function by FUNC (64bit) and CODE (32bit). Given it was not
> marked as aligned, use NOALIGN.
> 
> The common tail .L_restore is put inside SYM_CODE_START_LOCAL_NOALIGN
> and SYM_CODE_END too.

What is that needed for? It is a local label...

> The result:
>  Value  Size Type    Bind   Vis      Ndx Name
>   0000    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
>   001c    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
>   0038    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
>   0050    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule
>   0068    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra

No difference except alignment:

before:
 70545: ffffffff81001c20    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78965: ffffffff81001c00    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82545: ffffffff81001c80    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86963: ffffffff81001c40    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 88045: ffffffff81001c60    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

after:
 70545: ffffffff81001c10    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_off_thunk
 78965: ffffffff81001bf4    28 FUNC    GLOBAL DEFAULT    1 trace_hardirqs_on_thunk
 82545: ffffffff81001c5c    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule_notra
 86963: ffffffff81001c2c    24 FUNC    GLOBAL DEFAULT    1 lockdep_sys_exit_thunk
 88045: ffffffff81001c44    24 FUNC    GLOBAL DEFAULT    1 ___preempt_schedule

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
