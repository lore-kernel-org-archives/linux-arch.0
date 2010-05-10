From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC][PATCH resend 8/12] asm-generic: bitops: introduce le bit offset macro
Date: Mon, 10 May 2010 14:01:51 +0200
Message-ID: <201005101401.52182.arnd@arndb.de>
References: <20100504215645.6448af8f.takuya.yoshikawa@gmail.com> <201005061538.54326.arnd@arndb.de> <4BE7F22E.9070504@oss.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4BE7F22E.9070504-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
Sender: kvm-ppc-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Takuya Yoshikawa <yoshikawa.takuya-gVGce1chcLdL9jVzuh4AOg@public.gmane.org>
Cc: Takuya Yoshikawa <takuya.yoshikawa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Avi Kivity <avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, fernando-gVGce1chcLdL9jVzuh4AOg@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Monday 10 May 2010, Takuya Yoshikawa wrote:
> (2010/05/06 22:38), Arnd Bergmann wrote:
> > On Wednesday 05 May 2010, Takuya Yoshikawa wrote:
> >> There was a suggestion to propose set_le_bit_user() kind of macros.
> >> But what I thought was these have a constraint you two explained and seemed to be
> >> a little bit specific to some area, like KVM.
> >>
> >> So I decided to propose just the offset calculation macro.
> >
> > I'm not sure I understand how this macro is going to be used though.
> > If you are just using this in kernel space, that's fine, please go for
> > it.
> 
> Yes, I'm just using in kernel space: qemu has its own endian related helpers.
> 
> So if you allow us to place this macro in asm-generic/bitops/* it will help us.

No problem at all then. Thanks for the explanation.

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
