From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [PATCH 1/many] PROC macro to annotate functions in assembly
	files
Date: Wed, 17 Dec 2008 20:38:24 +0300
Message-ID: <20081217173824.GF8078@localhost>
References: <1229505475-10219-1-git-send-email-heukelum@fastmail.fm> <1229505475-10219-2-git-send-email-heukelum@fastmail.fm> <20081217172640.GB5436@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753833AbYLQRin@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081217172640.GB5436@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, linux-arch@vger.kernel.org, Alexander van Heukelum <heukelum@mailshack.com>, Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

[Sam Ravnborg - Wed, Dec 17, 2008 at 06:26:40PM +0100]
| On Wed, Dec 17, 2008 at 10:17:54AM +0100, Alexander van Heukelum wrote:
| > Introduce the PROC macro in the generic header file
| > include/linux/linkage.h to annotate functions in assembly
| > files. This is a first step to fully annotate functions
| > (procedures) in .S-files. The PROC macro complements the
| > already existing and being used ENDPROC macro. The generic
| > implementation of PROC is exactly the same as ENTRY.
| > 
| > The goal is to annotate functions, at least those called
| > from C code, with PROC at the beginning and ENDPROC at the
| > end. This is for the benefit of debugging and tracing. It
| > will also allow to introduce a framework to check for
| > nesting problems and missing annotations in a later stage
| > by overriding ENTRY/END and PROC/ENDPROC in architecture-
| > specific code, after the annotation errors have been fixed.
| > 
| > Signed-off-by: Alexander van Heukelum <heukelum@fastmail.fm>
| > Cc: Sam Ravnborg <sam@ravnborg.org>
| > Cc: Andrew Morton <akpm@linux-foundation.org>
| 
| I understand where you are coming from with these.
| But what I see now is:
| 
| ENTRY/END
| PROC/ENDPROC
| KPROBE_ENTRY/KPROBE_END
| 
| And it is not obvious for me reading the comment when I should
| expect which one to be used.
| 
| Could we try to keep it down to two variants?
| And then document when to use which one.
| 
| 	Sam
| 

Sam, I think eventually we should get something like this:

- KPROBE will be eliminated and explicit section descriptions
  are to be used
- ENTRY could be used / or renamed for something more descriptive
  and being used aligned jmp targets or in case of procs with
  shared body
- PROC/ENDPROC are to replace old ENTRY/END for procs being called
  mostly from C code

Did I miss something? Does it sound like a good/bad plan?

		- Cyrill -
