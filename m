From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/8] kernel: move arches that use the generic_le/be
	helpers
Date: Thu, 10 Apr 2008 13:43:02 -0700
Message-ID: <1207860182.22001.40.camel@brick>
References: <1207856648.22001.28.camel@brick>
	 <20080410203708.GA28014@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080410203708.GA28014-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, 2008-04-10 at 21:37 +0100, Ralf Baechle wrote:
> On Thu, Apr 10, 2008 at 12:44:08PM -0700, Harvey Harrison wrote:
> 
> Btw, you may want to look at the current MIPS implementation of
> get_unaligned and put_unaligned.  It's pure C and at least on MIPS it
> produces somewhat shorter code and the source is definately much
> shorter since it exploits the compiler's cleverness.
> 
>   Ralf

Yeah, the only reason I did not is that many arches intentionally bug
during the linking process when the argument size is not 1,2,4,8 whereas
some do not...it would be nice to get a decision on what is the right
answer.

Also, I saw the mips version, what would you think of moving to the
no_builtin_memcpy version from my patchset...or just look at
h3800, xtensa, or m32r arch implementations currently in tree.

Cheers,

Harvey
