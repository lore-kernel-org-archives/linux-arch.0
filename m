From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Date: Mon, 28 Apr 2008 15:25:27 +0100
Message-ID: <18470.1209392727@redhat.com>
References: <1209219236.3113.6.camel@localhost.localdomain> <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-2-git-send-email-jens.axboe@oracle.com> <20080425231100.b93a1601.akpm@linux-foundation.org>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1209219236.3113.6.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jens Axboe <jens.axboe-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, npiggin-l3A5Bk7waGM@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org, "Paul E. McKenney" <paulmck-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>

James Bottomley <James.Bottomley-d9PhHud1JfjCXq6kfMZ53/egYHeGw8Jk@public.gmane.org> wrote:

> Erm, that's a bug in the frv toolchain, isn't it?  The linker should
> *never* rely on C code annotation for jump lengths ... mainly because
> you can screw it all up again in the linker script, so the sectional
> annotations should only be in the function body (think
> -ffunction-sections)

The problem with FRV has to do with global variables, not functions.

With FRV, we attempt to pack as many small variables into the "small data
section" (.sdata) as we can, and then retain a pointer to it in a register.
Thus for small variables, we can use a single instruction, such as:

	LDI	@(GR16,%gprel(my_variable)),GRx

to access it.  However, this limits the offset of my_variable to be +/-2048
from GR16 because all the instructions are the same size, and that's the size
of the offset field therein.

Alternatively, we can use:

	SETHI.P	%hi(my_variable),GRy
	SETLO	%lo(my_variable),GRy
	LD	@(GRy,GR0),GRx

which obviously takes two more instructions, although they can be executed
simultaneously, and 8 more bytes of RAM/icache.

However, the compiler will assume that it should access _all_ global variables
using GPREL-addressing unless it is told otherwise.  This means that if a
global variable should not be GPREL-addressed, its *declaration* should be
annotated, as this affects how it is addressed.  Furthermore, if the variable
is *defined* in C, that definition should be annotated the same as the
declaration, otherwise it'll eat storage from .sdata rather than the
appropriate section.


Global functions are another matter.  The FRV's PC+offset call and branch
instructions have 24-bit displacements, which is fine for leaping about within
the kernel core with a single instruction.

In modules, we instead (a) suppress GPREL addressing entirely because we can't
put module variables in .sdata, and (b) make all interfunction jumps that the
assembler can't resolve into:

	SETHI.P	%hi(that_function),GRy
	SETLO	%lo(that_function),GRy
	JMPL	@(GRy,GR0)

because a 24-bit offset can only span 16MB, which isn't far enough.


We could use a GOT, but I believe that would add an extra memory access to any
memory access or jump - which I'd prefer to avoid.

David
