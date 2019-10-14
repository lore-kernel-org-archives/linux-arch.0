From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v9 03/28] x86/asm: Annotate relocate_kernel_{32,64}.c
Date: Mon, 14 Oct 2019 15:15:01 +0200
Message-ID: <20191014131501.GB4715@zn.tnic>
References: <20191011115108.12392-1-jslaby@suse.cz>
 <20191011115108.12392-4-jslaby@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191011115108.12392-4-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 11, 2019 at 01:50:43PM +0200, Jiri Slaby wrote:
> There are functions in relocate_kernel_{32,64}.c which are not
> annotated. This makes automatic works on them rather hard. So annotate

Restoring from the previous version: s/works/annotations/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
