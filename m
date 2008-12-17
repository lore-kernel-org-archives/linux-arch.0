From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/many] PROC macro to annotate functions in assembly files
Date: Wed, 17 Dec 2008 18:26:40 +0100
Message-ID: <20081217172640.GB5436@uranus.ravnborg.org>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1229505475-10219-2-git-send-email-heukelum@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754428AbYLQRZl@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1229505475-10219-2-git-send-email-heukelum@fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexander van Heukelum <heukelum@fastmail.fm>
Cc: linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 17, 2008 at 10:17:54AM +0100, Alexander van Heukelum wrote:
> Introduce the PROC macro in the generic header file
> include/linux/linkage.h to annotate functions in assembly
> files. This is a first step to fully annotate functions
> (procedures) in .S-files. The PROC macro complements the
> already existing and being used ENDPROC macro. The generic
> implementation of PROC is exactly the same as ENTRY.
> 
> The goal is to annotate functions, at least those called
> from C code, with PROC at the beginning and ENDPROC at the
> end. This is for the benefit of debugging and tracing. It
> will also allow to introduce a framework to check for
> nesting problems and missing annotations in a later stage
> by overriding ENTRY/END and PROC/ENDPROC in architecture-
> specific code, after the annotation errors have been fixed.
> 
> Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

I understand where you are coming from with these.
But what I see now is:

ENTRY/END
PROC/ENDPROC
KPROBE_ENTRY/KPROBE_END

And it is not obvious for me reading the comment when I should
expect which one to be used.

Could we try to keep it down to two variants?
And then document when to use which one.

	Sam
