Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:44736 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfJNNPM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Oct 2019 09:15:12 -0400
Date: Mon, 14 Oct 2019 15:15:01 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 03/28] x86/asm: Annotate relocate_kernel_{32,64}.c
Message-ID: <20191014131501.GB4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-4-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191014131501.Wq5fyOvSWlsxsfb-H-3JokkLjPJ68-6Gg3mOpcLAET0@z>

On Fri, Oct 11, 2019 at 01:50:43PM +0200, Jiri Slaby wrote:
> There are functions in relocate_kernel_{32,64}.c which are not
> annotated. This makes automatic works on them rather hard. So annotate

Restoring from the previous version: s/works/annotations/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
