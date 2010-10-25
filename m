From: "Jan Beulich" <JBeulich@novell.com>
Subject: Re: [PATCH] Partially revert patch that encloses asm-offset.h
	 numbers in brackets
Date: Mon, 25 Oct 2010 15:34:41 +0100
Message-ID: <4CC5B1A1020000780001EF7C@vpn.id2.novell.com>
References: <20101025140218.5092.74117.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20101025140218.5092.74117.stgit@warthog.procyon.org.uk>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org, torvalds@osdl.org, David Howells <dhowells@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, Alexander van Heukelum <heukelum@fastmail.fm>, "H. Peter Anvin" <hpa@linux.intel.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

>>> On 25.10.10 at 16:02, David Howells <dhowells@redhat.com> wrote:
> Partially revert patch:
> 
> 	commit 3234282f33b29d349bcada40204fc7c8fda7fe72
> 	Author: Jan Beulich <JBeulich@novell.com>
> 	Date:   Tue Oct 19 14:52:26 2010 +0100
> 	x86, asm: Fix CFI macro invocations to deal with shortcomings in gas

No, that's not going to work for x86. You're removing the parentheses
again, which were added intentionally.

> This breaks MN10300 arch as this changes many instances of instructions
> similar to the following:
> 
> 	MOV	number,D0
> 
> which represents an immediate value load into:
> 
> 	MOV	(number),D0
> 
> which the assembler then interprets as a load from absolute address.
> 
> arch/mn10300/kernel/entry.S:64: Error: Invalid opcode/operands
> arch/mn10300/kernel/entry.S:65: Error: junk at end of line, first 
> unrecognized character is `0'
> arch/mn10300/kernel/entry.S:74: Error: Invalid opcode/operands
> arch/mn10300/kernel/entry.S:74: Error: junk at end of line, first 
> unrecognized character is `1'
> arch/mn10300/kernel/entry.S:75: Error: Invalid opcode/operands
> arch/mn10300/kernel/entry.S:76: Error: junk at end of line, first 
> unrecognized character is `0'

Isn't this a gas bug then? Anywhere you use a plain number you
should also be permitted to use an expression.

> cc: Jan Beulich <jbeulich@novell.com>
> cc: Alexander van Heukelum <heukelum@fastmail.fm>
> cc: H. Peter Anvin <hpa@linux.intel.com>
> cc: Ingo Molnar <mingo@elte.hu>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  Kbuild |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/Kbuild b/Kbuild
> index 431f7ca..b00037a 100644
> --- a/Kbuild
> +++ b/Kbuild
> @@ -53,7 +53,7 @@ targets += arch/$(SRCARCH)/kernel/asm-offsets.s
>  # Default sed regexp - multiline due to syntax constraints
>  define sed-y
>  	"/^->/{s:->#\(.*\):/* \1 */:; \
> -	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 (\2) /* \3 */:; \
> +	s:^->\([^ ]*\) [\$$#]*\([-0-9]*\) \(.*\):#define \1 \2 /* \3 */:; \

This basically gets us back to the way things were before, thus
reverting to the state we had before the patch that changed this.

>  	s:^->\([^ ]*\) [\$$#]*\([^ ]*\) \(.*\):#define \1 \2 /* \3 */:; \
>  	s:->::; p;}"
>  endef

Jan
