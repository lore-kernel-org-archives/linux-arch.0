From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit offset macro
Date: Thu, 6 May 2010 15:38:54 +0200
Message-ID: <201005061538.54326.arnd@arndb.de>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com> <4BE04677.4060608@redhat.com> <20100505115924.7bb92036.takuya.yoshikawa@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20100505115924.7bb92036.takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Wednesday 05 May 2010, Takuya Yoshikawa wrote:
> Date: 
> Yesterday 04:59:24
> > That's why the bitmaps are defined as little endian u64 aligned, even on 
> > big endian 32-bit systems.  Little endian bitmaps are wordsize agnostic, 
> > and u64 alignment ensures we can use long-sized bitops on mixed size 
> > systems.

Ok, I see.

> There was a suggestion to propose set_le_bit_user() kind of macros.
> But what I thought was these have a constraint you two explained and seemed to be
> a little bit specific to some area, like KVM.
> 
> So I decided to propose just the offset calculation macro.

I'm not sure I understand how this macro is going to be used though.
If you are just using this in kernel space, that's fine, please go for
it.

However, if the intention is to use the same macro in user space, putting
it into asm-generic/bitops/* is not going to help, because those headers
are not available in user space, and I wouldn't want to change that.

The definition of the macro is not part of the ABI, so just duplicate
it in KVM if you need it there.

	Arnd
