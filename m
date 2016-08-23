From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Tue, 23 Aug 2016 01:17:15 +0100
Message-ID: <20160823001715.GZ2356@ZenIV.linux.org.uk>
References: <CA+55aFyB_r5KMJrYMygdkFw-UdxFUCExQJDL-d2Cd+Sk2+xLrw@mail.gmail.com>
 <CA+55aFx9ih9WX-8iUM95fvbuFJ8hf-dK6vwKsVZPh=fdcSB8Cg@mail.gmail.com>
 <20160821001141.GV2356@ZenIV.linux.org.uk>
 <CA+55aFyYOZ2U=Fb=oGrVzqvKUprFOAdL8Ra7sTw5KhgibvN0pA@mail.gmail.com>
 <20160821045402.GC14857@tucnak.redhat.com>
 <20160821064229.GX2356@ZenIV.linux.org.uk>
 <CA+55aFxq=KPcS2ZOV51XP3eQNuaiWdJv579NRR+QFSx2sRq5Ww@mail.gmail.com>
 <CA+55aFzKkVDuizFBH66s8n0u=1FRSXGPNKun9G8rFHaXw5Lx4w@mail.gmail.com>
 <20F4A326-4107-452C-AF84-385136D9501F@zytor.com>
 <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:58134 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756168AbcHWARW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2016 20:17:22 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzsk220hcPXpdsDN_jWhYHqf-zkyN=BxmvfK9q_jp6W4A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Jakub Jelinek <jakub@redhat.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>

On Mon, Aug 22, 2016 at 04:48:00PM -0700, Linus Torvalds wrote:
> On Mon, Aug 22, 2016 at 4:12 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> >
> > How about the gcc native __builtin_setjmp stuff which is supposedly better?
> 
> How new is it? The whole point was that we'd not have to worry and
> wait for gcc features..

Sat Jan 27 07:59:25 1996  Richard Kenner  (kenner@vlsi1.ultra.nyu.edu)

        * tree.h (enum built_in_function): Add BUILT_IN_{SET,LONG}JMP.
        * expr.c: Include hard-reg-set.h.
        (arg_pointer_save_area): New declaration.
        (expand_builtin, case BUILT_IN_{SET,LONG}JMP): New cases.
        * Makefile.in (expr.o): Includes hard-reg-set.h.
        * c-decl.c (init_decl_processing): Add definitions for
        __builtin_setjmp and __builtin_longjmp.
        * cccp.c (initialize_builtins): Add def of __HAVE_BUILTIN_SETJMP__.

        * expr.c (expand_expr, case COMPONENT_REF): Pass EXPAND_INITIALIZER
        to recursive call.

IOW - old; the last branch lacking it is 2.7.2.*  Both 2.8 and egcs (and thus
2.95 and everything subsequent) have it.
