From: Jonas Bonn <jonas.bonn@gmail.com>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Fri, 9 Sep 2011 22:15:20 +0200
Message-ID: <CACM3HyGvJQABO3Hi6e+yH+Xoi+S+fctGrH3w4Jm7=zqtnPTXTQ@mail.gmail.com>
References: <20110909010847.294039464@codeaurora.org>
	<20110909010916.525482401@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010916.525482401@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>, arnd@arndb.de
List-Id: linux-arch.vger.kernel.org

On 9 September 2011 03:09, Richard Kuo <rkuo@codeaurora.org> wrote:
> +long arch_ptrace(struct task_struct *child, long request,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned lon=
g addr, unsigned long data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 void __user *udata =3D (void __user *) data;
> +
> + =C2=A0 =C2=A0 =C2=A0 switch (request) {
> + =C2=A0 =C2=A0 =C2=A0 case PTRACE_POKETEXT: =C2=A0 /* write the word=
 at location addr. */
> + =C2=A0 =C2=A0 =C2=A0 case PTRACE_POKEDATA:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return generic_ptr=
ace_pokedata(child, addr, data);
> + =C2=A0 =C2=A0 =C2=A0 case PTRACE_POKEUSR: =C2=A0 =C2=A0/* write reg=
ister specified by addr. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ptrace_poke=
usr(child, addr, data);
> + =C2=A0 =C2=A0 =C2=A0 case PTRACE_GETREGS:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return copy_regset=
_to_user(child, &hexagon_user_view,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0REGSET_GPR, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0sizeof(struct user_regs_struct),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0udata);
> + =C2=A0 =C2=A0 =C2=A0 case PTRACE_SETREGS:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return copy_regset=
_from_user(child, &hexagon_user_view,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0REGSET_GPR, 0,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0sizeof(struct user_regs_struct),
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0udata);
> + =C2=A0 =C2=A0 =C2=A0 default:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ptrace_requ=
est(child, request, addr, data);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
>

I think that... other than for compatibility with legacy userspace
code, you shouldn't need any of these cases other than the 'default'.

PTRACE_GETREGS is replaced by PTRACE_GETREGSET and this is handled in
generic code.  POKETEXT, POKEDATA are handled in the generic code.
POKEUSR can also be done via the SETREGSET mechanism.

That said, I don't think gdbserver has been updated to use
GETREGSET/SETREGSET.  This is a bit like the uClibc/glibc issue,
though... somebody just needs to do the work to make userspace work
with the new, "clean" kernel interface.

Given all that, you shouldn't need to export pt_regs to userspace
either.  You already have a user_regs_struct which is userspace's view
of the process registers.  For OpenRISC we made pt_regs a kernel
private structure, giving us the freedom to change the stack layout of
the registers in the future while providing a stable view for
userspace.  I would suggest doing the same here.

If you do decide to make pt_regs private, you'll need to change your
struct sigcontext to use user_regs_struct, as well.

/Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-hexagon=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
